import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/transaction_helper.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          'Transactions',
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
      body: StreamBuilder(
            stream: TransactionHelper().getMyTransaction(),
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
    );
  }
}
