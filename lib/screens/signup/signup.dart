import 'package:flutter/widgets.dart';
import '../../responsive/responsive.dart';
import 'signup_desktop.dart';
import 'signup_mobile.dart';
import 'signup_tablet.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: SignUpScreenMobile(),
      tablet: SignUpScreenTablet(),
      desktop: SignUpScreenDesktop(),
    );
  }
}
