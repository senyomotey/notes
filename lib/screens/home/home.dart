import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'home_desktop.dart';
import 'home_mobile.dart';
import 'home_tablet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: HomeScreenMobile(),
      tablet: HomeScreenTablet(),
      desktop: HomeScreenDesktop(),
    );
  }
}
