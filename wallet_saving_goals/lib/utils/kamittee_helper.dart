import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:wallet_saving_goals/admin/admin_ongoing_details.dart';
import 'package:wallet_saving_goals/chat/chat_room.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/screen/components/invitation_card.dart';
import 'package:wallet_saving_goals/screen/components/kamittee_card.dart';
import 'package:wallet_saving_goals/screen/home/my_kamittee_details.dart';
import 'package:wallet_saving_goals/screen/home/ongoing_kamittee_details.dart';
import 'package:wallet_saving_goals/screen/home/view_kamittee_joining_details.dart';
import 'package:wallet_saving_goals/utils/chat_helper.dart';
import 'package:wallet_saving_goals/utils/contacts_helper.dart';

class KamitteeHelper extends GetxController {
  Future<String> uploadImage(File thumbnailPath) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('kamitte_records')
        .child(FirebaseAuth.instance.currentUser.uid +
            '_' +
            p.basename(thumbnailPath.path))
        .putFile(File(thumbnailPath.path));
    return taskSnapshot.ref.getDownloadURL();
  }

  static KamitteeHelper get to => Get.find<KamitteeHelper>();
  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );
    return result;
  }

  String imagePath;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imagePath = pickedFile.path;
      update();
      return await compressImage(imagePath, 35);
    }
  }

  Future<Widget> getKamitteeRecords(context) async {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('kamittee').get().then(
      (value) {
        for (var item in value.docs) {
          if (item.data()['members_list'].contains(user.uid)) {
            x.add(
              KamitteeCard(
                amount: item.data()['kamittee_amount'],
                duration: item.data()['kamittee_duration'],
                members:
                    '${item.data()['members_total']}/${item.data()['members_needed']}',
                title: item.data()['kamittee_purpose'],
                kamitteeDetails: item.data(),
                kamitteeId: item.id,
                onPressed: () {
                  Get.to(
                    ViewKamitteeDetails(
                      kamitteeDetails: item.data(),
                      kamitteeId: item.id,
                    ),
                  );
                },
              ),
            );
          } else {
            x.add(
              KamitteeCard(
                amount: item.data()['kamittee_amount'],
                duration: item.data()['kamittee_duration'],
                members:
                    '${item.data()['members_total']}/${item.data()['members_needed']}',
                title: item.data()['kamittee_purpose'],
                kamitteeDetails: item.data(),
                kamitteeId: item.id,
                onPressed: () {
                  Get.to(
                    MyKamitteeDetails(
                      kamitteeDetails: item.data(),
                      kamitteeId: item.id,
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
    return x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Expanded(
            child: Center(
              child: Text('No Kamittee Found'),
            ),
          );
  }

  Future<Widget> getOngoingKamitteeRecords(context) async {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('ongoing_kamittees').get().then(
      (value) {
        for (var item in value.docs) {
          for (var data in item.data()['kamittes']) {
            if (data['member_id'] == user.uid) {
              x.add(
                KamitteeCard(
                  amount: item.data()['kamittee_amount'],
                  duration: item.data()['kamittee_duration'],
                  members:
                      '${item.data()['members_total']}/${item.data()['members_needed']}',
                  title: item.data()['kamittee_purpose'],
                  kamitteeDetails: item.data(),
                  kamitteeId: item.id,
                  onPressed: () {
                    Get.to(
                      OngoingDetails(
                        kamitteeDetails: item.data(),
                        kamitteeId: item.id,
                      ),
                    );
                  },
                ),
              );
            }
          }
        }
      },
    );
    return x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Expanded(
            child: Center(
              child: Text('No Kamittee Found'),
            ),
          );
  }

  Future<Widget> getAdminOngoingKamitteeRecords(context) async {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('ongoing_kamittees').get().then(
      (value) {
        for (var item in value.docs) {
          x.add(
            KamitteeCard(
              amount: item.data()['kamittee_amount'],
              duration: item.data()['kamittee_duration'],
              members:
                  '${item.data()['members_total']}/${item.data()['members_needed']}',
              title: item.data()['kamittee_purpose'],
              kamitteeDetails: item.data(),
              kamitteeId: item.id,
              onPressed: () {
                Get.to(
                  AdminOngoingDetails(
                    kamitteeDetails: item.data(),
                    kamitteeId: item.id,
                  ),
                );
              },
            ),
          );
        }
      },
    );
    return x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Expanded(
            child: Center(
              child: Text('No Kamittee Found'),
            ),
          );
  }

  Stream<Widget> getAllKamitteeRecords(context, referalCode) async* {
    List<Map<String, dynamic>> x = [];
    await FirebaseFirestore.instance.collection('kamittee').get().then(
      (value) {
        for (var item in value.docs) {
          x.add(item.data()..addAll({'id': item.id}));
        }
      },
    );
    yield x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (referalCode.isEmpty) {
                return InvitationCard(
                  amount: x[index]['kamittee_amount'],
                  duration: x[index]['kamittee_duration'],
                  members:
                      '${x[index]['members_total']}/${x[index]['members_needed']}',
                  title: x[index]['kamittee_purpose'],
                  kamitteeDetails: x[index],
                  kamitteeId: x[index]['id'],
                );
              } else if (x[index]['referral_code']
                  .toString()
                  .startsWith(referalCode)) {
                return InvitationCard(
                  amount: x[index]['kamittee_amount'],
                  duration: x[index]['kamittee_duration'],
                  members:
                      '${x[index]['members_total']}/${x[index]['members_needed']}',
                  title: x[index]['kamittee_purpose'],
                  kamitteeDetails: x[index],
                  kamitteeId: x[index]['id'],
                );
              } else {
                return Container();
              }
            },
          )
        : Expanded(
            child: Center(
              child: Text(
                'No Kamittee Found',
                style: TextStyle(
                  color: AppColor.secondary,
                ),
              ),
            ),
          );
  }

  Stream<Widget> getKamitteeMembers(context, kamitteeId) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('kamittee')
        .doc(kamitteeId)
        .get()
        .then(
      (value) async {
        for (var item in value.data()['members_list']) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item)
              .get()
              .then((userData) {
            x.add(
              ListTile(
                dense: true,
                leading:
                    CircleAvatar(child: Text(userData.data()['username'][0])),
                title: Text(userData.data()['username']),
                subtitle: Text(userData.data()['email']),
              ),
            );
          });
        }
      },
    );
    yield x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Expanded(
            child: Center(
              child: Text('No Kamittee Found'),
            ),
          );
  }

  Stream<Widget> getOngoingKamitteeMembers(context, kamitteeId, hostId) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('ongoing_kamittees')
        .doc(kamitteeId)
        .get()
        .then(
      (value) async {
        for (var item in value.data()['kamittes']) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item['member_id'])
              .get()
              .then(
            (userData) {
              x.add(
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        item['kamittee_no'].toString(),
                      ),
                    ),
                    trailing: Card(
                      color: AppColor.fonts,
                      child: item['member_id'] == hostId
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Host',
                                style: TextStyle(
                                  color: AppColor.white,
                                ),
                              ),
                            )
                          : Text(''),
                    ),
                    title: Text(userData.data()['username'].toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userData.data()['email'].toString()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            item['member_id'] != user.uid
                                ? IconButton(
                                    onPressed: () {
                                      ContactHelper().callNumber(
                                          context, userData.data()['phone_no']);
                                    },
                                    icon: Icon(Icons.call),
                                  )
                                : SizedBox(),
                            item['member_id'] != user.uid
                                ? IconButton(
                                    onPressed: () {
                                      String roomId = ChatHelper()
                                          .chatRoomId(userData.id, user.uid);
                                      Get.to(
                                        ChatRoom(
                                          userMap: userData.data(),
                                          chatRoomId: roomId,
                                          phoneNumber:
                                              userData.data()['phone_no'],
                                        ),
                                      );
                                    },
                                    icon: Icon(FontAwesome.chat_empty),
                                  )
                                : SizedBox(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Text(
                                item['status'] == '0' ? 'Un-paid' : 'Paid',
                                style: TextStyle(
                                  color: item['status'] == '0'
                                      ? AppColor.red
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
    yield x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Expanded(
            child: Center(
              child: Text('No Kamittee Found'),
            ),
          );
  }

  Future initiateKamittee(context, kamitteeId) async {
    Components.showAlertDialog(context);
    List<String> kamitteeMembers = [];
    List<Map<String, dynamic>> allocatedKamittees = [];
    Map<String, dynamic> kamitteeData = {};
    await FirebaseFirestore.instance
        .collection('kamittee')
        .doc(kamitteeId)
        .get()
        .then((value) {
      kamitteeMembers.add(value.data()['host_id']);
      for (var item in value.data()['members_list']) {
        kamitteeMembers.add(item);
      }
      kamitteeMembers.shuffle();
      for (var i = 0; i < kamitteeMembers.length; i++) {
        allocatedKamittees.add({
          'member_id': kamitteeMembers[i],
          'kamittee_no': i + 1,
          'status': '0',
        });
      }

      kamitteeData = {
        'current_turn' : '1',
        'host_id': value.data()['host_id'],
        'kamittee_amount': value.data()['kamittee_amount'],
        'kamittee_duration': value.data()['kamittee_duration'],
        'starting_date': value.data()['starting_date'],
        'host_cnic_front': value.data()['host_cnic_front'],
        'host_cnic_back': value.data()['host_cnic_back'],
        'host_selfie': value.data()['host_selfie'],
        'kamittee_purpose': value.data()['kamittee_purpose'],
        'members_total': value.data()['members_total'],
        'members_needed': value.data()['members_needed'],
        'kamittes': allocatedKamittees,
      };
    }).whenComplete(() async {
      await FirebaseFirestore.instance
          .collection('ongoing_kamittees')
          .doc()
          .set(kamitteeData)
          .whenComplete(() async {
        await FirebaseFirestore.instance
            .collection('kamittee')
            .doc(kamitteeId)
            .delete()
            .whenComplete(() {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Components.showSnackBar(
              context, 'Your kamittee Initiated Successfully');
        });
      });
    });
  }
}
