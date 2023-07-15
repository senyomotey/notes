import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchScreenTablet extends StatefulWidget {
  const SearchScreenTablet({Key? key}) : super(key: key);

  @override
  State<SearchScreenTablet> createState() => SearchScreenTabletState();
}

class SearchScreenTabletState extends State<SearchScreenTablet> with TickerProviderStateMixin {
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
