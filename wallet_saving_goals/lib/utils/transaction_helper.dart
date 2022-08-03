import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_saving_goals/constants/color.dart';

import '../main.dart';

class TransactionHelper {
  Stream getAmountTotal() async* {
    double amount = 0.0;
    await FirebaseFirestore.instance
        .collection('transactions')
        .get()
        .then((value) async {
      for (var item in value.docs) {
        amount = amount + double.tryParse(item.data()['kamittee_amount']);
      }
    });
    yield amount;
  }

  Stream<Widget> getTransaction() async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('transactions').get().then(
      (value) async {
        for (var item in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item.data()['user_id'])
              .get()
              .then((user) {
            x.add(
              ListTile(
                title: Text(user.data()['username'].toUpperCase()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('Amount ' + item.data()['kamittee_amount']),
                    SizedBox(height: 5),
                    Text('TID: #' + item.id.toString()),
                    SizedBox(height: 5),
                  ],
                ),
                trailing: Text(
                  '${DateFormat.jm().format(item.data()['date'].toDate())}\n${DateFormat.MMMd().format(item.data()['date'].toDate())}',
                  textAlign: TextAlign.right,
                ),
              ),
            );
          });
        }
      },
    );
    yield x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Center(
            child: Text('No Kamittee Found'),
          );
  }

  Stream<Widget> getWithdrawRequests(context) async* {
    List<Widget> x = [];
    await FirebaseFirestore.instance.collection('withdraw_request').get().then(
      (value) async {
        for (var item in value.docs) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(item.data()['user_id'])
              .get()
              .then((user) {
            x.add(
              ListTile(
                onTap: () {
                  CoolAlert.show(
                    context: context,
                    confirmBtnColor: AppColor.appThemeColor,
                    barrierDismissible: false,
                    type: CoolAlertType.custom,
                    widget: Column(
                      children: [
                        Text('Bank Name: ' + item.data()['bank_title']),
                        Text('Account Title: ' + item.data()['account_title']),
                        Text(
                            'Account No./IBAN: ' + item.data()['account_IBAN']),
                        Text('Phone No: ' + item.data()['phone_no']),
                        Text('Amount: ' + item.data()['amount']),
                      ],
                    ),
                    backgroundColor: AppColor.fonts,
                    showCancelBtn: false,
                  );
                },
                title: Text(user.data()['username'].toUpperCase()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('Amount ' + item.data()['amount']),
                    SizedBox(height: 5),
                    Text('KID: #' + item.id.toString()),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            );
          });
        }
      },
    );
    yield x.length > 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: x.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return x[index];
            },
          )
        : Center(
            child: Text('No Transaction Found'),
          );
  }

  Future<Widget> getMyTransaction() async {
    List<Widget> x = [];
    await FirebaseFirestore.instance
        .collection('transactions')
        .where('user_id', isEqualTo: user.uid)
        .get()
        .then(
      (value) async {
        for (var item in value.docs) {
          x.add(
            Card(
              child: ListTile(
                title: Text(prefs.getString('Username').toUpperCase()),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text('Amount ' + item.data()['kamittee_amount']),
                    SizedBox(height: 5),
                    Text('TID: #' + item.id.toString()),
                    SizedBox(height: 5),
                  ],
                ),
                trailing: Text(
                  '${DateFormat.jm().format(item.data()['date'].toDate())}\n${DateFormat.MMMd().format(item.data()['date'].toDate())}',
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          );
        }
      },
    );
    return x.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: x.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return x[index];
              },
            ),
          )
        : Center(
            child: Text('No Transaction Found'),
          );
  }
}
