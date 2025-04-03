import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:chatsage_app/attitude_page.dart';
import 'package:chatsage_app/theme_page.dart';
import 'package:chatsage_app/chat_page.dart';
import 'state/app_state.dart';

void main() {
  runApp(const ChatsageApp());
}

class ChatsageApp extends StatelessWidget {
  const ChatsageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: CupertinoApp(
        title: 'ChatSage',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.systemBlue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AttitudePage(title: 'Chat Attitude'),
          '/theme': (context) => ThemePage(title: 'Chat Theme'),
          '/chat': (context) => ChatPage(title: 'ChatSage'),
        },
      ),
    );
  }
}
