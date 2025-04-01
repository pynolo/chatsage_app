import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'widgets/chat_area.dart';
import 'widgets/chat_text_field.dart';
import 'business/api_connector.dart';
import 'business/api_dto.dart';
import 'state/app_state.dart';
import 'enum.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    final appState = AppState();
    if (appState.chatLines.isEmpty) {
      appState.addChatLine('Welcome to Theme Chat!', Speaker.ai);
      appState.addChatLine(
        'My current attitude is: ${appState.attitude}',
        Speaker.ai,
      );
    }
  }

  void _addMessage(String message) {
    final appState = AppState();
    if (appState.assistantId != null) {
      appState.addChatLine(message, Speaker.human);
      ApiConnector.chat(
        ChatRequest(assistantId: appState.assistantId!, query: message),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        if (appState.assistantId == null) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.systemGrey6,
              middle: Text(widget.title),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "No assistant selected, please select an assistant before chatting",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemGrey6,
            middle: Text(widget.title),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(child: ChatArea(chatLines: appState.chatLines)),
                ChatTextField(
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addMessage(value);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
