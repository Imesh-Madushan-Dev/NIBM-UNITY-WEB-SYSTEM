import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String time;
  final String location;
  final String category;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.time,
    required this.location,
    required this.category,
  });

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        width: isDesktop ? 200 : double.infinity,
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.all(15), // Constant margin
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14), // Use Flutter's BorderRadius
          color: Colors.white, // Use colors from your theme if possible
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? kMainColor.withAlpha((0.6 * 255).toInt())
                  : Colors.black.withAlpha((0.2 * 255).toInt()),
              spreadRadius: 0,
              blurRadius: _isHovered ? 15 : 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Zoom Effect
            AspectRatio(
              aspectRatio: 1 / 1, // Maintain 1:1 aspect ratio
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const AspectRatio(
                    aspectRatio:
                        1 / 1, // Maintain 1:1 aspect ratio for placeholder
                    child: Placeholder(),
                  ),
                ),
              ),
            ),

            // Card Content
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GradientContainer(
                    radius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Text(
                        widget.category,
                        style: const TextStyle(color: kWhiteColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Use Text widgets with styles from your theme
                  _rowText(Icons.location_on_outlined, widget.location),
                  const SizedBox(height: 7),
                  _rowText(Icons.calendar_month_outlined, widget.date),
                  const SizedBox(height: 7),
                  _rowText(Icons.access_time_rounded, widget.time),
                  const SizedBox(height: 10),
                  Text(
                    widget.description,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      // Use TextStyle from your theme
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Location, Date, and Time Rows
  Widget _rowText(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: kMainColor, // Use color from your theme or colors.dart
        ),
        const SizedBox(width: 4.0),
        Text(
          text,
          // Use TextStyle from your theme if possible
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
