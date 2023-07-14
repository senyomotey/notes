import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreenDesktop extends StatefulWidget {
  const SearchScreenDesktop({Key? key}) : super(key: key);

  @override
  State<SearchScreenDesktop> createState() => SearchScreenDesktopState();
}

class SearchScreenDesktopState extends State<SearchScreenDesktop> with TickerProviderStateMixin {
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
