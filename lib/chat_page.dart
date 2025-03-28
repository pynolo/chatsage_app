import 'package:flutter/cupertino.dart';
import 'enum.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;
  static Attitude _attitude = Attitude.kind;

  static Attitude get attitude => _attitude;
  static void setAttitude(Attitude value) => _attitude = value;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Theme Chat')),
      child: Center(child: Text('Chat Page')),
    );
  }
}
