import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallet_saving_goals/chat/chat_room.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/utils/chat_helper.dart';
import 'package:wallet_saving_goals/utils/contacts_helper.dart';

class MyContacts extends StatefulWidget {
  const MyContacts({Key key}) : super(key: key);

  @override
  State<MyContacts> createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  List<String> firebaseList = [];
  List<Map<String, dynamic>> contactList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      firebaseList = await ContactHelper().getContacts();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _askPermissions();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      refreshContacts();
    });
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Get.reload();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> refreshContacts() async {
    var contacts = (await ContactsService.getContacts());
    for (final contact in contacts) {
      contactList.add({
        'name': contact.displayName,
        'phone_no': contact.phones.first.value
            .replaceAll('+92', '0')
            .replaceAll(' ', '')
            .replaceAll("-", ''),
      });
    }
    setState(() {
      contactList
          .removeWhere((item) => !firebaseList.contains(item['phone_no']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: contactList.isNotEmpty
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: contactList?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                        child: Text(contactList[index]['name'][0])),
                    title: Text(contactList[index]['name'] ?? ""),
                    subtitle: Text(contactList[index]['phone_no'] ?? ""),
                    trailing: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: IconButton(
                              onPressed: () {
                                ContactHelper().callNumber(
                                    context, contactList[index]['phone_no']);
                              },
                              icon: Icon(
                                Icons.call,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: IconButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .where('phone_no',
                                        isEqualTo: contactList[index]
                                            ['phone_no'])
                                    .get()
                                    .then((value) {
                                  String roomId = ChatHelper().chatRoomId(
                                      value.docs.first.data()['username'],
                                      prefs.getString('Username').toString());
                                  Get.to(
                                    ChatRoom(
                                      holderId: value.docs.first.id,
                                      userMap: value.docs.first.data(),
                                      chatRoomId: roomId,
                                      phoneNumber: contactList[index]
                                          ['phone_no'],
                                    ),
                                  );
                                });
                              },
                              icon: Icon(
                                FontAwesome.chat_empty,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
