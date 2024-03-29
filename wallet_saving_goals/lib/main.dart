import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/screen/auth/splash_screen.dart';

SharedPreferences prefs;
FirebaseAuth _auth;
get user => _auth.currentUser;
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('Handling a background message ${message.messageId}');
  }
}

Cron cron;
Future<void> main() async {
  cron = Cron();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  cron.schedule(Schedule.parse('0 0 1 * *'), () async {
    await FirebaseFirestore.instance
        .collection('ongoing_kamittees')
        .get()
        .then((value) async {
      for (var item in value.docs) {
        int currentTurn = int.tryParse(item['current_turn']);
        if (currentTurn <= int.tryParse(item['kamittee_duration'])) {
          for (var i = 0; i < item.data()['kamittes'].length; i++) {
            await FirebaseFirestore.instance
                .collection('ongoing_kamittees')
                .doc(item.id)
                .update(
              {
                'kamittes': FieldValue.arrayRemove(
                  [
                    {
                      'status': '1',
                      'member_id': item.data()['kamittes'][i]['member_id'],
                      'kamittee_no': item.data()['kamittes'][i]['kamittee_no']
                    }
                  ],
                ),
              },
            ).whenComplete(() async {
              await FirebaseFirestore.instance
                  .collection('ongoing_kamittees')
                  .doc(item.id)
                  .update({
                'current_turn': (currentTurn + 1).toString(),
                'kamittes': FieldValue.arrayUnion(
                  [
                    {
                      'status': '0',
                      'member_id': item.data()['kamittes'][i]['member_id'],
                      'kamittee_no': item.data()['kamittes'][i]['kamittee_no']
                    }
                  ],
                ),
              });
            });
          }
        } else {
          await FirebaseFirestore.instance
              .collection('ongoing_kamittees')
              .doc(item.id)
              .delete();
        }
      }
    });
  });
  Stripe.publishableKey =
      'pk_test_51L2ySrFA9SdVfjX6vdz0gEReE6hOUFP98XLtjPwAwAfKbR9F3241hdNNUrAcXXLNKYWmtD6xQrlIXfb2rsOPCv5u00u784rvKl';

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp().whenComplete(() async {
    _auth = FirebaseAuth.instance;
  });
  prefs = await SharedPreferences.getInstance();
  if (user != null)
    FirebaseMessaging.instance.getToken().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .update({'fcm_token': value}).whenComplete(() {
        prefs.setString('fcm_token', value);
      });
    });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      title: 'Kamittee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: AppColor.appThemeColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              AppColor.primary,
            ),
            shape: MaterialStateProperty.all(
              const StadiumBorder(),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              AppColor.primary,
            ),
          ),
        ),
        textTheme: TextTheme(
          headline3: TextStyle(
            color: AppColor.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: AppColor.secondary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          headline5: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.normal,
            fontSize: 25,
          ),
          headline6: TextStyle(
            color: AppColor.primary,
            fontSize: 25,
          ),
          bodyText2: TextStyle(
            color: AppColor.secondary,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
