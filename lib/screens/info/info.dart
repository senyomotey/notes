import 'package:flutter/widgets.dart';
import '../../responsive/responsive.dart';
import 'info_desktop.dart';
import 'info_mobile.dart';
import 'info_tablet.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: InfoScreenMobile(),
      tablet: InfoScreenTablet(),
      desktop: InfoScreenDesktop(),
    );
  }
}
