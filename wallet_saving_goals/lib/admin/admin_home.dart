import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/transaction_helper.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Material(
                color: AppColor.white,
                elevation: 1.0,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text('Current Balance'),
                      SizedBox(height: 10),
                      StreamBuilder(
                        stream: TransactionHelper().getAmountTotal(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? Container()
                              : snapshot.hasData
                                  ? Text(
                                      snapshot.data.toString() + ' PKR',
                                      style: TextStyle(
                                        color: AppColor.fonts,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text(
                                      '0.00 PKR',
                                      style: TextStyle(
                                        color: AppColor.fonts,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Transactions',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder(
            stream: TransactionHelper().getTransaction(),
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
    );
  }
}
