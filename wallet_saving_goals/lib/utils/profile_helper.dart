import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';

class ProfileHelper extends GetxController {
  Future<String> uploadProfilePicture(File thumbnailPath) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child('profile_picture')
        .child(FirebaseAuth.instance.currentUser.uid +
            '_' +
            p.basename(thumbnailPath.path))
        .putFile(File(thumbnailPath.path));
    return taskSnapshot.ref.getDownloadURL();
  }

  Future updateProfile(context, data) async {
    try {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .update(data);
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      Components.showSnackBar(context, e.toString());
    }
  }

  static ProfileHelper get to => Get.find<ProfileHelper>();
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

  Future getProfilePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      update();
      return await compressImage(imagePath, 35);
    }
  }
}
