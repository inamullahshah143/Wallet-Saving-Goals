import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet_saving_goals/screen/components/components.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({String email, String password, BuildContext context}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Components.showSnackBar(
            context, 'provided credentials are already in use');
      } else if (e.code == 'invalid-credential') {
        Components.showSnackBar(context, 'User Credential dosn\'t exits');
      }
    } catch (e) {
      Components.showSnackBar(context, e);
    }
  }

  //SIGN IN METHOD
  Future signIn({String email, String password, BuildContext context}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Components.showSnackBar(
            context, 'provided credentials are already in use');
      } else if (e.code == 'invalid-credential') {
        Components.showSnackBar(context, 'User Credential dosn\'t exits');
      }
    } catch (e) {
      Components.showSnackBar(context, e);
    }
  }

  // SIGN IN With Google
  Future<User> signInWithGoogle({BuildContext context}) async {
    User user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Components.showSnackBar(
              context, 'provided credentials are already in use');
        } else if (e.code == 'invalid-credential') {
          Components.showSnackBar(context, 'User Credential dosn\'t exits');
        }
      } catch (e) {
        Components.showSnackBar(context, e);
      }
    }
    return user;
  }

  Future signOut({BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Components.showSnackBar(context, e);
    }
  }
}
