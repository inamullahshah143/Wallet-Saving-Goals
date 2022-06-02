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
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/components/invitation_card.dart';
import 'package:wallet_saving_goals/screen/components/kamittee_card.dart';
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

  Stream<Widget> getKamitteeRecords(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('kamittee')
        .where('members_list', arrayContains: user.uid)
        .where('status', isEqualTo: 1)
        .get()
        .then(
      (value) {
        for (var item in value.docs) {
          x.add(KamitteeCard(
            amount: item.data()['kamittee_amount'],
            duration: item.data()['kamittee_duration'],
            members:
                '${item.data()['members_total']}/${item.data()['members_needed']}',
            title: item.data()['kamittee_purpose'],
            kamitteeDetails: item.data(),
            kamitteeId: item.id,
          ));
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

  Stream<Widget> getAllKamitteeRecords(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('kamittee').get().then(
      (value) {
        for (var item in value.docs) {
          x.add(InvitationCard(
            amount: item.data()['kamittee_amount'],
            duration: item.data()['kamittee_duration'],
            members:
                '${item.data()['members_total']}/${item.data()['members_needed']}',
            title: item.data()['kamittee_purpose'],
            kamitteeDetails: item.data(),
            kamitteeId: item.id,
          ));
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
                title: Text(userData.data()['username']),
                subtitle: Text(userData.data()['email']),
                trailing: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: IconButton(
                          onPressed: () {
                            ContactHelper().callNumber(
                                context, userData.data()['phone_no']);
                          },
                          icon: Icon(
                            Icons.call,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesome.chat_empty,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
}
