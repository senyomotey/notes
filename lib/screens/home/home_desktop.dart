import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({Key? key}) : super(key: key);

  @override
  State<HomeScreenDesktop> createState() => HomeScreenDesktopState();
}

class HomeScreenDesktopState extends State<HomeScreenDesktop> with TickerProviderStateMixin {
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
