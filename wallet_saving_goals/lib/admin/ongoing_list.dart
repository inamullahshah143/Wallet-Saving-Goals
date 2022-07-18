import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';

class OngoingList extends StatelessWidget {
  const OngoingList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: KamitteeHelper().getAdminOngoingKamitteeRecords(context),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : snapshot.hasData
                ? snapshot.data
                : Center(
                    child: Text(
                      'No Kamittee Found',
                      style: TextStyle(
                        color: AppColor.secondary,
                      ),
                    ),
                  );
      },
    );
  }
}
