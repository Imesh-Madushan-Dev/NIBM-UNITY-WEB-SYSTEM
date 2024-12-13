import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

import '../login_page.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _isHoveredViewEvents = false;
  bool _isHoveredGetStarted = false;

  void _onHoverViewEvents(bool isHovered) {
    setState(() {
      _isHoveredViewEvents = isHovered;
    });
  }

  void _onHoverGetStarted(bool isHovered) {
    setState(() {
      _isHoveredGetStarted = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: size.height * 0.9,
          width: size.width,
          child: Column(
            children: [
              GradientContainer(
                height: size.height * 0.6,
                width: size.width,
                image: DecorationImage(
                  image: const NetworkImage(
                      "https://i.ibb.co/jLpyqCR/background.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(30),
                    BlendMode.dstATop,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isDesktop
                          ? 'Welcome to NIBM UNITY'
                          : 'Welcome to \nNIBM UNITY',
                      style: TextStyle(
                        fontSize: isDesktop ? 60 : 40,
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
                        color: Colors.grey[200],
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    isDesktop
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MouseRegion(
                                onEnter: (_) => _onHoverViewEvents(true),
                                onExit: (_) => _onHoverViewEvents(false),
                                child: _animatedButton(
                                  context,
                                  "View Events",
                                  () {
                                    context.push('/no-log-events');
                                  },
                                  _isHoveredViewEvents
                                      ? Colors.white
                                      : kWhiteColor.withAlpha(35),
                                  Colors.white,
                                  _isHoveredViewEvents
                                      ? Colors.black
                                      : Colors.white,
                                  Icons.event,
                                ),
                              ),
                              const SizedBox(width: 20),
                              MouseRegion(
                                onEnter: (_) => _onHoverGetStarted(true),
                                onExit: (_) => _onHoverGetStarted(false),
                                child: _animatedButton(
                                  context,
                                  "Get Started",
                                  () {
                                    context.push('/login');
                                  },
                                  _isHoveredGetStarted
                                      ? Colors.white
                                      : kWhiteColor.withAlpha(35),
                                  Colors.white,
                                  _isHoveredGetStarted
                                      ? Colors.black
                                      : Colors.white,
                                  Icons.arrow_forward,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MouseRegion(
                                onEnter: (_) => _onHoverViewEvents(true),
                                onExit: (_) => _onHoverViewEvents(false),
                                child: _animatedButton(
                                  context,
                                  "View Events",
                                  () {
                                    context.push('/landing/no-log-events');
                                  },
                                  _isHoveredViewEvents
                                      ? Colors.white
                                      : kWhiteColor.withAlpha(35),
                                  Colors.white,
                                  _isHoveredViewEvents
                                      ? Colors.black
                                      : Colors.white,
                                  Icons.event,
                                ),
                              ),
                              const SizedBox(height: 20),
                              MouseRegion(
                                onEnter: (_) => _onHoverGetStarted(true),
                                onExit: (_) => _onHoverGetStarted(false),
                                child: _animatedButton(
                                  context,
                                  "Get Started",
                                  () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  },
                                  _isHoveredGetStarted
                                      ? Colors.white
                                      : kWhiteColor.withAlpha(35),
                                  Colors.white,
                                  _isHoveredGetStarted
                                      ? Colors.black
                                      : Colors.white,
                                  Icons.arrow_forward,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _cardWidget(context, "50+", "Upcoming Events"),
                  _cardWidget(context, "10K+", "Active Students"),
                  _cardWidget(context, "10+", "Clubs & Societies"),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }

  //* Animated Button Widget
  Widget _animatedButton(
      BuildContext context,
      String text,
      final VoidCallback onPressed,
      Color fillColor,
      Color borderColor,
      Color textColor,
      IconData icon) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 13 : 8,
        horizontal: isDesktop ? 30 : 20,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 25,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: isDesktop ? 20 : 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* Card Widget
  Widget _cardWidget(BuildContext context, String title, String description) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: isDesktop ? 40 : 30,
            color: kMainColor,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: isDesktop ? 300 : 80,
          child: Text(
            description,
            style: TextStyle(
              fontSize: isDesktop ? 20 : 15,
              color: kBlackColor,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
