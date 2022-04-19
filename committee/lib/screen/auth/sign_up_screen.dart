import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:committee/constants/color.dart';
import 'package:committee/screen/auth/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 75,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.secondary,
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'Your full name',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: ('Email'),
                              hintText: 'Your email address'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: ('Password'),
                              hintText: 'Your secret password'),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: ('Confirm Password'),
                              hintText: 'Confirm your password'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.white),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  AppColor.white.withOpacity(0.1)),
                            ),
                            onPressed: () {},
                            child: const Text('Sign Up'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('OR'),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.primary),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  AppColor.primary.withOpacity(0.1)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
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
                                    child: Text('Sign up with Google'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: AppColor.fonts,
                          ),
                        ),
                      ),
                      const TextSpan(text: '  '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
