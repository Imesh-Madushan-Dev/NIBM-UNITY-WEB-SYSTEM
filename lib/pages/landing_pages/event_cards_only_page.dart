import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../widgets/event_card.dart';

class EventCardsPage extends StatefulWidget {
  const EventCardsPage({super.key});

  @override
  State<EventCardsPage> createState() => _EventCardsPageState();
}

enum EventFilter { upcoming, missed }

class _EventCardsPageState extends State<EventCardsPage> {
  late final Stream<List<Map<String, dynamic>>> _eventStream;
  EventFilter _selectedFilter = EventFilter.upcoming;

  @override
  void initState() {
    super.initState();
    _eventStream = Supabase.instance.client
        .from('nibm_events')
        .stream(primaryKey: ['id']).order('date', ascending: true);
  }

  List<Map<String, dynamic>> _filterEvents(
      List<Map<String, dynamic>> events, EventFilter filter) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return events.where((event) {
      final eventDate = DateTime.parse(event['date']);
      final eventStart =
          DateTime(eventDate.year, eventDate.month, eventDate.day);

      switch (filter) {
        case EventFilter.upcoming:
          return eventStart.isAfter(today) ||
              eventStart.isAtSameMomentAs(today);
        case EventFilter.missed:
          return eventStart.isBefore(today);
      }
    }).toList();
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final formatter = DateFormat('EEE, d MMM yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    return GradientContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: kContainerGradient,
            ),
          ),
          toolbarHeight: 80,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 30,
              color: kWhiteColor,
            ),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
          title: const Text(
            'Events',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 50 : 15,
            vertical: 20,
          ),
          child: Column(
            children: [
              _buildFilterSegmentedControl(),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _eventStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No events found'));
                    }

                    final allEvents = snapshot.data!;
                    final filteredEvents =
                        _filterEvents(allEvents, _selectedFilter);

                    if (filteredEvents.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/no_events.png",
                                height: 200),
                            const SizedBox(height: 20),
                            const Text(
                              'No upcoming events',
                              style:
                                  TextStyle(color: kWhiteColor, fontSize: 18),
                            ),
                          ],
                        ),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = (constraints.maxWidth > 1200)
                            ? 4
                            : (constraints.maxWidth > 600)
                                ? 3
                                : 1;

                        return MasonryGridView.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          itemCount: filteredEvents.length,
                          itemBuilder: (context, index) {
                            final event = filteredEvents[index];
                            return GestureDetector(
                              onTap: _alertBox,
                              child: EventCard(
                                title: event['title'] ?? 'No Title',
                                description:
                                    event['description'] ?? 'No Description',
                                imageUrl: event['image'] ??
                                    'https://via.placeholder.com/150',
                                date: _formatDate(event['date'] ?? 'No Date'),
                                time: event['time'] ?? 'No Time',
                                location: event['location'] ?? 'No Location',
                                category: event['category'],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSegmentedControl() {
    return CupertinoSlidingSegmentedControl<EventFilter>(
      groupValue: _selectedFilter,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      thumbColor: CupertinoColors.systemYellow,
      backgroundColor: Colors.grey[300]!,
      onValueChanged: (value) {
        setState(() {
          _selectedFilter = value!;
        });
      },
      children: const <EventFilter, Widget>{
        EventFilter.upcoming: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Upcoming'),
        ),
        EventFilter.missed: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Missed'),
        ),
      },
    );
  }

  void _alertBox() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              gradient: kContainerGradient,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Oi Oi",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Log wela hitapan",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(kWhiteColor),
                        ),
                        onPressed: () {
                          context.go('/login');
                        },
                        child: const Text(
                          'Go to Login',
                          style: TextStyle(color: kBlackColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
