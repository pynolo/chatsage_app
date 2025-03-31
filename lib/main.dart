import 'package:flutter/cupertino.dart';
import 'enum.dart';
import 'attitude_page.dart';
import 'chat_page.dart';
import 'theme_page.dart';

void main() {
  runApp(const ThemeChatApp());
}

class ThemeChatApp extends StatelessWidget {
  const ThemeChatApp({super.key});

  final AttitudePage attitudePage = const AttitudePage(title: 'Chat Attitude');
  final ThemePage themePage = const ThemePage(title: 'Chat Theme');
  final ChatPage chatPage = const ChatPage(
    title: 'Theme Chat',
    attitude: Attitude.kind,
    assistantId: null,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Theme Chat',
      initialRoute: '/',
      routes: {
        '/': (context) => attitudePage,
        '/attitude': (context) => attitudePage,
        '/theme': (context) => themePage,
        '/chat': (context) => chatPage,
      },

      //debugShowCheckedModeBanner: false,
    );
  }
}
