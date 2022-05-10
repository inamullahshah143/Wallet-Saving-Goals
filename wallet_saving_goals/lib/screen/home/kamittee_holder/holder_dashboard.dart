import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';

class HolderDashboard extends StatelessWidget {
  const HolderDashboard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome to\n',
                    style: TextStyle(
                      color: AppColor.primary.withOpacity(0.5),
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'Kamittee',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Kamittee is an online application that allows you to maintain your kamitties online. \nWith the help of this app, you can get Kamitties records from anywhere in the world.',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColor.fonts,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
