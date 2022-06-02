import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/chat/chat_room.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/utils/contacts_helper.dart';

class InboxScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColor.fonts,
          ),
        ),
        title: Text(
          'Messages',
          style: TextStyle(
            fontSize: 18,
            color: AppColor.fonts,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: getChat(context),
          builder: ((context, snapshot) {
            return snapshot.data ?? Container();
          }),
        ),
      ),
    );
  }

  Stream<Widget> getChat(context) async* {
    List x = <Widget>[];
    var result = await FirebaseFirestore.instance
        .collection('chat_list')
        .where('host_id', isEqualTo: user.uid)
        .get();

    for (var item in result.docs) {
      x.add(
        Card(
          child: ListTile(
            onTap: () {
              Get.to(
                ChatRoom(
                  holderId: item.data()['holder_id'],
                  userMap: item.data(),
                  chatRoomId: item.data()['chat_room_id'],
                  phoneNumber: item.data()['phone_no'],
                ),
              );
            },
            leading: CircleAvatar(
                        child: Text(item.data()['username'][0])),
            title: Text(item.data()['username']),
            subtitle: Text(item.data()['email']),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () async {
                ContactHelper().callNumber(context, item.data()['phone_no']);
              },
            ),
          ),
        ),
      );
    }

    yield Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: x.length,
        itemBuilder: (context, index) {
          return x[index];
        },
      ),
    );
  }
}
