import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: const Center(
        child:  Text(
          'About Us',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
