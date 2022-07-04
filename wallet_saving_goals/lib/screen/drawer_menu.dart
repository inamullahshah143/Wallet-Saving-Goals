// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/home/holder_home.dart';
import 'components/components.dart';
import 'components/menu_screen.dart';
import 'home/host_home.dart';

class MenuDrawer extends StatefulWidget {
  MenuDrawer({Key key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  final String initialCountry = 'PK';
  final PhoneNumber number = PhoneNumber(isoCode: 'PK', dialCode: '0');
  final TextEditingController phoneNo = TextEditingController();
  final isValidNo = true.obs;
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      if (prefs.getString('PhoneNo') == 'null') {
        CoolAlert.show(
          context: context,
          backgroundColor: AppColor.fonts,
          confirmBtnColor: AppColor.appThemeColor,
          barrierDismissible: false,
          type: CoolAlertType.custom,
          widget: Padding(
            padding: const EdgeInsets.all(5.0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {},
              onInputValidated: (bool value) {
                isValidNo.value = value;
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please enter your phone number';
                } else if (isValidNo.value == false) {
                  return 'please enter valid phone number';
                } else {
                  return null;
                }
              },
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: phoneNo,
              formatInput: false,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputDecoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: AppColor.secondary.withOpacity(0.25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  color: AppColor.fonts.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
            ),
          ),
          title: 'Phone No.',
          text: 'please enter your phone no.',
          onConfirmBtnTap: () async {
            Components.showAlertDialog(context);
            final FirebaseAuth _auth = FirebaseAuth.instance;
            FirebaseFirestore.instance
                .collection('user')
                .doc(_auth.currentUser.uid)
                .update({
              'phone_no': '${number.dialCode}${phoneNo.text}',
            }).whenComplete(() async {
              prefs.setString('PhoneNo', '${number.dialCode}${phoneNo.text}');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Components.showSnackBar(context, 'phone No. updated successfully!');
            });
          },
          confirmBtnText: 'Submit',
          showCancelBtn: true,
        );
      }
    });
    super.initState();
  }

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
