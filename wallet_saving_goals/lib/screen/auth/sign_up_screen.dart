import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/screen/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final accountType = ''.obs;
  final isVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
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
                  'Sign up to continue',
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: AppColor.fonts.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      color: AppColor.fonts.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: InputDecoration(
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  obscureText: isVisible.value,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Password',
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  obscureText: isVisible.value,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Confirm Password',
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Sing Up'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColor.white),
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Already have an account? Please',
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
                      Get.off(LoginScreen());
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColor.fonts,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            'By signing of creating account, you agree with our ',
                            style: TextStyle(
                              color: AppColor.fonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Terms of Service',
                              style: TextStyle(
                                color: AppColor.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            ' & ',
                            style: TextStyle(
                              color: AppColor.fonts,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: AppColor.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
