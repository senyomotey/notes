import 'package:flutter/widgets.dart';

import '../../models/note.dart';
import '../../responsive/responsive.dart';
import 'editor_desktop.dart';
import 'editor_mobile.dart';
import 'editor_tablet.dart';

class EditorScreen extends StatelessWidget {
  final Note? note;

  const EditorScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: EditorScreenMobile(note: note),
      tablet: const EditorScreenTablet(),
      desktop: const EditorScreenDesktop(),
    );
  }
}
