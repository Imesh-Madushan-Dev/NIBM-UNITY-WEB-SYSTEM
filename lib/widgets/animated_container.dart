import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CusAnimatedContainer extends StatelessWidget {
  final bool isHovered;
  final bool isDesktop;
  final Widget child;
  final double? width;
  const CusAnimatedContainer(
      {super.key,
      required this.isHovered,
      required this.isDesktop,
      required this.child,  this.width});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // gradient: kContainerGradient,
        color: kMainColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            spreadRadius: isHovered ? 6 : 0,
            blurRadius: isHovered ? 6 : 0,
            offset: Offset(
              (isHovered ? 3 : 0),
              (isHovered ? 5 : 0),
            ),
          ),
        ],
      ),
      child: child,
    );
  }
}
