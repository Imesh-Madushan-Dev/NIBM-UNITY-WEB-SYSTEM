import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../widgets/event_card.dart';
import '../login_page.dart';

class EventCardsPage extends StatefulWidget {
  const EventCardsPage({super.key});

  @override
  State<EventCardsPage> createState() => _EventCardsPageState();
}

class _EventCardsPageState extends State<EventCardsPage> {
  //* Correctly define the stream to listen for changes
  late final Stream<List<Map<String, dynamic>>> _eventStream;

  @override
  void initState() {
    super.initState();
    //* Initialize the stream in initState
    _eventStream = Supabase.instance.client
        .from('nibm_events')
        .stream(primaryKey: ['id']).order(
      'date',
      ascending: true,
    );
  }

  //* Alert Box
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
                            backgroundColor:
                                WidgetStateProperty.all(kWhiteColor)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    return Scaffold(
      body: GradientContainer(
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
              padding: EdgeInsets.only(left: isDesktop ? 100 : 15),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 30,
              ),
              color: kWhiteColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Ongoing Events',
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
          // backgroundColor: const Color(0xffe6e9fd),

          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 100 : 15,
              vertical: 20,
            ),
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

                final events = snapshot.data!;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = (constraints.maxWidth > 1200)
                        ? 3
                        : (constraints.maxWidth > 600)
                            ? 2
                            : 1;

                    return MasonryGridView.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return GestureDetector(
                          onTap: _alertBox,
                          child: EventCard(
                            title: event['title'] ?? 'No Title',
                            description:
                                event['description'] ?? 'No Description',
                            imageUrl: event['image'] ??
                                'https://via.placeholder.com/150',
                            date: event['date'] ?? 'No Date',
                            time: event['time'] ?? 'No Time',
                            location: event['location'] ?? 'No Location',
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  //* Custom Header
}
