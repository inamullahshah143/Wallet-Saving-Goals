import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';

class HostKamittees extends StatelessWidget {
  const HostKamittees({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'My Hosted Kamittee\'s',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: KamitteeHelper().getHostKamitteeRecords(context),
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
            ),
          ),
        ],
      ),
    );
  }
}
