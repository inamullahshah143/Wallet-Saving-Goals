import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';

CoolStep step3(cnicFront, cnicBack, selfie) {
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
                  KamitteeHelper().pickImage().then((value) {
                    cnicFront = value;
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
                          style: TextStyle(color: AppColor.white, fontSize: 14),
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
                  KamitteeHelper().pickImage().then((value) {
                    cnicBack = value;
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
                          style: TextStyle(color: AppColor.white, fontSize: 14),
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
                KamitteeHelper().pickImage().then((value) {
                    selfie = value;
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
