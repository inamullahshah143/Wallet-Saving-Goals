import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';

CoolStep step4(kamitteePurpose, otherKamitteePurpose) {
  return CoolStep(
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
                        onChanged: (value) {
                          otherKamitteePurpose.value = value;
                        },
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
  );
}
