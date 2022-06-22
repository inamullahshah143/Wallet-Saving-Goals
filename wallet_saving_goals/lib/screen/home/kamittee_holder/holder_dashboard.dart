import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';

class HolderDashboard extends StatelessWidget {
  HolderDashboard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Wellcome to\n',
                    style: TextStyle(
                      color: AppColor.primary.withOpacity(0.5),
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: 'Kamittee',
                    style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Kamittee is an online application that allows you to maintain your kamitties online. \nWith the help of this app, you can get Kamitties records from anywhere in the world.',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColor.fonts,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Referal Code',
                      isDense: true,
                      filled: true,
                      fillColor: AppColor.secondary.withOpacity(0.25),
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
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Join'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColor.white),
                    overlayColor: MaterialStateProperty.all<Color>(
                      AppColor.white.withOpacity(0.1),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(70, 45),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Invitations',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: KamitteeHelper().getAllKamitteeRecords(context),
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
