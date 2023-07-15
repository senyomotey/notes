import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'pin_mobile.dart';

class PinScreen extends StatelessWidget {
  final String mode;

  const PinScreen({Key? key, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: PinScreenMobile(mode: mode),
      tablet: PinScreenMobile(mode: mode),
      desktop: PinScreenMobile(mode: mode),
    );
  }
}
