import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';

class GradientContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets? padding;

  const GradientContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: const BoxDecoration(gradient: kContainerGradient),
      child: child,
    );
  }
}
