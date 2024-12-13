import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService()
      : _model = GenerativeModel(
          model: 'gemini-pro', // Consider making this configurable
          apiKey: dotenv.env['GEMINI_API']!,
        );

  Future<String?> generateText(String prompt) async {
    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text;
    } catch (e) {
      print('Error generating content: $e');
      return null; // Or throw an exception
    }
  }
}