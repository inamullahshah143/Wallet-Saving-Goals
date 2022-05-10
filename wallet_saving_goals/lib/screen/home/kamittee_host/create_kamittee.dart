import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  TextEditingController startedDate = TextEditingController();

  final kamitteePurpose = ''.obs;
  @override
  Widget build(BuildContext context) {
    List<CoolStep> steps = [
      step1(context, _formKey, kamitteeAmount, kamitteeDuration, startedDate),
      step2(),
      step3(),
      step4(kamitteePurpose),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: CoolStepper(
          showErrorSnackbar: false,
          onCompleted: () {
            print('Steps completed!');
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
}
