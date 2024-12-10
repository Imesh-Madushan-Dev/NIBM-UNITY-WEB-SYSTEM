import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';
import '../../widgets/animated_container.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;
    bool isHovered = false;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
      ),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Text(
            "About NIBM Events",
            style: TextStyle(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: kMainColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isDesktop
                ? "Your central hub for all NIBM campus events across Sri Lanka"
                : "Your central hub for all NIBM campus \nevents across Sri Lanka",
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: kBlackColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Mission Points and What We Offer Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                isDesktop: isDesktop,
                size: size,
                title: "Our Mission",
                content:
                    "NIBM Events serves as a comprehensive platform to connect students, faculty, and staff across all NIBM branches. We aim to foster community engagement and ensure no one misses out on the valuable opportunities for learning, networking, and cultural exchange that our events provide.",
                isHovered: isHovered,
              ),

              // What We Offer Section
              _buildSection(
                isDesktop: isDesktop,
                size: size,
                title: "What We Offer",
                content: "", // Content is now inside the custom layout
                isHovered: isHovered,
                customContent: Column(
                  children: [
                    Row(
                      mainAxisAlignment: isDesktop
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Categories
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Event Categories",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 208, 0),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildBulletPoint(
                                  "Academic Conferences", isDesktop),
                              _buildBulletPoint(
                                  "Cultural Celebrations", isDesktop),
                              _buildBulletPoint(
                                  "Professional Workshops", isDesktop),
                              _buildBulletPoint(
                                  "Sports Tournaments", isDesktop),
                              _buildBulletPoint("Tech Innovations", isDesktop),
                            ],
                          ),
                        ),
                        // Features
                        if (isDesktop) const SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Features",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 208, 0),
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildBulletPoint("Real-time Updates", isDesktop),
                              _buildBulletPoint(
                                  "Branch-specific Filtering", isDesktop),
                              _buildBulletPoint(
                                  "Category-based Search", isDesktop),
                              _buildBulletPoint(
                                  "Event Registration", isDesktop),
                              _buildBulletPoint(
                                  "Calendar Integration", isDesktop),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // Helper function to build a section (Our Mission or What We Offer)
  Widget _buildSection({
    required bool isDesktop,
    required Size size,
    required String title,
    required String content,
    required bool isHovered,
    Widget? customContent,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 120 : 15, vertical: isDesktop ? 40 : 20),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: CusAnimatedContainer(
          isHovered: isHovered,
          isDesktop: isDesktop,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: isDesktop ? 40 : 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                  ),
                ),
                const SizedBox(height: 16),
                if (content.isNotEmpty)
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: isDesktop ? 16 : 14,
                      fontWeight: FontWeight.w400,
                      color: kWhiteColor,
                    ),
                  ),
                if (customContent != null) customContent,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to create bullet points
  Widget _buildBulletPoint(String text, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_box_outline_blank_outlined,
            color: kWhiteColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isDesktop ? 14 : 12,
                color: kWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
