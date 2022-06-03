import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/auth/splash_screen.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/utils/auth_helper.dart';
import 'package:wallet_saving_goals/utils/helper.dart';
import 'package:wallet_saving_goals/utils/profile_helper.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final changePassword = false.obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController username =
      TextEditingController(text: prefs.getString('Username'));

  final TextEditingController email =
      TextEditingController(text: prefs.getString('Email'));

  final TextEditingController phoneNo =
      TextEditingController(text: prefs.getString('PhoneNo'));

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  File profilePicture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColor.fonts,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            color: AppColor.fonts,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.pagesColor,
                      radius: 50,
                      backgroundImage: prefs.getString('ProfilePicture') != null
                          ? Image.network(
                              prefs.getString('ProfilePicture'),
                              fit: BoxFit.fill,
                            ).image
                          : Image.asset(
                              'assets/icons/profile.png',
                              fit: BoxFit.fill,
                            ).image,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        ProfileHelper().getProfilePicture().then((value) {
                          setState(() {
                            profilePicture = value;
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome5.edit,
                            color: AppColor.appThemeColor,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Edit Profile",
                            style: TextStyle(color: AppColor.appThemeColor),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hi there ${prefs.getString('Username')}!",
                      style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.w500, color: AppColor.fonts),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          hintText: "Name",
                          isDense: true,
                          filled: true,
                          fillColor: AppColor.secondary.withOpacity(0.25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                            color: AppColor.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: email,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Email",
                          isDense: true,
                          filled: true,
                          fillColor: AppColor.secondary.withOpacity(0.25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                            color: AppColor.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: phoneNo,
                        decoration: InputDecoration(
                          hintText: "Mobile No",
                          isDense: true,
                          filled: true,
                          fillColor: AppColor.secondary.withOpacity(0.25),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          hintStyle: TextStyle(
                            color: AppColor.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(() {
                        return CheckboxListTile(
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text('I want to change my password'),
                          value: changePassword.value,
                          onChanged: (value) {
                            changePassword.value = value;
                          },
                        );
                      }),
                    ),
                    Obx(
                      () {
                        return changePassword.value == true
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      validator: (value) =>
                                          Helper.validatePassword(value),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: password,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "New Password",
                                        errorMaxLines: 6,
                                        isDense: true,
                                        filled: true,
                                        fillColor: AppColor.secondary
                                            .withOpacity(0.25),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintStyle: TextStyle(
                                          color:
                                              AppColor.fonts.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: confirmPassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'please enter your confirm password';
                                        } else if (value != password.text) {
                                          return 'password doesn\'t match';
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        isDense: true,
                                        filled: true,
                                        fillColor: AppColor.secondary
                                            .withOpacity(0.25),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintStyle: TextStyle(
                                          color:
                                              AppColor.fonts.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Components.showAlertDialog(context);
                          if (formKey.currentState.validate()) {
                            if (changePassword.value == true) {
                              if (profilePicture != null) {
                                await ProfileHelper()
                                    .uploadProfilePicture(profilePicture)
                                    .then((profilePictureUrl) async {
                                  await ProfileHelper().updateProfile(context, {
                                    'username': username.text,
                                    'phone_no': phoneNo.text,
                                    'profile_picture': profilePictureUrl,
                                  }).whenComplete(() async {
                                    await AuthenticationHelper()
                                        .changePassword(
                                            context, confirmPassword.text)
                                        .whenComplete(() async {
                                      await AuthenticationHelper()
                                          .signOut()
                                          .whenComplete(() {
                                        Timer(const Duration(seconds: 3), () {
                                          Navigator.of(context).pop();
                                          prefs.clear();
                                          Get.offAll(SplashScreen());
                                        });
                                      });
                                    });
                                  });
                                });
                              } else {
                                await ProfileHelper().updateProfile(context, {
                                  'username': username.text,
                                  'phone_no': phoneNo.text,
                                }).whenComplete(() async {
                                  await AuthenticationHelper()
                                      .changePassword(
                                          context, confirmPassword.text)
                                      .whenComplete(() async {
                                    await AuthenticationHelper()
                                        .signOut()
                                        .whenComplete(() {
                                      Timer(const Duration(seconds: 3), () {
                                        Navigator.of(context).pop();
                                        prefs.clear();
                                        Get.offAll(SplashScreen());
                                      });
                                    });
                                  });
                                });
                              }
                            } else {
                              if (profilePicture == null) {
                                await ProfileHelper().updateProfile(context, {
                                  'username': username.text,
                                  'phone_no': phoneNo.text,
                                }).whenComplete(() async {
                                  Navigator.of(context).pop();
                                  prefs.setString('Username', username.text);
                                  prefs.setString('PhoneNo', phoneNo.text);
                                  setState(() {});
                                });
                              } else {
                                await ProfileHelper()
                                    .uploadProfilePicture(profilePicture)
                                    .then((profilePictureUrl) async {
                                  await ProfileHelper().updateProfile(context, {
                                    'username': username.text,
                                    'phone_no': phoneNo.text,
                                    'profile_picture': profilePictureUrl,
                                  }).whenComplete(() async {
                                    Navigator.of(context).pop();
                                    prefs.setString('Username', username.text);
                                    prefs.setString('PhoneNo', phoneNo.text);
                                    prefs.setString(
                                        'ProfilePicture', profilePictureUrl);
                                    setState(() {});
                                  });
                                });
                              }
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(AppColor.white),
                          overlayColor: MaterialStateProperty.all<Color>(
                              AppColor.primary.withOpacity(0.1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: AppColor.primary),
                            ),
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomFormImput extends StatelessWidget {
  const CustomFormImput({
    Key key,
    String label,
    String value,
    bool isPassword = false,
  })  : _label = label,
        _value = value,
        _isPassword = isPassword,
        super(key: key);

  final String _label;
  final String _value;
  final bool _isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.only(left: 40),
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: AppColor.secondary.withOpacity(0.25),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: _label,
          contentPadding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
        ),
        obscureText: _isPassword,
        initialValue: _value,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
