import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'read_desktop.dart';
import 'read_mobile.dart';
import 'read_tablet.dart';

class ReadScreen extends StatelessWidget {
  const ReadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: ReadScreenMobile(),
      tablet: ReadScreenTablet(),
      desktop: ReadScreenDesktop(),
    );
  }
}
