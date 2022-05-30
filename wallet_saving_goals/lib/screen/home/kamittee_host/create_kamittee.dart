import 'dart:io';
import 'dart:math';
import 'package:cool_alert/cool_alert.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'steps/step_1.dart';
import 'steps/step_2.dart';
import 'steps/step_3.dart';
import 'steps/step_4.dart';

class CreateKamittee extends StatefulWidget {
  const CreateKamittee({Key key}) : super(key: key);

  @override
  State<CreateKamittee> createState() => _CreateKamitteeState();
}

class _CreateKamitteeState extends State<CreateKamittee> {
  final _formKey = GlobalKey<FormState>();
  final kamitteeAmount = '1000.0'.obs;
  final kamitteeDuration = '5'.obs;
  final otherKamitteeAmount = '1.0'.obs;
  final otherKamitteeDuration = '1'.obs;
  TextEditingController referralCode;
  TextEditingController startedDate = TextEditingController(
      text: '${DateFormat.yMMMEd().format(DateTime.now())}');
  final kamitteePurpose = ''.obs;
  File cnicFront;
  File cnicBack;
  File selfie;

  @override
  Widget build(BuildContext context) {
    List<CoolStep> steps = [
      step1(context, _formKey, kamitteeAmount, kamitteeDuration, startedDate,
          otherKamitteeAmount, otherKamitteeDuration),
      step2(),
      step3(cnicFront, cnicBack, selfie),
      step4(kamitteePurpose),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: CoolStepper(
          showErrorSnackbar: true,
          onCompleted: () {
            referralCode = TextEditingController(text: generateRandomString());
            CoolAlert.show(
              context: context,
              backgroundColor: AppColor.fonts,
              confirmBtnColor: AppColor.appThemeColor,
              barrierDismissible: true,
              type: CoolAlertType.custom,
              widget: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: referralCode,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        copyToClipboard(referralCode.text);
                      },
                      icon: Icon(
                        Icons.copy,
                      ),
                    ),
                    hintText: 'Referral Code',
                    hintStyle: TextStyle(
                      color: AppColor.fonts.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              title: 'Kamittee Referral Code',
              text: 'your referral code is',
              confirmBtnText: 'Proceed',
              showCancelBtn: false,
            );
          },
          steps: steps,
          config: CoolStepperConfig(
            titleTextStyle: TextStyle(
              color: AppColor.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            subtitleTextStyle: TextStyle(color: AppColor.white),
            headerColor: AppColor.primary,
            iconColor: AppColor.white,
            backText: 'Back',
            finalText: 'Get Started',
            nextText: 'Next',
          ),
        ),
      ),
    );
  }

  Future<void> copyToClipboard(text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  String generateRandomString() {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(10, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
