// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/utils/contacts_helper.dart';
import 'get_messages.dart';

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;
  final String phoneNumber;

  const ChatRoom({
    Key key,
    @required this.userMap,
    @required this.chatRoomId,
    @required this.phoneNumber,
  }) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _message = TextEditingController();

  String messageBody;

  void _handleSendPressed(String message, String type) async {
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.chatRoomId)
        .set({'room_id': widget.chatRoomId});
    await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.chatRoomId)
        .collection('chat')
        .add({
      "author": {
        "firstName": prefs.getString('Username'),
        "id": user.uid,
      },
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "id": const Uuid().v4(),
      "text": message,
      "type": type,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primary,
                  ),
                ),
                title: Text(widget.userMap['username']),
                trailing: IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () async {
                    ContactHelper().callNumber(context, widget.phoneNumber);
                  },
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: GetMessages(chatRoomId: widget.chatRoomId),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 0.5,
                      blurRadius: 0.5,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: TextField(
                        controller: _message,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Type your message',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _handleSendPressed(_message.text, 'text');
                        _message.clear();
                      },
                      icon: Icon(
                        Icons.send,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
