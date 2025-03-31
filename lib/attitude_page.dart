import 'package:flutter/cupertino.dart';
import 'enum.dart';

class AttitudePage extends StatefulWidget {
  const AttitudePage({super.key, required this.title});

  final String title;
  static Attitude _attitude = Attitude.kind;

  static Attitude get attitude => _attitude;
  static void setAttitude(Attitude value) => _attitude = value;

  @override
  State<AttitudePage> createState() => _AttitudePageState();
}

class _AttitudePageState extends State<AttitudePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Theme Chat')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title),
            Text('Current attitude: ${AttitudePage.attitude}'),
            SizedBox(
              height: 200,
              child: CupertinoPicker(
                itemExtent: 40,
                onSelectedItemChanged: (index) {
                  AttitudePage.setAttitude(Attitude.values[index]);
                  print(
                    'Current attitude changed to: ${AttitudePage.attitude}',
                  );
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
            const SizedBox(height: 20),
            CupertinoButton(
              child: const Text('Confirm Attitude'),
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder:
                      (context) => CupertinoAlertDialog(
                        title: const Text('Confirm Attitude'),
                        content: Text(
                          'Selected attitude: ${AttitudePage.attitude}',
                        ),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/theme');
                            },
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
