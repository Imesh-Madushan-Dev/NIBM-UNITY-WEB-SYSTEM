import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';

class GradientContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsets? padding;
  final DecorationImage? image;

  const GradientContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
    this.padding,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration:
           BoxDecoration(gradient: kContainerGradient, image: image),
      child: child,
    );
  }
}
