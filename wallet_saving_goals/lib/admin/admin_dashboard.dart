import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:wallet_saving_goals/admin/ongoing_list.dart';
import 'package:wallet_saving_goals/constants/color.dart';

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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
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
                ? Container()
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
            FontAwesome5.users,
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
            "Transactions",
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
