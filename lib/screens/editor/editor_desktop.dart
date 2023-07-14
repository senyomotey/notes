import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorScreenDesktop extends StatefulWidget {
  const EditorScreenDesktop({Key? key}) : super(key: key);

  @override
  State<EditorScreenDesktop> createState() => EditorScreenDesktopState();
}

class EditorScreenDesktopState extends State<EditorScreenDesktop> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(),
    );
  }
}
