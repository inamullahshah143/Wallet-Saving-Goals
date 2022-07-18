import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        : Expanded(
            child: Center(
              child: Text('No Kamittee Found'),
            ),
          );
  }
}
