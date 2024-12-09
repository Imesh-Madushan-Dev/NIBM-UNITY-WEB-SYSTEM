import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';

class ServicesSection extends StatelessWidget {
  ServicesSection({super.key});

// Data for mission points
  final List<String> _missionPoints = [
    "Connect students across branches",
    "Streamline event management",
    "Check Reuslts and Lec Materials",
    "All Services in one Home",
  ];

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
      "icon": Icons.school,
      "title": "Knowledge Sharing",
      "description":
          "Foster collaboration and learning through shared experiences and events."
    },
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _missionPoints.map((point) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
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
            }).toList(),
          ),

          const SizedBox(height: 40),

          // Service Cards (Responsive Grid)
          isDesktop
              ? Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: _services
                      .map((service) => SizedBox(
                            width: (size.width -
                                    (isDesktop ? size.width * 0.12 : 32) -
                                    40) /
                                3,
                            child: _buildServiceCard(
                                service['icon'] as IconData,
                                service['title']!,
                                service['description']!,
                                isDesktop),
                          ))
                      .toList(),
                )
              : Column(
                  children: _services
                      .map((service) => Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: _buildServiceCard(
                                service['icon'] as IconData,
                                service['title']!,
                                service['description']!,
                                isDesktop),
                          ))
                      .toList(),
                ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // Service Card Widget
  Widget _buildServiceCard(
      IconData? icon, String title, String description, bool isDesktop) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered =
              true), // Update state using the StatefulBuilder's setState
          onExit: (_) => setState(() => isHovered =
              false), // Update state using the StatefulBuilder's setState
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isDesktop ? 250 : double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: kBlueToLightBlue,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(60),
                  spreadRadius: isHovered ? 10 : 2,
                  blurRadius: isHovered ? 10 : 5,
                  offset: const Offset(1, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null) Icon(icon, size: 40, color: kMainColor),
                if (icon != null) const SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 12,
                    color: kBlackColor,
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
