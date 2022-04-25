import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/screen/home/kamittee/create_kamittee.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

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
                    text: 'Welcome to\n',
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
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.asset('assets/icons/records.png'),
                        title: Text(
                          'Managed Records',
                          style: TextStyle(
                            color: AppColor.fonts,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                            'Creating and Maintaing a Kamittee is very easy'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.asset('assets/icons/calculate.png'),
                        title: Text(
                          'Auto Calculate',
                          style: TextStyle(
                            color: AppColor.fonts,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                            'All the tedious calculation arround kamittee are done automatically'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.asset('assets/icons/security.png'),
                        title: Text(
                          'Access Records',
                          style: TextStyle(
                            color: AppColor.fonts,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                            'Access Kamittee almost from anywhere through the app'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.asset('assets/icons/no_fee.png'),
                        title: Text(
                          'No Fee',
                          style: TextStyle(
                            color: AppColor.fonts,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text('Free from membership plans'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 40.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: false,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) => Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: const CreateKamittee(),
                            ),
                          );
                        },
                        child: Text('Get Started'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primary),
                          overlayColor: MaterialStateProperty.all<Color>(
                              AppColor.primary.withOpacity(0.1)),
                          minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 45)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: AppColor.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
