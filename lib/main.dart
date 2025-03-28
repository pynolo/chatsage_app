import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'attitude_page.dart';

void main() {
  runApp(const ThemeChatApp());
}

class ThemeChatApp extends StatelessWidget {
  const ThemeChatApp({super.key});

  final AttitudePage attitudePage = const AttitudePage(
    title: 'Theme Chat Attitude',
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Theme Chat',
      initialRoute: '/attitude',
      routes: {
        '/attitude': (context) => attitudePage,
        '/': (context) => attitudePage,
      },

      //debugShowCheckedModeBanner: false,
    );
  }
}
