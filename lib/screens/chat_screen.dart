import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];
  bool _isTyping = false;

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, _ChatMessage(text: text.trim(), isUser: true));
      _isTyping = true;
    });

    _controller.clear();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages.insert(
          0,
          _ChatMessage(
            text:
                "Thanks for sharing! I'll analyze your cycle and share insights soon.",
            isUser: false,
          ),
        );
        _isTyping = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _messages.insert(
        0,
        _ChatMessage(
          text: 'Talk to me',
          isUser: false,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask Ovia AI"),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == 0) {
                  return _TypingIndicator();
                }

                final message = _messages[_isTyping ? index - 1 : index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Colors.pink.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: message.isUser
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            margin: const EdgeInsets.only(bottom: 80),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      hintText: "Ask about your cycle...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.pink),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}

class _TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text("Ovia is typing..."),
      ),
    );
  }
}
