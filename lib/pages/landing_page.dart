import 'package:flutter/material.dart';
import 'package:nibm_unity/pages/landing_pages/about_section.dart';
import 'package:nibm_unity/pages/landing_pages/services_section.dart';
import 'package:nibm_unity/pages/landing_pages/hero_section.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

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

    return GradientContainer(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'NIBM UNITY',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          if (isDesktop)
            Row(
              children: [
                TextButton(
                  onPressed: () => _scrollToSection(_homeKey),
                  child:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(_servicesKey),
                  child: const Text('Services',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => _scrollToSection(_aboutKey),
                  child: const Text('About',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          else
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: Colors.white),
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
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Home'),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Services'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('About'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(key: _homeKey, child:  const HeroSection()),
                  Divider(
                    color: Colors.grey[500],
                    thickness: 1,
                  ),
                  Container(key: _servicesKey, child: ServicesSection()),
                  Divider(
                    color: Colors.grey[500],
                    thickness: 1,
                  ),
                  Container(key: _aboutKey, child: const AboutSection()),
                  const GradientContainer(
                      child: Center(
                          child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Made with ❤️ by NIBM Students',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
