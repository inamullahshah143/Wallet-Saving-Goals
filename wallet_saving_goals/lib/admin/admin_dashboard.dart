import 'dart:async';

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/admin/ongoing_list.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/auth/splash_screen.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/utils/auth_helper.dart';

import 'admin_home.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int bottomIndex;
  @override
  void initState() {
    bottomIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: AppColor.pagesColor,
        foregroundColor: AppColor.fonts,
        title: Text(
          'Hello! ' + prefs.getString('Username').toString(),
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
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
            icon: Icon(
              Icons.logout,
              color: AppColor.fonts,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: bottomIndex == 0
            ? OngoingList()
            : bottomIndex == 1
                ? AdminHome()
                : bottomIndex == 2
                    ? Container()
                    : Container(),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Icon(
            FontAwesome5.hand_holding_usd,
            color: AppColor.white,
          ),
          Icon(
            FontAwesome5.home,
            color: AppColor.white,
          ),
          Icon(
            FontAwesome5.money_check,
            color: AppColor.white,
          ),
        ],
        inactiveIcons: [
          Text(
            "Kamittee's",
            style: TextStyle(
              color: AppColor.white,
            ),
          ),
          Text(
            "Home",
            style: TextStyle(
              color: AppColor.white,
            ),
          ),
          Text(
            "Requests",
            style: TextStyle(
              color: AppColor.white,
            ),
          ),
        ],
        color: AppColor.primary,
        height: 50,
        circleWidth: 50,
        initIndex: 1,
        onChanged: (index) {
          setState(() {
            bottomIndex = index;
          });
        },
        shadowColor: AppColor.primary.withOpacity(0.5),
        elevation: 5,
      ),
    );
  }
}
