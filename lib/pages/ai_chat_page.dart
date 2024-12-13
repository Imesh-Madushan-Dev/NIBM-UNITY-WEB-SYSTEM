import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/models/ai_chat_model.dart';
import 'package:nibm_unity/widgets/floating_button.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Use a more concise prompt
  final String customPrompt =
      "You're Gunapala, a helpful NIBM camp chatbot. Answer only about camps. If not, be witty and confused, using emojis and short answers.";

  @override
  void initState() {
    super.initState();
    _messages = [
      const ChatMessage(
        "I'm Gunapala, your NIBM camp guide! 🏕️ Ask me anything about our camps!",
        false,
      )
    ];

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateAndScrollToBottom();
    });
  }

  // Combined animation and scroll for efficiency
  void _animateAndScrollToBottom() {
    _animationController.forward();
    _scrollToBottom();
  }

  Future<void> _sendMessage(GeminiService geminiService,
      [String? quickMessage]) async {
    final messageText = quickMessage ?? _messageController.text;
    if (messageText.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(messageText, true));
      _isLoading = true;
    });

    _messageController.clear();
    _scrollToBottom();

    _animationController.reset();
    _animationController.forward();

    try {
      final generatedText =
          await geminiService.generateText("$customPrompt $messageText");
      if (mounted) {
        setState(() {
          _messages.add(
              ChatMessage(generatedText ?? "Failed to get response.", false));
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(const ChatMessage(
              "Oops! Something went wrong. Please try again.", false));
          _isLoading = false;
        });
      }
    } finally {
      if (mounted) {
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geminiService = Provider.of<GeminiService>(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    return Scaffold(
      body: GradientContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 150 : 15,
          ),
          child: Column(
            children: [
              SizedBox(height: isDesktop ? 40 : 20),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(width: isDesktop ? 20 : 10),
                  const Text(
                    "NIBM AI Agent",
                    style: TextStyle(
                      fontSize: 22,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ChatListView(
                  messages: _messages,
                  scrollController: _scrollController,
                  animation: _animation,
                ),
              ),
              _buildMessageInputArea(geminiService),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInputArea(GeminiService geminiService) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _messageController,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(geminiService),
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Type your message...",
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CustomFloatingBtn(
            icon: Icons.send,
            onPressed: () => _isLoading ? null : _sendMessage(geminiService),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: kMainColor,
                    ),
                  )
                : const Icon(Icons.send, color: kMainColor),
          ),
        ],
      ),
    );
  }
}

class ChatListView extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final Animation<double> animation;

  const ChatListView({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (index == 0 || index >= messages.length - 2) {
          return FadeTransition(
            opacity: animation,
            child: messages[index],
          );
        } else {
          return messages[index];
        }
      },
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage(this.text, this.isUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth * 0.75,
            ),
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUser ? Colors.blue[200] : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20),
                bottomLeft: isUser
                    ? const Radius.circular(20)
                    : const Radius.circular(0),
                bottomRight: isUser
                    ? const Radius.circular(0)
                    : const Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.4 * 255).toInt()),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                MarkdownBody(
                  data: text,
                  selectable: true,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.3,
                      fontFamilyFallback: [
                        GoogleFonts.roboto().fontFamily ?? 'Roboto',
                        GoogleFonts.notoColorEmoji().fontFamily ??
                            'NotoColorEmoji',
                      ],
                    ),
                    strong: const TextStyle(fontWeight: FontWeight.bold),
                    code: TextStyle(
                      backgroundColor: Colors.grey[400],
                      fontFamily: 'RobotoMono',
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
