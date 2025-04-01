import 'package:flutter/cupertino.dart';
import 'package:theme_chat/state/app_state.dart';
import 'package:theme_chat/enum.dart';

class ChatArea extends StatefulWidget {
  const ChatArea({super.key, required this.chatLines});

  final List<ChatLine> chatLines;

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
                          .where((line) => line.speaker != Speaker.prompt)
                          .map(
                            (line) => Padding(
                              padding: const EdgeInsets.fromLTRB(
                                8.0,
                                4.0,
                                8.0,
                                4.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    line.speaker == Speaker.human
                                        ? CupertinoIcons.person_fill
                                        : CupertinoIcons.lightbulb_fill,
                                    color: CupertinoColors.systemGrey,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(line.message)),
                                ],
                              ),
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
