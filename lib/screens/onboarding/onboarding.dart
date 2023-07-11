import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'onboarding_desktop.dart';
import 'onboarding_mobile.dart';
import 'onboarding_tablet.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: OnboradingScreenMobile(),
      tablet: OnboradingScreenTablet(),
      desktop: OnboradingScreenDesktop(),
    );
  }
}
