import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_saving_goals/constants/color.dart';

class MyKamitteeDetails extends StatelessWidget {
  final Map<String, dynamic> kamitteeDetails;
  const MyKamitteeDetails({Key key, @required this.kamitteeDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'My Kamittee Details',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.appThemeColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesome.users,
                        color: AppColor.white,
                      ),
                      Text(
                        '${kamitteeDetails['members_total']}/${kamitteeDetails['members_needed']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                      Text(
                        'Members',
                        style: TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.appThemeColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          FontAwesome.money,
                          color: AppColor.white,
                        ),
                        Text(
                          NumberFormat.compactCurrency(
                                  symbol: '', decimalDigits: 3)
                              .format(double.tryParse(
                                  kamitteeDetails['kamittee_amount']))
                              .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.white,
                          ),
                        ),
                        Text(
                          'Amount',
                          style: TextStyle(
                            color: AppColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.appThemeColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        FontAwesome.calendar,
                        color: AppColor.white,
                      ),
                      Text(
                        kamitteeDetails['kamittee_duration'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.white,
                        ),
                      ),
                      Text(
                        'Month\'s',
                        style: TextStyle(
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Referral Code',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColor.fonts,
                  ),
                  children: [
                    TextSpan(
                      text: kamitteeDetails['referral_code'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: '   ',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: IconButton(
                        onPressed: () {
                          copyToClipboard(
                              context, kamitteeDetails['referral_code']);
                        },
                        icon: Icon(
                          Icons.copy,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Brief  Summary',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Installment Per-Month',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text:
                            '${(double.tryParse(kamitteeDetails['kamittee_amount']) / double.tryParse(kamitteeDetails['kamittee_duration'])).toStringAsFixed(0)}',
                      ),
                      TextSpan(
                        text: ' PKR',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Starting Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: kamitteeDetails['starting_date'],
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Ending Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: '',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'My Turn',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: 'N/A',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Current Turn',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: 'N/A',
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColor.fonts,
                    ),
                    children: [
                      TextSpan(
                        text: 'Turn Remains',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.fonts,
                        ),
                      ),
                      TextSpan(
                        text: ' : ',
                      ),
                      TextSpan(
                        text: 'N/A',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Host Details',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user')
                .doc(kamitteeDetails['host_id'])
                .snapshots(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Container()
                  : snapshot.hasData
                      ? ListTile(
                          title: Text(snapshot.data['fullName'].toString()),
                          subtitle: Text(snapshot.data['email'].toString()),
                          trailing: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.call,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      FontAwesome.chat_empty,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Members List',
              style: TextStyle(
                color: AppColor.fonts,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  title: Text('Member Name'),
                  subtitle: Text('email@email.com'),
                  trailing: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesome.chat_empty,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  confirmBtnColor: AppColor.appThemeColor,
                  barrierDismissible: false,
                  type: CoolAlertType.custom,
                  text: 'Please enter your invite code',
                  onConfirmBtnTap: () {},
                  confirmBtnText: 'Join',
                  backgroundColor: AppColor.fonts,
                  widget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (value) {},
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Code.',
                        fillColor: AppColor.secondary.withOpacity(0.25),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  showCancelBtn: true,
                );
              },
              child: Text('Proceed to Pay'),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColor.white),
                overlayColor: MaterialStateProperty.all<Color>(
                  AppColor.white.withOpacity(0.1),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 45),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> copyToClipboard(context, text) async {
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }
}
