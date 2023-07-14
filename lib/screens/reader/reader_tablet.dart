import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReaderScreenTablet extends StatefulWidget {
  const ReaderScreenTablet({Key? key}) : super(key: key);

  @override
  State<ReaderScreenTablet> createState() => ReaderScreenTabletState();
}

class ReaderScreenTabletState extends State<ReaderScreenTablet> with TickerProviderStateMixin {
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
