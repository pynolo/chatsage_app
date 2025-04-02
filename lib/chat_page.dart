import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'widgets/chat_area.dart';
import 'widgets/chat_text_field.dart';
import 'business/api_connector.dart';
import 'business/api_dto.dart';
import 'state/app_state.dart';
import 'enum.dart';
import 'config.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appState = AppState();
      if (appState.chatLines.isEmpty) {
        _sendPrompt();
      }
    });
  }

  void _sendPrompt() async {
    final appState = AppState();
    String prompt;
    switch (appState.attitude) {
      case Attitude.kind:
        prompt = Config.attitudeKind;
        break;
      case Attitude.joking:
        prompt = Config.attitudeJoking;
        break;
      default:
        prompt = Config.attitudeOffensive;
        break;
    }
    if (appState.assistantId != null) {
      print("sending prompt to assistant: $prompt");
      appState.addChatLine(prompt, Speaker.prompt);
      ChatResponse response = await ApiConnector.chat(
        ChatRequest(assistantId: appState.assistantId!, query: prompt),
      );
      print("received response from assistant: ${response.answer}");
      appState.addChatLine(response.answer, Speaker.ai);
    }
  }

  void _sendMessage(String message) async {
    final appState = AppState();
    if (appState.assistantId != null) {
      print("sending message to assistant: $message");
      appState.addChatLine(message, Speaker.human);
      ChatResponse response = await ApiConnector.chat(
        ChatRequest(assistantId: appState.assistantId!, query: message),
      );
      print("received response from assistant: ${response.answer}");
      appState.addChatLine(response.answer, Speaker.ai);
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
                      _sendMessage(value);
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
