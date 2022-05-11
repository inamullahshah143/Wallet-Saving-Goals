import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/auth/login_screen.dart';
import 'package:wallet_saving_goals/screen/auth/splash_screen.dart';
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
                leading: Icon(
                  Icons.share,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Share'),
              ),
              ListTile(
                leading: Icon(
                  Icons.mail_outline_outlined,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Support'),
              ),
              ListTile(
                leading: Icon(
                  Icons.policy_outlined,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('Privacy Policy'),
              ),
              ListTile(
                onTap: () {
                  CoolAlert.show(
                    context: context,
                    backgroundColor: AppColor.fonts,
                    confirmBtnColor: AppColor.appThemeColor,
                    barrierDismissible: false,
                    type: CoolAlertType.confirm,
                    text: 'you want to Logout?',
                    onConfirmBtnTap: () {
                      AuthenticationHelper().signOut().whenComplete(() {
                        prefs.clear();
                        Get.off(LoginScreen());
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
