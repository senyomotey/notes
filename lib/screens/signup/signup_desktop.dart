import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/routes/route_names.dart';
import 'package:provider/provider.dart';
import '../../providers/user_state_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreenDesktop extends StatefulWidget {
  const SignUpScreenDesktop({Key? key}) : super(key: key);

  @override
  State<SignUpScreenDesktop> createState() => SignUpScreenDesktopState();
}

class SignUpScreenDesktopState extends State<SignUpScreenDesktop> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Consumer<UserStateProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              Container(
                height: deviceHeight,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50.0),
                    Text(
                      AppLocalizations.of(context)!.get_started,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.getFont(
                        'Nunito',
                        textStyle: TextStyle(color: textHintColor, fontSize: 65.0, fontWeight: FontWeight.w900),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      padding: const EdgeInsets.only(top: 3.0, right: 8.0, left: 5.0, bottom: 3.0),
                      decoration: BoxDecoration(
                        color: actionBarItemBackgroundColor,
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      child: TextField(
                        controller: value.emailTextEditingController,
                        maxLines: 1,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.email,
                          hintStyle: GoogleFonts.getFont(
                            'Nunito',
                            textStyle: TextStyle(color: textHintColor, fontSize: 20.0, fontWeight: FontWeight.w300),
                          ),
                          prefixIcon: Icon(Icons.person, color: actionBarItemIconColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.only(top: 3.0, right: 8.0, left: 5.0, bottom: 3.0),
                      decoration: BoxDecoration(
                        color: actionBarItemBackgroundColor,
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      child: TextField(
                        controller: value.passwordTextEditingController,
                        maxLines: 1,
                        obscureText: true,
                        style: GoogleFonts.getFont(
                          'Nunito',
                          textStyle: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w300),
                        ),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.password,
                          hintStyle: GoogleFonts.getFont(
                            'Nunito',
                            textStyle: TextStyle(color: textHintColor, fontSize: 20.0, fontWeight: FontWeight.w300),
                          ),
                          prefixIcon: Icon(Icons.password, color: actionBarItemIconColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.have_account,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.getFont(
                            'Nunito',
                            textStyle: TextStyle(color: textHintColor, fontSize: 20.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            value.emailTextEditingController.clear();
                            value.passwordTextEditingController.clear();

                            value.notifyListeners();

                            Navigator.pushReplacementNamed(context, RouteNames.loginScreenRoute);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.getFont(
                              'Nunito',
                              textStyle:
                                  TextStyle(color: negativeButtonColor, fontSize: 20.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Container(
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: positiveButtonColor,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                        onPressed: () {
                          value.signUp(context: context);
                        },
                        child: Container(
                            height: 55.0,
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'Nunito',
                                textStyle:
                                    TextStyle(color: negativeButtonColor, fontSize: 23.0, fontWeight: FontWeight.w700),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70.0),
            ],
          ),
        );
      },
    );
  }
}
