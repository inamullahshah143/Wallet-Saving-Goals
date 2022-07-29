import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/auth/splash_screen.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/screen/inbox_screen.dart';
import 'package:wallet_saving_goals/screen/profile.dart';
import 'package:wallet_saving_goals/screen/transaction_history.dart';
import 'package:wallet_saving_goals/utils/auth_helper.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    prefs.getString('Username'),
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.fonts,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    prefs.getString('Email'),
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                  Get.to(Profile());
                },
                leading: Icon(
                  Icons.person_outlined,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Edit Profile'),
              ),
              prefs.getString('UserType') == 'host'
                  ? ListTile(
                      onTap: () {
                        ZoomDrawer.of(context).close();
                        CoolAlert.show(
                          context: context,
                          confirmBtnColor: AppColor.appThemeColor,
                          barrierDismissible: false,
                          type: CoolAlertType.confirm,
                          text: 'you want to switch to the holder',
                          onConfirmBtnTap: () {
                            prefs.setString('UserType', 'holder');
                            Get.off(SplashScreen());
                          },
                          confirmBtnText: 'Switch',
                          backgroundColor: AppColor.fonts,
                          showCancelBtn: true,
                        );
                      },
                      leading: Icon(
                        Icons.swipe,
                        color: AppColor.fonts,
                        size: 20,
                      ),
                      title: Text('Switch to Holder'),
                    )
                  : ListTile(
                      onTap: () {
                        ZoomDrawer.of(context).close();
                        CoolAlert.show(
                          context: context,
                          confirmBtnColor: AppColor.appThemeColor,
                          barrierDismissible: false,
                          type: CoolAlertType.confirm,
                          text: 'you want to switch to the host',
                          onConfirmBtnTap: () {
                            prefs.setString('UserType', 'host');
                            Get.off(SplashScreen());
                          },
                          confirmBtnText: 'Switch',
                          backgroundColor: AppColor.fonts,
                          showCancelBtn: true,
                        );
                      },
                      leading: Icon(
                        Icons.swipe,
                        color: AppColor.fonts,
                        size: 20,
                      ),
                      title: Text('Switch to Host'),
                    ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                  Get.to(InboxScreen());
                },
                leading: Icon(
                  FontAwesome.chat_empty,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Messages'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                },
                leading: Icon(
                  Icons.share,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Share'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                },
                leading: Icon(
                  Icons.policy_outlined,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Privacy Policy'),
              ),
              ListTile(
                onTap: () {
                  Get.to(TransactionHistory());
                },
                leading: Icon(
                  Icons.money_rounded,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Transaction History'),
              ),
              ListTile(
                onTap: () {
                  ZoomDrawer.of(context).close();
                  CoolAlert.show(
                    context: context,
                    backgroundColor: AppColor.fonts,
                    confirmBtnColor: AppColor.appThemeColor,
                    barrierDismissible: false,
                    type: CoolAlertType.confirm,
                    text: 'you want to Logout?',
                    onConfirmBtnTap: () async {
                      Components.showAlertDialog(context);
                      await AuthenticationHelper().signOut().whenComplete(() {
                        Timer(const Duration(seconds: 3), () {
                          Navigator.of(context).pop();
                          prefs.clear();
                          Get.offAll(SplashScreen());
                        });
                      });
                    },
                    confirmBtnText: 'Logout',
                    showCancelBtn: true,
                  );
                },
                leading: Icon(
                  Icons.logout_outlined,
                  color: AppColor.red,
                  size: 20,
                ),
                title: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
