import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';

CoolStep step2() {
  return CoolStep(
    title: 'Online Verification',
    subtitle: 'We Respect Your Privacy.',
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Text(
          'Kamittee will ask for access to your phone data. We will use this data to assess your profile and application for an Kamittee App.',
          style: TextStyle(color: AppColor.fonts),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'We will not view or store your personal information. Only the pattern of your phone usage is determined.',
          style: TextStyle(color: AppColor.fonts),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Phone Permissions Required',
          style: TextStyle(
              fontSize: 20, color: AppColor.fonts, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Enabling Contacts, Calendar, Storage and Registered Accounts will help Kamittee collect data to assess your creditworthiness and accept your application',
          style: TextStyle(color: AppColor.fonts),
        ),
      ],
    ),
    validation: () {
      return null;
    },
  );
}
