import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/utils/kamittee_helper.dart';

class MyKamittees extends StatefulWidget {
  const MyKamittees({Key key}) : super(key: key);

  @override
  State<MyKamittees> createState() => _MyKamitteesState();
}

class _MyKamitteesState extends State<MyKamittees> {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'My Kamittee\'s',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TabBar(
                      controller: tabController,
                      labelColor: AppColor.white,
                      unselectedLabelColor: AppColor.fonts,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.appThemeColor,
                      ),
                      tabs: const [
                        Tab(
                          text: 'In Progress',
                        ),
                        Tab(
                          text: 'Ongoing',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        StreamBuilder(
                          stream: KamitteeHelper().getKamitteeRecords(context),
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                    ConnectionState.waiting
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
                        StreamBuilder(
                          stream: KamitteeHelper().getKamitteeRecords(context),
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                    ConnectionState.waiting
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
                      ],
                    ),
                  ),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
