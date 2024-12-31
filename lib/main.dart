import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nibm_unity/router/router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/ai_chat_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['URL']!,
    anonKey: dotenv.env['ANON_KEY']!,
  );
  final geminiService = GeminiService();

  runApp(
    Provider<GeminiService>.value(
      value: geminiService,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'NIBM UNITY',

      // Start with the splash screen
      routerConfig: RouterClass().router,
    );
  }
}
