import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../routes/route_names.dart';

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
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(),
    );
  }
}