import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';
import 'steps/step_1.dart';
import 'steps/step_2.dart';
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
  final KamitteeHelper controller = Get.put(KamitteeHelper());
  TextEditingController referralCode;
  final kamitteePurpose = ''.obs;
  final otherKamitteePurpose = ''.obs;
  final selectedDate = ''.obs;
  File cnicFront;
  File cnicBack;
  File selfie;

  @override
  Widget build(BuildContext context) {
    List<CoolStep> steps = [
      step1(context, _formKey, kamitteeAmount, kamitteeDuration, selectedDate,
          otherKamitteeAmount, otherKamitteeDuration),
      step2(),
      step3(),
      step4(kamitteePurpose, otherKamitteePurpose),
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
              barrierDismissible: false,
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
              onConfirmBtnTap: () async {
                Components.showAlertDialog(context);
                await controller
                    .uploadImage(cnicFront)
                    .then((cnicFrontURL) async {
                  await controller
                      .uploadImage(cnicBack)
                      .then((cnicBackURL) async {
                    await controller
                        .uploadImage(selfie)
                        .then((selfieURL) async {
                      await FirebaseFirestore.instance
                          .collection('kamittee')
                          .add({
                        'host_id': user.uid,
                        'kamittee_amount': kamitteeAmount.value != 'other' &&
                                kamitteeDuration.value != 'other'
                            ? '${double.parse(kamitteeAmount.value) * double.parse(kamitteeDuration.value)}'
                            : kamitteeDuration.value == 'other' &&
                                    kamitteeAmount.value != 'other'
                                ? '${double.parse(kamitteeAmount.value) * double.parse(otherKamitteeDuration.value)}'
                                : kamitteeAmount.value == 'other' &&
                                        kamitteeDuration.value != 'other'
                                    ? '${double.parse(otherKamitteeAmount.value) * double.parse(kamitteeDuration.value)}'
                                    : '${double.parse(otherKamitteeAmount.value) * double.parse(otherKamitteeDuration.value)}',
                        'kamittee_duration': kamitteeDuration.value == 'other'
                            ? otherKamitteeDuration.value
                            : kamitteeDuration.value,
                        'starting_date': selectedDate.value,
                        'host_cnic_front': cnicFrontURL,
                        'host_cnic_back': cnicBackURL,
                        'host_selfie': selfieURL,
                        'kamittee_purpose': kamitteePurpose.value == 'other'
                            ? otherKamitteePurpose.value
                            : kamitteePurpose.value,
                        'members_total': '1',
                        'members_needed': kamitteeDuration.value == 'other'
                            ? otherKamitteeDuration.value
                            : kamitteeDuration.value,
                        'members_list': [],
                        'referral_code': referralCode.text.toString(),
                      }).whenComplete(() {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Components.showSnackBar(
                            context, 'your Kamittee created successfully');
                      });
                    });
                  });
                });
              },
              showCancelBtn: true,
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

  CoolStep step3() {
    return CoolStep(
      title: 'Verify your identity',
      subtitle:
          'To protect you and all our users, we are require your CNIC and selfie to confirm your identity and ensure your account is secure.',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Provide your CNIC front & back picture',
              style: TextStyle(
                color: AppColor.fonts,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.getImage().then((value) {
                      setState(() {
                        cnicFront = value;
                      });
                    });
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.secondary.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cnicFront == null
                                ? Icons.camera_enhance_outlined
                                : Icons.done,
                            color: AppColor.white,
                            size: 30,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'CNIC Front',
                            style:
                                TextStyle(color: AppColor.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                InkWell(
                  onTap: () {
                    controller.getImage().then((value) {
                      setState(() {
                        cnicBack = value;
                      });
                    });
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.secondary.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cnicBack == null
                                ? Icons.camera_enhance_outlined
                                : Icons.done,
                            color: AppColor.white,
                            size: 30,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'CNIC Back',
                            style:
                                TextStyle(color: AppColor.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Take your front face Selfie',
              style: TextStyle(
                color: AppColor.fonts,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  controller.getImage().then((value) {
                    setState(() {
                      selfie = value;
                    });
                  });
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.secondary.withOpacity(0.5),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selfie == null
                              ? Icons.camera_enhance_outlined
                              : Icons.done,
                          color: AppColor.white,
                          size: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Selfie',
                          style: TextStyle(color: AppColor.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Make sure the photo is:',
              style: TextStyle(
                  color: AppColor.fonts,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            ' - Well lit and clear to read',
            style: TextStyle(
              color: AppColor.fonts,
              fontSize: 12,
            ),
          ),
          Text(
            ' - Inside the camera frame',
            style: TextStyle(
              color: AppColor.fonts,
              fontSize: 12,
            ),
          ),
          Text(
            ' - We will compare your selfie to your ID photo. if its match, \n   then you will be verified for Kamittee',
            style: TextStyle(
              color: AppColor.fonts,
              fontSize: 12,
            ),
          ),
        ],
      ),
      validation: () {
        if (cnicFront == null && cnicBack == null && selfie == null) {
          return 'please upload requried data';
        } else if (cnicFront == null) {
          return 'please upload CNIC front picture';
        } else if (cnicBack == null) {
          return 'please upload CNIC back picture';
        } else if (selfie == null) {
          return 'please upload CNIC front picture';
        }
        return null;
      },
    );
  }
}
