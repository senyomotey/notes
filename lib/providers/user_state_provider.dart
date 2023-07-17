import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:notes/routes/route_names.dart';

import '../constants/colors.dart';
import '../utilities/notify.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserStateProvider with ChangeNotifier {
  Box userBox = Hive.box('user');
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  // variables and functions of login screen
  login({required BuildContext context}) async {
    if (emailTextEditingController.text.isEmpty) {
      Notify().showSnackBar(
          message: AppLocalizations.of(context)!.alert_empty_email, color: errorSnackbarColor, context: context);

      return;
    }

    if (passwordTextEditingController.text.isEmpty) {
      Notify().showSnackBar(
          message: AppLocalizations.of(context)!.alert_empty_password, color: errorSnackbarColor, context: context);

      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );

      // fetch token
      String? token = await userCredential.user!.getIdToken();

      // Save user information and token in hive
      userBox.put("uuid", userCredential.user!.uid);
      userBox.put("email", userCredential.user!.email);
      userBox.put("token", token);
      userBox.put("loggedIn", true);

      emailTextEditingController.clear();
      passwordTextEditingController.clear();

      notifyListeners();

      // Navigate to the home screen
      Navigator.pushReplacementNamed(context, RouteNames.homeScreenRoute);
    } catch (e) {
      Notify().showSnackBar(message: e.toString(), color: errorSnackbarColor, context: context);
    }
  }

  // variables and functions of sign up screen
  signUp({required BuildContext context}) async {
    if (emailTextEditingController.text.isEmpty) {
      Notify().showSnackBar(
          message: AppLocalizations.of(context)!.alert_empty_email, color: errorSnackbarColor, context: context);

      return;
    }

    if (passwordTextEditingController.text.isEmpty) {
      Notify().showSnackBar(
          message: AppLocalizations.of(context)!.alert_empty_password, color: errorSnackbarColor, context: context);

      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text,
      );

      // fetch token
      String? token = await userCredential.user!.getIdToken();

      // Save user information and token in hive
      userBox.put("uuid", userCredential.user!.uid);
      userBox.put("email", userCredential.user!.email);
      userBox.put("token", token);
      userBox.put("loggedIn", true);

      emailTextEditingController.clear();
      passwordTextEditingController.clear();

      notifyListeners();

      // Navigate to the home screen
      Navigator.pushReplacementNamed(context, RouteNames.homeScreenRoute);
    } catch (e) {
      Notify().showSnackBar(message: e.toString(), color: errorSnackbarColor, context: context);
    }
  }

  signOut({required BuildContext context}) {
    Notify().showConfirmationDialog(
      context: context,
      message: AppLocalizations.of(context)!.signout_alert,
      positveAction: () {
        userBox.put('loggedIn', false);

        Navigator.pushNamedAndRemoveUntil(context, RouteNames.loginScreenRoute, (route) => false);
      },
    );
  }
}
