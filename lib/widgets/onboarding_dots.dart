import 'package:flutter/material.dart';

class OnboardingDots extends StatelessWidget {
  final bool isActive;

  const OnboardingDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive ? 7 : 5,
      width: isActive ? 18 : 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.redAccent : Color.fromARGB(255, 204, 204, 204),
        border: isActive
            ? Border.all(
                color: Colors.redAccent,
                width: 2.0,
              )
            : Border.all(
                color: Colors.transparent,
                width: 1,
              ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

//Color(0xff927DFF)
