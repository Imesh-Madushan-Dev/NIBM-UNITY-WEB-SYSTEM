import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase
import '../models/event_model.dart';

class EventService {
  final supabase = Supabase.instance.client;

  //* Fetch all data from Supabase events table
  Future<List<Event>> fetchEvents() async {
    final response = await supabase.from('tableevents').select();

    final List<dynamic> data = response as List<dynamic>;
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }
}
