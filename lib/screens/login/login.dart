import 'package:flutter/widgets.dart';
import '../../responsive/responsive.dart';
import 'login_desktop.dart';
import 'login_mobile.dart';
import 'login_tablet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: LoginScreenMobile(),
      tablet: LoginScreenTablet(),
      desktop: LoginScreenDesktop(),
    );
  }
}
