import 'package:flutter/widgets.dart';

import '../../responsive/responsive.dart';
import 'editor_desktop.dart';
import 'editor_mobile.dart';
import 'editor_tablet.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: EditorScreenMobile(),
      tablet: EditorScreenTablet(),
      desktop: EditorScreenDesktop(),
    );
  }
}
