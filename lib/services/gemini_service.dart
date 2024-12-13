import 'package:flutter/material.dart';
import 'package:nibm_unity/models/ai_chat_model.dart';
import 'package:provider/provider.dart';

class GeminiPromptPage extends StatefulWidget {
  const GeminiPromptPage({super.key});

  @override
  State<GeminiPromptPage> createState() => _GeminiPromptPageState();
}

class _GeminiPromptPageState extends State<GeminiPromptPage> {
  final TextEditingController _promptController = TextEditingController();

  
  String _generatedText = '';
  bool _isLoading = false;

  Future<void> _generateText(GeminiService geminiService) async {
    setState(() {
      _isLoading = true;
      _generatedText = '';
    });

    final prompt = _promptController.text;
    final generatedText =
        await geminiService.generateText(prompt);

    setState(() {
      _isLoading = false;
      if (generatedText != null) {
        _generatedText = generatedText;
      } else {
        _generatedText = 'Failed to generate text.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final geminiService = Provider.of<GeminiService>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _promptController,
            decoration: const InputDecoration(
              hintText: 'Enter your prompt',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : () => _generateText(geminiService),
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Text('Generate'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_generatedText),
            ),
          ),
        ],
      ),
    );
  }
}
