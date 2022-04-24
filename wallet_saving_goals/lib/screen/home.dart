import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);
  final bottomIndex = 1.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: AppColor.fonts,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: AppColor.fonts,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            return bottomIndex.value == 0
                ? Container()
                : bottomIndex.value == 1
                    ? Container()
                    : bottomIndex.value == 2
                        ? Container()
                        : Container();
          },
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: 1,
        tabs: [
          TabData(iconData: Icons.favorite, title: "Projects"),
          TabData(iconData: FontAwesome.home, title: "Home"),
          TabData(iconData: Icons.person, title: "Profile")
        ],
        onTabChangedListener: (position) {
          bottomIndex.value = position;
        },
      ),
    );
  }
}
