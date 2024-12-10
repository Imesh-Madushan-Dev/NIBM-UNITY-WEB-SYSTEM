import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nibm_unity/pages/landing_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://kibybtoqmezptdypnfqa.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtpYnlidG9xbWV6cHRkeXBuZnFhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5MDYxNTksImV4cCI6MjA0ODQ4MjE1OX0._7zE_ZHaMHhGjMgO7xi8HBK4KsCbMTWovGiiGVzX00A',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'NIBM UNITY',
      home: const LandingPage(),
    );
  }
}
