import 'package:cloud_firestore/cloud_firestore.dart';

class ContactHelper {
  Future<List<String>> getContacts() async {
    List<String> x = [];
    await FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var item in value.docs) {
        x.add(item['phoneNo']);
      }
    });
    return x;
  }
}
