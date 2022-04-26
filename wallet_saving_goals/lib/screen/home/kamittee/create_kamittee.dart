import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_saving_goals/constants/color.dart';

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
    final steps = [
      CoolStep(
        title: 'Choose Kamittee',
        subtitle: 'Please fill some of the basic information to get started',
        content: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Monthly Installment',
                  style: TextStyle(
                    color: AppColor.fonts,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  return DropdownButtonFormField(
                    value: kamitteeAmount.value,
                    decoration: InputDecoration(
                      hintText: '1000.0 PRK',
                      helperText: 'The amount you want to save per month',
                      fillColor: AppColor.secondary.withOpacity(0.25),
                      isDense: true,
                      prefixIcon: Icon(
                        FontAwesome5.money_bill_wave,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                    onChanged: (value) {
                      kamitteeAmount.value = value;
                    },
                    items: [
                      DropdownMenuItem(
                        value: '500.0',
                        child: Text('500.0 PRK'),
                      ),
                      DropdownMenuItem(
                        value: '1000.0',
                        child: Text('1000.0 PRK'),
                      ),
                      DropdownMenuItem(
                        value: '1500.0',
                        child: Text('1500.0 PRK'),
                      ),
                      DropdownMenuItem(
                        value: '2000.0',
                        child: Text('2000.0 PRK'),
                      ),
                      DropdownMenuItem(
                        value: '5000.0',
                        child: Text('5000.0 PRK'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text('Other Amount'),
                      ),
                    ],
                  );
                }),
              ),
              Obx(
                () {
                  return kamitteeAmount.value == 'other'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Other Amount',
                              fillColor: AppColor.secondary.withOpacity(0.25),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Duration',
                  style: TextStyle(
                    color: AppColor.fonts,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () {
                    return DropdownButtonFormField(
                      value: kamitteeDuration.value,
                      decoration: InputDecoration(
                        hintText: '5 Months',
                        helperText:
                            'The duration in which you want to complete',
                        fillColor: AppColor.secondary.withOpacity(0.25),
                        isDense: true,
                        prefixIcon: Icon(
                          FontAwesome5.calendar_alt,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                      ),
                      onChanged: (value) {
                        kamitteeDuration.value = value;
                      },
                      items: [
                        DropdownMenuItem(
                          value: '5',
                          child: Text('5 Months'),
                        ),
                        DropdownMenuItem(
                          value: '10',
                          child: Text('10 Month'),
                        ),
                        DropdownMenuItem(
                          value: '12',
                          child: Text('12 Months'),
                        ),
                        DropdownMenuItem(
                          value: '18',
                          child: Text('18 Months'),
                        ),
                        DropdownMenuItem(
                          value: '24',
                          child: Text('24 Months'),
                        ),
                        DropdownMenuItem(
                          value: 'other',
                          child: Text('Other Duration'),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Obx(
                () {
                  return kamitteeDuration.value == 'other'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Other Duration',
                              fillColor: AppColor.secondary.withOpacity(0.25),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Start Date',
                  style: TextStyle(
                    color: AppColor.fonts,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: startedDate,
                  keyboardType: TextInputType.number,
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          Duration(
                            days: 730,
                          ),
                        ),
                        builder: (context, picker) {
                          return picker;
                        }).then((selectedDate) {
                      if (selectedDate != null) {
                        startedDate.text =
                            DateFormat.yMMMEd().format(selectedDate);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Start Date',
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    isDense: true,
                    helperText: 'The date from which the kamittee begin\'s',
                    prefixIcon: Icon(
                      FontAwesome5.calendar,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Your total kamittee amount will be',
                          style: TextStyle(
                            color: AppColor.white.withOpacity(0.75),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '5000.00 PKR',
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
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
        validation: () {
          if (!_formKey.currentState.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
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
                  fontSize: 20,
                  color: AppColor.fonts,
                  fontWeight: FontWeight.bold),
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
      ),
      CoolStep(
        title: 'Verify your identity',
        subtitle:
            'To protect you and all our users, we are require your CNIC and selfie to confirm your identity and ensure your account is secure.',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[],
        ),
        validation: () {
          return null;
        },
      ),
      CoolStep(
        title: 'What are you saving for',
        subtitle: 'Select the purpose for savings',
        content: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RadioListTile(
                value: 'Repay a Loan',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Repay a Loan'),
              ),
              RadioListTile(
                value: 'Build Long-Term savings',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Build Long-Term savings'),
              ),
              RadioListTile(
                value: 'Short-Term need',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Short-Term need'),
              ),
              RadioListTile(
                value: 'Wedding',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Wedding'),
              ),
              RadioListTile(
                value: 'Expenses',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Expenses'),
              ),
              RadioListTile(
                value: 'Education',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Education'),
              ),
              RadioListTile(
                value: 'other',
                onChanged: (value) {
                  kamitteePurpose.value = value;
                },
                groupValue: kamitteePurpose.value,
                title: Text('Other'),
              ),
              Obx(
                () {
                  return kamitteePurpose.value == 'other'
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'State Purpose',
                              fillColor: AppColor.secondary.withOpacity(0.25),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          );
        }),
        validation: () {
          return null;
        },
      ),
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
