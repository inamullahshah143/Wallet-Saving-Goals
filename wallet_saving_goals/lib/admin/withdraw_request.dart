import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/transaction_helper.dart';

class WithdrawRequest extends StatelessWidget {
  const WithdrawRequest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TransactionHelper().getWithdrawRequests(context),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Container()
            : snapshot.hasData
                ? snapshot.data
                : Center(
                    child: Text(
                      'No Record Found',
                      style: TextStyle(
                        color: AppColor.secondary,
                      ),
                    ),
                  );
      },
    );
  }
}
