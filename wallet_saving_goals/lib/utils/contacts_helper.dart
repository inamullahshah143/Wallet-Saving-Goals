import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:wallet_saving_goals/main.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';

class ContactHelper {
  Future<List<String>> getContacts() async {
    List<String> x = [];
    await FirebaseFirestore.instance.collection('user').where('phone_no',isNotEqualTo: prefs.getString('PhoneNo')).get().then((value) {
      for (var item in value.docs) {
        x.add(item['phone_no']);
      }
    });
    return x;
  }

  callNumber(context, number) async {
    await FlutterPhoneDirectCaller.callNumber(number).catchError((e) {
      Components.showSnackBar(context, e.toString());
    });
  }
}
