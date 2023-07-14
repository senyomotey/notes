import 'package:flutter/widgets.dart';

import '../../models/note.dart';
import '../../responsive/responsive.dart';
import 'reader_desktop.dart';
import 'reader_mobile.dart';
import 'reader_tablet.dart';

class ReaderScreen extends StatelessWidget {
  final Note note;

  const ReaderScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: ReaderScreenMobile(note: note),
      tablet: const ReaderScreenTablet(),
      desktop: const ReaderScreenDesktop(),
    );
  }
}
