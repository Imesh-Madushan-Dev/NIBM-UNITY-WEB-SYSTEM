import 'package:flutter/material.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String? description;
  final String imageUrl;
  final String date;
  final String time;
  final String location;
  final String category;

  const EventCard({
    super.key,
    required this.title,
    this.description,
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
  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
        bottom: 5,
      ), // Constant margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14), // Use Flutter's BorderRadius
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Zoom Effect
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: AspectRatio(
              aspectRatio: 1 / 1, // Maintain 1:1 aspect ratio
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
                errorBuilder: (context, error, stackTrace) => const AspectRatio(
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
                  widget.description!,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    // Use TextStyle from your theme
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border_rounded),
                          onPressed: () {
                            // Implement your logic here
                          },
                        ),
                        const Text('123'),
                      ],
                    ), // Replace with your likes count

                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            // Implement your logic here
                          },
                        ),
                        const Text('456'), // Replace with your views count
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          onPressed: () {
                            // Implement your logic here
                          },
                        ),
                        const Text('789'), // Replace with your shares count
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
