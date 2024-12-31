import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/pages/landing_pages/about_section.dart';
import 'package:nibm_unity/pages/landing_pages/services_section.dart';
import 'package:nibm_unity/pages/landing_pages/hero_section.dart';
import 'package:nibm_unity/widgets/floating_button.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

   static const TextStyle _headerStyle = TextStyle(color: kWhiteColor);
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  final GlobalKey _homeKey = GlobalKey();

  final GlobalKey _servicesKey = GlobalKey();

  final GlobalKey _aboutKey = GlobalKey();

  //* Header
  Widget _buildHeader(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GradientContainer(
          padding: EdgeInsets.symmetric(
              horizontal: 40, vertical: isDesktop ? 20 : 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NIBM UNITY',
                style: GoogleFonts.knewave(color: kWhiteColor, fontSize: 20),
              ),
              if (isDesktop)
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _scrollToSection(_homeKey),
                      child: const Text('Home', style: _headerStyle),
                    ),
                    TextButton(
                      onPressed: () => _scrollToSection(_servicesKey),
                      child: const Text('Services', style: _headerStyle),
                    ),
                    TextButton(
                      onPressed: () => _scrollToSection(_aboutKey),
                      child: const Text('About', style: _headerStyle),
                    ),
                  ],
                )
              else
                PopupMenuButton<int>(
                  icon: const Icon(Icons.menu, color: kWhiteColor),
                  onSelected: (int value) {
                    switch (value) {
                      case 0:
                        _scrollToSection(_homeKey);
                        break;
                      case 1:
                        _scrollToSection(_servicesKey);
                        break;
                      case 2:
                        _scrollToSection(_aboutKey);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        'Home',
                        style: _headerStyle.copyWith(color: kMainColor),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        'Services',
                        style: _headerStyle.copyWith(color: kMainColor),
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Text(
                        'About',
                        style: _headerStyle.copyWith(color: kMainColor),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CustomFloatingBtn(
          bgColor: kMainColor,
          onPressed: () => context.push('/ai-chat'),
          child: SvgPicture.asset(
            'assets/stars.svg',
            height: 30,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      Container(key: _homeKey, child: const HeroSection()),
                      Container(key: _servicesKey, child: ServicesSection()),
                      Divider(
                        color: Colors.grey[500],
                        thickness: 1,
                      ),
                      Container(key: _aboutKey, child: const AboutSection()),
                      GradientContainer(
                          child: Center(
                              child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                          'Made with ❤️ by NIBM Students',
                          style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamilyFallback: [
                              GoogleFonts.roboto().fontFamily ?? 'Roboto',
                              GoogleFonts.notoColorEmoji().fontFamily ??
                                  'NotoColorEmoji',
                            ],
                          ),
                        ),
                      ))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _buildHeader(context),
        ],
      ),
    );
  }
}
