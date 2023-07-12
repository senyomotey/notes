import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'launch_desktop.dart';
import 'launch_mobile.dart';
import 'launch_tablet.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: LaunchScreenMobile(),
      tablet: LaunchScreenTablet(),
      desktop: LaunchScreenDesktop(),
    );
  }
}
