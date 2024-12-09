import 'package:flutter/material.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                GradientContainer(
                  height: size.height * 0.7,
                  width: size.width,
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      Text(
                        'Welcome to NIBM UNITY!',
                        style: TextStyle(
                          fontSize: isDesktop ? 60 : 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Your gateway to campus events, activities, and unforgettable experiences.',
                        style: TextStyle(
                          fontSize: isDesktop ? 20 : 14,
                          color: Colors.white.withAlpha((0.4 * 255).toInt()),
                        ),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  //* desktop view widget

  Widget _desktopView(Size size) {
    return Placeholder();
  }

  //* mobile view widget

  Widget _mobileView(Size size) {
    return Column(
      children: [
        const SizedBox(height: 100),
        const Text(
          'Welcome to NIBM UNITY!',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          'Your gateway to campus events, activities, and unforgettable experiences.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha((0.4 * 255).toInt()),
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
