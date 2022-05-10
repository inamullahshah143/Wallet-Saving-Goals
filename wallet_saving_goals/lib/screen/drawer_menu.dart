// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/home/holder_home.dart';
import 'components/menu_screen.dart';
import 'home/host_home.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({Key key}) : super(key: key);
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return prefs.getString('UserType') == 'host'
        ? ZoomDrawer(
            controller: zoomDrawerController,
            borderRadius: 24.0,
            showShadow: true,
            menuBackgroundColor: AppColor.secondary,
            shadowLayer2Color: AppColor.appThemeColor,
            shadowLayer1Color: AppColor.appThemeColor.withOpacity(0.5),
            angle: 0.0,
            drawerShadowsBackgroundColor: Colors.grey[300],
            slideWidth: MediaQuery.of(context).size.width * 0.25,
            menuScreenWidth: MediaQuery.of(context).size.width * 0.75,
            mainScreen: HostHomeScreen(),
            menuScreen: const MenuScreen(),
            style: DrawerStyle.style3,
            moveMenuScreen: false,
          )
        : ZoomDrawer(
            controller: zoomDrawerController,
            borderRadius: 24.0,
            showShadow: true,
            menuBackgroundColor: AppColor.secondary,
            shadowLayer2Color: AppColor.appThemeColor,
            shadowLayer1Color: AppColor.appThemeColor.withOpacity(0.5),
            angle: 0.0,
            drawerShadowsBackgroundColor: Colors.grey[300],
            slideWidth: MediaQuery.of(context).size.width * 0.25,
            menuScreenWidth: MediaQuery.of(context).size.width * 0.75,
            mainScreen: HolderHomeScreen(),
            menuScreen: const MenuScreen(),
            style: DrawerStyle.style3,
            moveMenuScreen: false,
          );
  }
}
