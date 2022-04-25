import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';

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
                  radius: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Text(
                    'Username',
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
                    'mail@email.com',
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
              ListTile(
                leading: Icon(
                  Icons.format_list_bulleted_outlined,
                  color: AppColor.fonts,
                  size: 20,
                ),
                title: Text('All Records'),
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
                leading: Icon(
                  Icons.logout_outlined,
                  color: AppColor.red,
                  size: 20,
                ),
                title: Text('Log Out'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
