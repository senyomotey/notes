import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReaderScreenDesktop extends StatefulWidget {
  const ReaderScreenDesktop({Key? key}) : super(key: key);

  @override
  State<ReaderScreenDesktop> createState() => ReaderScreenDesktopState();
}

class ReaderScreenDesktopState extends State<ReaderScreenDesktop> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(),
    );
  }
}
