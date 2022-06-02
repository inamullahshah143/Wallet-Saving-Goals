// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:wallet_saving_goals/constants/color.dart';

class GetMessages extends StatelessWidget {
  GetMessages({@required this.chatRoomId, Key key}) : super(key: key);

  final String chatRoomId;
  User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  getSenderView(
    BuildContext context,
    String message,
    String type,
    String messageId,
  ) =>
      GestureDetector(
        onLongPress: () {
          copyToClipboard(context, message);
        },
        child: ChatBubble(
          clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 10),
          backGroundColor: AppColor.appThemeColor,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );

  getReceiverView(BuildContext context, String message, String type) =>
      GestureDetector(
        onLongPress: () {
          copyToClipboard(context, message);
        },
        child: ChatBubble(
          clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 10),
          backGroundColor: AppColor.fonts,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('chat_room')
            .doc(chatRoomId)
            .collection('chat')
            .orderBy("createdAt")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              shrinkWrap: true,
              primary: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                QueryDocumentSnapshot queryDocumentSnapshot =
                    snapshot.data.docs[index];
                return queryDocumentSnapshot['author']['id'] != user.uid
                    ? getReceiverView(context, queryDocumentSnapshot['text'],
                        queryDocumentSnapshot['type'])
                    : getSenderView(
                        context,
                        queryDocumentSnapshot['text'],
                        queryDocumentSnapshot['type'],
                        queryDocumentSnapshot['id'],
                      );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> copyToClipboard(context, text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
}
