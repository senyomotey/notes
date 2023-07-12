import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'home_desktop.dart';
import 'home_mobile.dart';
import 'home_tablet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: HomeScreenMobile(),
      tablet: HomeScreenTablet(),
      desktop: HomeScreenDesktop(),
    );
  }
}
