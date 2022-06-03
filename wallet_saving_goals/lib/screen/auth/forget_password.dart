import 'package:flutter/material.dart';
import 'package:wallet_saving_goals/constants/color.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';
import 'package:wallet_saving_goals/utils/auth_helper.dart';
import 'package:wallet_saving_goals/utils/helper.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pagesColor,
      appBar: AppBar(
        backgroundColor: AppColor.pagesColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        foregroundColor: AppColor.fonts,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 15.0,
                bottom: 15.0,
              ),
              child: Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Please enter your email to recieve a link to create a new password via email',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.fonts.withOpacity(0.75),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Credentials',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => Helper.validateEmail(value),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.secondary.withOpacity(0.25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Email Address',
                    hintStyle: TextStyle(
                      color: AppColor.fonts.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    Components.showAlertDialog(context);
                    AuthenticationHelper()
                        .resetPassword(context, email.text)
                        .then((res) {
                      if (res == null) {
                        Navigator.of(context).pop();
                        Components.showSnackBar(context,
                            'Your password rest link has been send to your repective email, please have a look');
                      }
                    });
                  }
                },
                child: Text('Send'),
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
      ),
    );
  }
}
