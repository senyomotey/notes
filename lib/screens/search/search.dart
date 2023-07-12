import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'search_desktop.dart';
import 'search_mobile.dart';
import 'search_tablet.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: SearchScreenMobile(),
      tablet: SearchScreenTablet(),
      desktop: SearchScreenDesktop(),
    );
  }
}
