import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ActionBarButton extends StatelessWidget {
  final Icon icon;
  final Function onTap;

  const ActionBarButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: actionBarItemBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: icon,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
