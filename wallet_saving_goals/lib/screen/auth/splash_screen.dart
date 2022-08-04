import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallet_saving_goals/admin/admin_dashboard.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/drawer_menu.dart';
import 'package:wallet_saving_goals/utils/push_notification.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user;
  @override
  void initState() {
    PushNotification().requestPermission();
    PushNotification().loadFCM();
    PushNotification().listenFCM();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestStoragePermission();
    });
    user = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 3), () async {
      if (user == null) {
        Get.off(LoginScreen());
      } else {
        if (prefs.getString('Username') == 'Admin') {
          Get.offAll(AdminDashboard());
        } else {
          Get.offAll(MenuDrawer());
        }
      }
    });
    super.initState();
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      await Permission.contacts.request();
    } else {
      await Permission.contacts.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
