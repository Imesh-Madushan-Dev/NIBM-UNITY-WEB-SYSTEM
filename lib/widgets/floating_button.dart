import 'package:flutter/material.dart';

class CustomFloatingBtn extends StatelessWidget {
  final Color? bgColor;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final Widget child;
  const CustomFloatingBtn(
      {super.key,
      this.bgColor,
       this.icon,
      this.iconColor,
      this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: bgColor,
      elevation: 3,
      child: child,
    );
  }
}
