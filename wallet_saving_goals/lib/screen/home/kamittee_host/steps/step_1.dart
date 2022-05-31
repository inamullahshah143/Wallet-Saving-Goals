import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_saving_goals/constants/color.dart';

CoolStep step1(
  context,
  _formKey,
  kamitteeAmount,
  kamitteeDuration,
  selectedDate,
  otherKamitteeAmount,
  otherKamitteeDuration,
) {
  TextEditingController startedDate = TextEditingController(
      text: '${DateFormat.yMMMEd().format(DateTime.now())}');
  return CoolStep(
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
                    size: 20,
                    color: AppColor.fonts,
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
                        onChanged: (value) {
                          otherKamitteeAmount.value = value;
                        },
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
                    helperText: 'The duration in which you want to complete',
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    isDense: true,
                    prefixIcon: Icon(
                      FontAwesome5.calendar_alt,
                      size: 20,
                      color: AppColor.fonts,
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
                        autofocus: false,
                        onChanged: (value) {
                          otherKamitteeDuration.value = value;
                        },
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
                    }).then((date) {
                  if (date != null) {
                    startedDate.text = DateFormat.yMMMEd().format(date);
                    selectedDate.value = date.toString();
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
                  size: 20,
                  color: AppColor.fonts,
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
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        kamitteeAmount.value != 'other' &&
                                kamitteeDuration.value != 'other'
                            ? '${double.parse(kamitteeAmount.value) * double.parse(kamitteeDuration.value)}0 PKR'
                            : kamitteeDuration.value == 'other' &&
                                    kamitteeAmount.value != 'other'
                                ? '${double.parse(kamitteeAmount.value) * double.parse(otherKamitteeDuration.value)}0 PKR'
                                : kamitteeAmount.value == 'other' &&
                                        kamitteeDuration.value != 'other'
                                    ? '${double.parse(otherKamitteeAmount.value) * double.parse(kamitteeDuration.value)}0 PKR'
                                    : '${double.parse(otherKamitteeAmount.value) * double.parse(otherKamitteeDuration.value)}0 PKR',
                        style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    validation: () {
      if (startedDate.text == '') {
        return 'please initiate kamittee starting date';
      }
      return null;
    },
  );
}
