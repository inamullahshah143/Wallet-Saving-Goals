import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/admin/admin_dashboard.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/auth/forget_password.dart';
import 'package:wallet_saving_goals/screen/auth/sign_up_screen.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/screen/drawer_menu.dart';
import 'package:wallet_saving_goals/utils/auth_helper.dart';
import 'package:wallet_saving_goals/utils/helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);
  final isVisible = true.obs;
  final accountType = 'holder'.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final isAdmin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.pagesColor,
        foregroundColor: AppColor.primary,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Default"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Admin"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                isAdmin.value = false;
              } else if (value == 1) {
                isAdmin.value = true;
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Obx(() {
            return !isAdmin.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50.0,
                          left: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'Welcome !',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.fonts.withOpacity(0.75),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Credentials',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    Helper.validateEmail(value),
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  isDense: true,
                                  filled: true,
                                  fillColor:
                                      AppColor.secondary.withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintStyle: TextStyle(
                                    color: AppColor.fonts.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    controller: password,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'please enter your password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    obscureText: isVisible.value,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor:
                                          AppColor.secondary.withOpacity(0.25),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Password',
                                      errorMaxLines: 6,
                                      hintStyle: TextStyle(
                                        color: AppColor.fonts.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          isVisible.value = !isVisible.value;
                                        },
                                        icon: isVisible.value
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: AppColor.fonts,
                                                size: 15,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: AppColor.fonts,
                                                size: 15,
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(ForgetPassword());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColor.fonts,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Obx(
                          () {
                            return RadioListTile(
                              value: 'holder',
                              groupValue: accountType.value,
                              onChanged: (value) {
                                accountType.value = value;
                              },
                              title: Text('Kamitte Holder'),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Obx(
                          () {
                            return RadioListTile(
                              value: 'host',
                              groupValue: accountType.value,
                              onChanged: (value) {
                                accountType.value = value;
                              },
                              title: Text('Kamittee Host'),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              if (accountType.value.isEmpty) {
                                Navigator.of(context).pop();
                                Components.showSnackBar(
                                    context, 'please select user type');
                              } else {
                                Components.showAlertDialog(context);
                                AuthenticationHelper()
                                    .signIn(
                                  email: email.text,
                                  password: password.text,
                                  context: context,
                                )
                                    .then((result) {
                                  if (result != null) {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(result.user.uid)
                                        .get()
                                        .then((value) async {
                                      if (value.data()['username'] != 'Admin') {
                                        prefs.setString('Username',
                                            value.data()['username']);
                                        prefs.setString(
                                            'UserID', result.user.uid);
                                        prefs.setString(
                                            'Email', value.data()['email']);
                                        prefs.setString('PhoneNo',
                                            value.data()['phone_no']);
                                        prefs.setString(
                                            'ProfilePicture',
                                            value
                                                .data()['profile_picture']
                                                .toString());
                                        prefs.setString(
                                            'UserType', accountType.value);
                                        Navigator.of(context).pop();
                                        Components.showSnackBar(
                                            context, 'Wellcome back');
                                        Get.off(MenuDrawer());
                                      } else {
                                        Navigator.of(context).pop();
                                        Components.showSnackBar(context,
                                            'You are not allowed to login from this panel');
                                      }
                                    });
                                  }
                                }).catchError((e) {
                                  Components.showSnackBar(context, e);
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                          },
                          child: Text('Sign In'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                              AppColor.white.withOpacity(0.1),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 45),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'or',
                          style: TextStyle(
                            color: AppColor.fonts.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Components.showAlertDialog(context);
                            if (accountType.value != '') {
                              AuthenticationHelper()
                                  .signInWithGoogle()
                                  .then((value) {
                                if (value != null) {
                                  final FirebaseAuth _auth =
                                      FirebaseAuth.instance;
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(_auth.currentUser.uid)
                                      .set({
                                    'username': value.displayName,
                                    'email': value.email,
                                    'phone_no': value.phoneNumber ?? '',
                                  }).whenComplete(() async {
                                    prefs.setString('Username',
                                        value.displayName.toString());
                                    prefs.setString(
                                        'UserID', value.uid.toString());
                                    prefs.setString(
                                        'Email', value.email.toString());
                                    prefs.setString('PhoneNo',
                                        value.phoneNumber.toString() ?? '');
                                    prefs.setString(
                                        'UserType', accountType.value);
                                    Navigator.of(context).pop();
                                    Components.showSnackBar(
                                        context, 'Wellcome back');
                                    Get.off(MenuDrawer());
                                  });
                                }
                              });
                            } else {
                              Navigator.of(context).pop();
                              Components.showSnackBar(
                                  context, 'please select user type');
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primary),
                            overlayColor: MaterialStateProperty.all<Color>(
                                AppColor.primary.withOpacity(0.1)),
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 45),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: AppColor.primary),
                              ),
                            ),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    FontAwesome.google,
                                  ),
                                ),
                                TextSpan(text: '  '),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Text('Sign In with Google'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'I don\'t have an account? Please',
                            style: TextStyle(
                              color: AppColor.fonts.withOpacity(0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Get.to(SignupScreen());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: AppColor.fonts,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50.0,
                          left: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          'Welcome to Admin Panel!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Sign in to continue',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.fonts.withOpacity(0.75),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Credentials',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    Helper.validateEmail(value),
                                decoration: InputDecoration(
                                  hintText: 'Email Address',
                                  isDense: true,
                                  filled: true,
                                  fillColor:
                                      AppColor.secondary.withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintStyle: TextStyle(
                                    color: AppColor.fonts.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: isVisible.value,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor:
                                          AppColor.secondary.withOpacity(0.25),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Password',
                                      errorMaxLines: 6,
                                      hintStyle: TextStyle(
                                        color: AppColor.fonts.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          isVisible.value = !isVisible.value;
                                        },
                                        icon: isVisible.value
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: AppColor.fonts,
                                                size: 15,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: AppColor.fonts,
                                                size: 15,
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Get.to(ForgetPassword());
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColor.fonts,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              if (isAdmin.value == true) {
                                Components.showAlertDialog(context);
                                AuthenticationHelper()
                                    .signIn(
                                  email: email.text,
                                  password: password.text,
                                  context: context,
                                )
                                    .then((result) {
                                  if (result != null) {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(result.user.uid)
                                        .get()
                                        .then((value) async {
                                      if (value.data()['username'] == 'Admin') {
                                        prefs.setString('Username',
                                            value.data()['username']);
                                        prefs.setString(
                                            'UserID', result.user.uid);
                                        prefs.setString(
                                            'Email', value.data()['email']);
                                        prefs.setString('PhoneNo',
                                            value.data()['phone_no']);
                                        prefs.setString(
                                            'ProfilePicture',
                                            value
                                                .data()['profile_picture']
                                                .toString());
                                        prefs.setString(
                                            'UserType', accountType.value);
                                        Navigator.of(context).pop();
                                        Components.showSnackBar(
                                            context, 'Wellcome to Admin Panel');
                                        Get.offAll(AdminDashboard());
                                      } else {
                                        Navigator.of(context).pop();
                                        Components.showSnackBar(context,
                                            'You are not allowed to login from this panel');
                                      }
                                    });
                                  }
                                }).catchError((e) {
                                  Components.showSnackBar(context, e);
                                  Navigator.of(context).pop();
                                });
                              } else {
                                Navigator.of(context).pop();
                                Components.showSnackBar(
                                    context, 'please select user type');
                              }
                            }
                          },
                          child: Text('Sign In'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.white),
                            overlayColor: MaterialStateProperty.all<Color>(
                              AppColor.white.withOpacity(0.1),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 45),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
