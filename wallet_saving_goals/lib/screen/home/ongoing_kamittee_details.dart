// ignore_for_file: missing_return

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';
import 'package:wallet_saving_goals/utils/push_notification.dart';
import 'package:wallet_saving_goals/utils/stripe_helper.dart';

import '../../main.dart';

class OngoingDetails extends StatefulWidget {
  final Map<String, dynamic> kamitteeDetails;
  final String kamitteeId;
  OngoingDetails({
    Key key,
    @required this.kamitteeDetails,
    @required this.kamitteeId,
  }) : super(key: key);

  @override
  State<OngoingDetails> createState() => _OngoingDetailsState();
}

class _OngoingDetailsState extends State<OngoingDetails> {
  bool isKamitteePaid;
  bool isReadyToRequest;
  int myTurn;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyTurn();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isPaid();
    });
    super.initState();
  }

  Future getMyTurn() async {
    await FirebaseFirestore.instance
        .collection('ongoing_kamittees')
        .doc(widget.kamitteeId)
        .get()
        .then((value) async {
      for (var item in value.data()['kamittes']) {
        if (item['member_id'] == user.uid) {
          setState(() {
            myTurn = item['kamittee_no'];
          });

          if (myTurn == int.tryParse(widget.kamitteeDetails['current_turn'])) {
            await FirebaseFirestore.instance
                .collection('ongoing_kamittees')
                .doc(widget.kamitteeId)
                .get()
                .then((value) {
              if (value
                  .data()['kamittes']
                  .every((kamittee) => kamittee['status'] == "1")) {
                setState(() {
                  isReadyToRequest = true;
                });
              } else {
                setState(() {
                  isReadyToRequest = false;
                });
              }
            });
          }
        }
      }
    });
  }

  final paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColor.fonts,
          ),
        ),
        title: Text(
          'My Kamittee Details',
          style: TextStyle(
            fontSize: 18,
            color: AppColor.fonts,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.appThemeColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesome.users,
                        color: AppColor.white,
                      ),
                      Text(
                        '${widget.kamitteeDetails['members_total']}/${widget.kamitteeDetails['members_needed']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                      Text(
                        'Members',
                        style: TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.appThemeColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          FontAwesome.money,
                          color: AppColor.white,
                        ),
                        Text(
                          NumberFormat.compactCurrency(
                                  symbol: '', decimalDigits: 2)
                              .format(double.tryParse(
                                  widget.kamitteeDetails['kamittee_amount']))
                              .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                        Text(
                          'Amount',
                          style: TextStyle(
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.appThemeColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesome.calendar,
                        color: AppColor.white,
                      ),
                      Text(
                        widget.kamitteeDetails['kamittee_duration'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                      Text(
                        'Month\'s',
                        style: TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Brief  Summary',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Installment Per-Month',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text:
                            '${(double.tryParse(widget.kamitteeDetails['kamittee_amount']) / double.tryParse(widget.kamitteeDetails['kamittee_duration'])).toStringAsFixed(0)}',
                      ),
                      TextSpan(
                        text: ' PKR',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Starting Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: DateFormat.yMMMEd().format(DateTime.parse(
                            widget.kamitteeDetails['starting_date'])),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Ending Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: DateFormat.yMMMEd().format(
                          DateTime.parse(
                                  widget.kamitteeDetails['starting_date'])
                              .add(
                            Duration(
                              days: 30 *
                                  int.tryParse(
                                    widget.kamitteeDetails['kamittee_duration'],
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'My Turn',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: myTurn.toString() ?? 'N/A',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Current Turn',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: widget.kamitteeDetails['current_turn'],
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Turn Remains',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: (int.tryParse(widget
                                    .kamitteeDetails['kamittee_duration']) -
                                int.tryParse(
                                    widget.kamitteeDetails['current_turn']))
                            .toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Member Details',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          StreamBuilder(
            stream: KamitteeHelper().getOngoingKamitteeMembers(
                context, widget.kamitteeId, widget.kamitteeDetails['host_id']),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Container()
                  : snapshot.hasData
                      ? Expanded(child: snapshot.data)
                      : Center(
                          child: Text(
                            'No Record Found',
                            style: TextStyle(
                              color: AppColor.secondary,
                            ),
                          ),
                        );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: isKamitteePaid == false
              ? () async {
                  paymentController
                      .makePayment(
                    amount:
                        '${(double.tryParse(widget.kamitteeDetails['kamittee_amount']) / double.tryParse(widget.kamitteeDetails['kamittee_duration'])).toStringAsFixed(0)}',
                    currency: 'PKR',
                  )
                      .then((value) async {
                    if (value == true) {
                      await FirebaseFirestore.instance
                          .collection('transactions')
                          .add({
                        'user_id': user.uid,
                        'kamittee_amount':
                            '${(double.tryParse(widget.kamitteeDetails['kamittee_amount']) / double.tryParse(widget.kamitteeDetails['kamittee_duration'])).toStringAsFixed(0)}',
                        'kamittee_id': widget.kamitteeId,
                        'date': DateTime.now(),
                      }).whenComplete(() async {
                        await FirebaseFirestore.instance
                            .collection('ongoing_kamittees')
                            .doc(widget.kamitteeId)
                            .get()
                            .then((value) async {
                          for (var i = 0;
                              i < value.data()['kamittes'].length;
                              i++) {
                            if (value.data()['kamittes'][i]['member_id'] ==
                                user.uid) {
                              await FirebaseFirestore.instance
                                  .collection('ongoing_kamittees')
                                  .doc(widget.kamitteeId)
                                  .update(
                                {
                                  'kamittes': FieldValue.arrayRemove(
                                    [
                                      {
                                        'status': '0',
                                        'member_id': value.data()['kamittes'][i]
                                            ['member_id'],
                                        'kamittee_no': value.data()['kamittes']
                                            [i]['kamittee_no']
                                      }
                                    ],
                                  ),
                                },
                              ).whenComplete(() async {
                                await FirebaseFirestore.instance
                                    .collection('ongoing_kamittees')
                                    .doc(widget.kamitteeId)
                                    .update({
                                  'kamittes': FieldValue.arrayUnion(
                                    [
                                      {
                                        'status': '1',
                                        'member_id': value.data()['kamittes'][i]
                                            ['member_id'],
                                        'kamittee_no': value.data()['kamittes']
                                            [i]['kamittee_no']
                                      }
                                    ],
                                  ),
                                });
                              }).whenComplete(() async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc('cZGCfAP1wNg5QiaIk4yWarP46rp2')
                                    .get()
                                    .then((admin) {
                                  PushNotification().sendPushMessage(
                                      admin.data()['fcm_token'],
                                      '${prefs.getString('Username')} send ${(double.tryParse(widget.kamitteeDetails['kamittee_amount']) / double.tryParse(widget.kamitteeDetails['kamittee_duration'])).toStringAsFixed(0)} to your respective stripe account successfully',
                                      'Please have a look');
                                });
                              });
                            }
                          }
                        });
                      });
                    }
                  });
                }
              : isReadyToRequest == true
                  ? () {
                      Map<String, dynamic> requestDetails = {
                        'user_id': user.uid,
                        'kamittee_id': widget.kamitteeId,
                        'amount': widget.kamitteeDetails['kamittee_amount'],
                      };

                      CoolAlert.show(
                        context: context,
                        confirmBtnColor: AppColor.appThemeColor,
                        barrierDismissible: false,
                        type: CoolAlertType.custom,
                        text: 'Please add your banking details',
                        widget: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  requestDetails['bank_title'] = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Bank Title',
                                  isDense: true,
                                  filled: true,
                                  fillColor:
                                      AppColor.secondary.withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
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
                                onChanged: (value) {
                                  requestDetails['account_title'] = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Account Title',
                                  isDense: true,
                                  filled: true,
                                  fillColor:
                                      AppColor.secondary.withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
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
                                onChanged: (value) {
                                  requestDetails['account_IBAN'] = value;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Account No. or IBAN',
                                  isDense: true,
                                  filled: true,
                                  fillColor:
                                      AppColor.secondary.withOpacity(0.25),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintStyle: TextStyle(
                                    color: AppColor.fonts.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  requestDetails['phone_no'] =
                                      number.phoneNumber;
                                },
                                selectorConfig: const SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                initialValue:
                                    PhoneNumber(isoCode: 'PK', dialCode: '0'),
                                formatInput: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                inputDecoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor:
                                      AppColor.secondary.withOpacity(0.25),
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
                          ],
                        ),
                        onConfirmBtnTap: () async {
                          Components.showAlertDialog(context);
                          await FirebaseFirestore.instance
                              .collection('withdraw_request')
                              .add(requestDetails)
                              .whenComplete(() {
                            Components.showSnackBar(context,
                                'Your request has been posted successfully!');
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        },
                        confirmBtnText: 'Send',
                        backgroundColor: AppColor.fonts,
                        showCancelBtn: false,
                      );
                    }
                  : () {},
          child: Text(
              isReadyToRequest == true ? 'Ready To Request' : 'Proceed to Pay'),
          style: ButtonStyle(
            backgroundColor: isKamitteePaid == false || isReadyToRequest == true
                ? MaterialStateProperty.all<Color>(AppColor.appThemeColor)
                : MaterialStateProperty.all<Color>(AppColor.secondary),
            foregroundColor: MaterialStateProperty.all<Color>(AppColor.white),
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
    );
  }

  Future isPaid() async {
    await FirebaseFirestore.instance
        .collection('ongoing_kamittees')
        .doc(widget.kamitteeId)
        .get()
        .then((value) {
      for (var item in value.data()['kamittes']) {
        if (item['member_id'] == user.uid) {
          if (item['status'] == '1') {
            setState(() {
              isKamitteePaid = true;
            });
          } else {
            setState(() {
              isKamitteePaid = false;
            });
          }
        }
      }
    });
  }
}
