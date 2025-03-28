import 'package:flutter/cupertino.dart';
import 'widgets/chat_area.dart';
import 'widgets/chat_text_field.dart';
import 'attitude_page.dart';
import 'enum.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;
  static Attitude _attitude = Attitude.kind;

  static Attitude get attitude => _attitude;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _chatLines = [
    'Welcome to Theme Chat!',
    'Your current attitude is: ${AttitudePage.attitude}',
  ];

  void _addMessage(String message) {
    setState(() {
      _chatLines.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
      child: Column(
        children: [
          Expanded(child: ChatArea(chatLines: _chatLines)),
          Expanded(child: ChatTextField(onSubmitted: _addMessage)),
        ],
      ),
    );
  }
}
