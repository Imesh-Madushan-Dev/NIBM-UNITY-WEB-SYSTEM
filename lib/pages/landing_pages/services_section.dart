import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/animated_container.dart';

class ServicesSection extends StatelessWidget {
  ServicesSection({super.key});

  // Data for service cards
  final List<Map<String, dynamic>> _services = [
    {
      "icon": Icons.people,
      "title": "Connect Students",
      "description":
          "Bringing together students from all branches to create a vibrant community."
    },
    {
      "icon": Icons.event,
      "title": "Event Management",
      "description":
          "Seamlessly organize and participate in events across all departments."
    },
    {
      "icon": Icons.star,
      "title": "Recognition",
      "description":
          "Celebrate achievements and milestones within our university community."
    },
    {
      "icon": Icons.event,
      "title": "Check Results & Materials",
      "description":
          "Access exam results and lecture materials easily through the platform."
    },
    {
      "icon": Icons.home,
      "title": "All Services in One Home",
      "description":
          "A unified platform for all your university needs, simplifying access to information and services."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isDesktop = size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? size.width * 0.06 : 16,
        vertical: 40,
      ),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Text(
            "Our Mission",
            style: TextStyle(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: kMainColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "To unite students and staff across university branches, fostering collaboration, celebration, and community through organized events.",
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: kBlackColor,
            ),
          ),
          const SizedBox(height: 16),

          // Mission Points
          _buildMissionPoints(isDesktop),

          const SizedBox(height: 40),

          // Service Cards (Optimized)
          _buildServiceCards(isDesktop, size),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // Optimized Mission Points Widget
  Widget _buildMissionPoints(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMissionPoint("Connect students across branches", isDesktop),
        _buildMissionPoint("Streamline event management", isDesktop),
        _buildMissionPoint("Check Results and Lecture Materials", isDesktop),
        _buildMissionPoint("All Services in one Home", isDesktop),
      ],
    );
  }

  // Helper for creating individual mission points
  Widget _buildMissionPoint(String point, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_box_outline_blank_outlined,
              color: kMainColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: isDesktop ? 16 : 14,
                color: kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Optimized Service Cards Widget
  Widget _buildServiceCards(bool isDesktop, Size size) {
    return isDesktop
        ? Wrap(
            spacing: 20,
            runSpacing: 20,
            children: _services.map((service) {
              return SizedBox(
                width: isDesktop
                    ? (size.width - (size.width * 0.12) - 40) / 3
                    : size.width - 32,
                child: _buildServiceCard(
                  service['icon'] as IconData,
                  service['title']!,
                  service['description']!,
                  isDesktop,
                ),
              );
            }).toList(),
          )
        : Column(
            children: _services.map((service) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _buildServiceCard(
                  service['icon'] as IconData,
                  service['title']!,
                  service['description']!,
                  isDesktop,
                ),
              );
            }).toList(),
          );
  }

  // Service Card Widget
  Widget _buildServiceCard(
    IconData icon,
    String title,
    String description,
    bool isDesktop,
  ) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: CusAnimatedContainer(
            isHovered: isHovered,
            isDesktop: isDesktop,
            width: isDesktop ? 250 : double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 40, color: kWhiteColor),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 12,
                    color: kWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
