import 'package:flutter/material.dart';
import 'package:nibm_unity/pages/login_page.dart';
import 'package:nibm_unity/pages/main_pages/hero_section.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _buildHeader(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return GradientContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  onPressed: () {},
                  child:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('About',
                      style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Contact',
                      style: TextStyle(color: Colors.white)),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      //navigate to login page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                
                  HeroSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
