import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class Notify {
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
      duration: const Duration(days: 1),
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
              child: const Text('Okay') /*Text(AppLocalizations.of(context)!.alert_dialog_affirmative)*/,
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
      {required BuildContext context, required String message, required Function positveAction}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 30.0),
          actionsPadding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          title: const Icon(Icons.info, color: Colors.white, size: 40.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    textStyle: const TextStyle(color: Colors.white, fontSize: 23.0, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: negativeButtonColor,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50.0,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.alert_dialog_negative,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: positiveButtonColor,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);

                      positveAction();
                    },
                    child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.alert_dialog_positive,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.getFont(
                            'Nunito',
                            textStyle:
                                TextStyle(color: positiveButtonColor, fontSize: 20.0, fontWeight: FontWeight.w700),
                          ),
                        )),
                  ),
                ),
              ],
            )
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
