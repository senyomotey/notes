import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/utilities/notify.dart';

import '../../widgets/action_bar_button.dart';

// ignore: must_be_immutable
class PinScreenMobile extends StatefulWidget {
  String mode; // modes include create, confirm, login, reset
  String title;
  String subTitle;
  bool isGradientApplied = true;

  /// default [pinLength] is 4
  final int pinLength;

  PinScreenMobile({
    Key? key,
    required this.mode,
    this.title = "Login",
    this.subTitle = "Please enter your pin",
    this.pinLength = 4,
  }) : super(key: key) {
    isGradientApplied = false;
  }

  @override
  State<PinScreenMobile> createState() => PinScreenMobileState();
}

class PinScreenMobileState extends State<PinScreenMobile> /* with SingleTickerProviderStateMixin */ {
  late double deviceWidth;
  late double deviceHeight;
  late int currentDigit;
  late List<int?> pinValues;
  bool showLoadingButton = false;

  late Box userBox;
  late Box accountBox;
  String pin = '';
  String confirmPin = '';

  @override
  void initState() {
    pinValues = List<int?>.filled(widget.pinLength, null, growable: false);

    userBox = Hive.box('user');

    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        if (widget.mode == 'create') {
          if (pin.isNotEmpty) {
            widget.title = 'Create Pin';
            pin = '';

            clearPin();
          } else {
            Navigator.pop(context, false);
          }
        } else {
          Navigator.pop(context, false);
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 45, 0, 45),
          height: MediaQuery.of(context).size.height,
          width: deviceWidth,
          child: getInputPart,
        ),
      ),
    );
  }

  /// Return Title label
  get getTitleText {
    return Text(
      widget.title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 28.0, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
    );
  }

  /// Return subTitle label
  get getSubtitleText {
    return Text(
      widget.subTitle,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w600),
    );
  }

  /// Return "pin" input fields
  get getInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: getPinTextWidgetList(),
    );
  }

  /// Returns pin fields of length [widget.pinLength]
  List<Widget> getPinTextWidgetList() {
    List<Widget> pinList = [];
    for (int i = 0; i < widget.pinLength; i++) {
      pinList.add(pinTextField(pinValues[i]));
    }
    return pinList;
  }

  /// Returns pin screen views
  get getInputPart {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            Visibility(
              visible: widget.mode == 'login' ? false : true,
              child: ActionBarButton(
                icon: Icon(Icons.arrow_back, size: 28.0, color: actionBarItemIconColor),
                onTap: () {
                  if (widget.mode == 'create') {
                    if (pin.isNotEmpty) {
                      widget.title = 'Create Pin';
                      pin = '';

                      clearPin();
                    } else {
                      Navigator.pop(context, false);
                    }
                  } else {
                    Navigator.pop(context, false);
                  }
                },
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 30.0, left: 30.0),
          child: Column(children: [
            Text(
              widget.title,
              style: GoogleFonts.getFont(
                'Nunito',
                textStyle: const TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            Text(
              widget.subTitle,
              style: GoogleFonts.getFont(
                'Nunito',
                textStyle: const TextStyle(color: Colors.white70, fontSize: 21.0, fontWeight: FontWeight.w400),
              ),
            ),
          ]),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: getTitleText,
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   child: getSubtitleText,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: getInputField,
        ),
        getPinKeyboard,
        Visibility(
          visible: widget.mode == 'login' ? true : false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: showForgotPinButton(),
          ),
        )
      ],
    );
  }

  /// Returns "pin" keyboard
  get getPinKeyboard {
    return SizedBox(
        height: deviceWidth - 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  pinKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        setCurrentDigit(1);
                      }),
                  pinKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        setCurrentDigit(2);
                      }),
                  pinKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                pinKeyboardInputButton(
                    label: "4",
                    onPressed: () {
                      setCurrentDigit(4);
                    }),
                pinKeyboardInputButton(
                    label: "5",
                    onPressed: () {
                      setCurrentDigit(5);
                    }),
                pinKeyboardInputButton(
                    label: "6",
                    onPressed: () {
                      setCurrentDigit(6);
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                pinKeyboardInputButton(
                    label: "7",
                    onPressed: () {
                      setCurrentDigit(7);
                    }),
                pinKeyboardInputButton(
                    label: "8",
                    onPressed: () {
                      setCurrentDigit(8);
                    }),
                pinKeyboardInputButton(
                    label: "9",
                    onPressed: () {
                      setCurrentDigit(9);
                    }),
              ],
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    width: 80.0,
                  ),
                  pinKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        setCurrentDigit(0);
                      }),
                  pinKeyboardActionButton(
                      label: const Icon(
                        Icons.backspace,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          for (int i = widget.pinLength - 1; i >= 0; i--) {
                            if (pinValues[i] != null) {
                              pinValues[i] = null;
                              break;
                            }
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  /// Returns "Pin text field"
  Widget pinTextField(int? digit) {
    return Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.white,
      ))),
      child: Text(
        digit != null ? digit.toString() : "",
        style: const TextStyle(
          fontSize: 38.0,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Returns "Pin keyboard input Button"
  Widget pinKeyboardInputButton({required String label, required VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Returns "Pin keyboard action Button"
  pinKeyboardActionButton({required Widget label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  /// sets number into text fields n performs
  ///  validation after last number is entered
  void setCurrentDigit(int i) async {
    setState(() {
      currentDigit = i;
      int currentField;
      for (currentField = 0; currentField < widget.pinLength; currentField++) {
        if (pinValues[currentField] == null) {
          pinValues[currentField] = currentDigit;
          break;
        }
      }

      if (currentField == widget.pinLength - 1) {
        String pinCode = pinValues.join();

        clearPin();

        if (widget.mode == 'create') {
          if (pin.isEmpty) {
            pin = pinCode;

            setState(() {
              widget.title = 'Confirm Pin';
            });
          } else {
            if (pin == pinCode) {
              // save pin in hive
              userBox.put('pin', pin);

              // set loginStatus in Hive to true
              userBox.put('loggedIn', true);

              // open home screen
            } else {
              Notify().showSnackBar(message: 'The pins do not match', color: errorSnackbarColor, context: context);
            }
          }
        } else if (widget.mode == 'login') {
          if (pinCode == userBox.get('pin', defaultValue: '')) {
            // open home screen
          } else {
            Notify()
                .showSnackBar(message: 'You have entered the wrong pin', color: errorSnackbarColor, context: context);
          }
        } else if (widget.mode == 'reset') {
          if (pin.isEmpty) {
            pin = pinCode;

            setState(() {
              widget.title = 'Confirm Pin';
            });
          } else {
            if (pin == pinCode) {
              // save pin in hive
              userBox.put('pin', pin);

              // close this screen
              Navigator.pop(context, true);
            } else {
              Notify().showSnackBar(message: 'The pins do not match', color: errorSnackbarColor, context: context);
            }
          }
        } else {}
        // showLoadingButton = false;
        // clearPin();
      }
    });
  }

  showForgotPinButton() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Forgot your pin?',
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // to clear pin when error occurs
  void clearPin() {
    pinValues = List<int?>.filled(widget.pinLength, null, growable: false);
    setState(() {});
  }
}
