import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditorScreenTablet extends StatefulWidget {
  const EditorScreenTablet({Key? key}) : super(key: key);

  @override
  State<EditorScreenTablet> createState() => EditorScreenTabletState();
}

class EditorScreenTabletState extends State<EditorScreenTablet> with TickerProviderStateMixin {
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
