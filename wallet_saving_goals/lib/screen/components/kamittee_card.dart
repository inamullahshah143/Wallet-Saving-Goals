import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/screen/home/my_kamittee_details.dart';

class KamitteeCard extends StatelessWidget {
  final String title;
  final String members;
  final String duration;
  final String amount;
  const KamitteeCard({
    Key key,
    @required this.title,
    @required this.members,
    @required this.duration,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            ListTile(
              isThreeLine: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  maxLines: 1,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColor.fonts,
                            child: Icon(
                              FontAwesome.users,
                              size: 12,
                              color: AppColor.white,
                            ),
                          ),
                          Text('  '),
                          Text('${members} Members'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.fonts,
                            radius: 15,
                            child: Icon(
                              FontAwesome5.calendar,
                              size: 12,
                              color: AppColor.white,
                            ),
                          ),
                          Text('  '),
                          Text('${duration} month\'s'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: AppColor.fonts,
                            child: Icon(
                              FontAwesome.money,
                              size: 12,
                              color: AppColor.white,
                            ),
                          ),
                          Text('  '),
                          Text('${amount}0 PKR'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(MyKamitteeDetails());
                  },
                  child: Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
