import 'package:flutter/cupertino.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({super.key, required this.chatLines});

  final List<String> chatLines;

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: CupertinoColors.systemGrey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:
                      widget.chatLines
                          .map(
                            (line) => Padding(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                4.0,
                                8.0,
                                4.0,
                              ),
                              child: Text(line),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
