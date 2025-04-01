import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:theme_chat/attitude_page.dart';
import 'package:theme_chat/theme_page.dart';
import 'package:theme_chat/chat_page.dart';
import 'state/app_state.dart';

void main() {
  runApp(const ThemeChatApp());
}

class ThemeChatApp extends StatelessWidget {
  const ThemeChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: CupertinoApp(
        title: 'Theme Chat',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AttitudePage(title: 'Theme Chat Attitude'),
          '/theme': (context) => ThemePage(title: 'Theme Chat'),
          '/chat': (context) => ChatPage(title: 'Theme Chat'),
        },
      ),
    );
  }
}
