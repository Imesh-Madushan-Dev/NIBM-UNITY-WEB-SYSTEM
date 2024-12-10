import 'package:flutter/material.dart';
import 'package:nibm_unity/pages/landing_pages/about_section.dart';
import 'package:nibm_unity/pages/landing_pages/services_section.dart';
import 'package:nibm_unity/pages/landing_pages/hero_section.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.white, width: 1),
                //     borderRadius: BorderRadius.circular(100),
                //   ),
                //   child: GestureDetector(
                //     onTap: () {
                //       //navigate to login page
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (context) => const LoginPage(),
                //         ),
                //       );
                //     },
                //     child: const Padding(
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                //       child: Text(
                //         'Login',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
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
                  // case 3:
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => const LoginPage(),
                  //     ),
                  //   );
                  // break;
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
                // const PopupMenuItem<int>(
                //   value: 3,
                //   child: Text(
                //     'Login',
                //     style: TextStyle(color: kMainColor),
                //   ),
                // ),
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
                  Container(key: _homeKey, child: const HeroSection()),
                  Divider(
                    color: Colors.grey[500],
                    thickness: 1,
                  ),
                  Container(key: _servicesKey, child: ServicesSection()),
                  Container(key: _aboutKey, child: const AboutSection()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
