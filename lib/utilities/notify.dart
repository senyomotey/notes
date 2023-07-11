import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class Notify {
  BuildContext? buildContext;

  Notify({this.buildContext});

  void showSnackBar({required String message, required Color color, required BuildContext context}) {
    var snackbar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void showSnackBarSticky({required String message, required Color color, required BuildContext context}) {
    var snackbar = SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: Duration(days: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  showAlertDialog({required BuildContext context, required String title, required String message}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay') /*Text(AppLocalizations.of(context)!.alert_dialog_affirmative)*/,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showConfirmationDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required Function positveAction}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No') /*Text(AppLocalizations.of(context)!.alert_dialog_negative)*/,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes') /*Text(AppLocalizations.of(context)!.alert_dialog_positive)*/,
              onPressed: () {
                Navigator.of(context).pop();
                positveAction();
              },
            ),
          ],
        );
      },
    );
  }

  showNotification({
    required int id,
    required String channelKey,
    required String title,
    required String body,
  }) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
        autoDismissible: false,
      ),
    );
  }

  dismissNotification(int id) {
    AwesomeNotifications().dismiss(id);
  }
}
