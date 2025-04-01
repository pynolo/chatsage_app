import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'enum.dart';
import 'state/app_state.dart';
import 'theme_page.dart';

class AttitudePage extends StatefulWidget {
  const AttitudePage({super.key, required this.title});

  final String title;

  @override
  State<AttitudePage> createState() => _AttitudePageState();
}

class _AttitudePageState extends State<AttitudePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey6,
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Next'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ThemePage(title: 'Theme Chat'),
              ),
            );
          },
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title),
            Consumer<AppState>(
              builder:
                  (context, appState, child) =>
                      Text('Current attitude: ${appState.attitude}'),
            ),
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  AppState().setAttitude(Attitude.values[index]);
                  print('Current attitude changed to: ${AppState().attitude}');
                  setState(() {});
                },
                children:
                    Attitude.values
                        .map(
                          (attitude) =>
                              Center(child: Text(attitude.toString())),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
