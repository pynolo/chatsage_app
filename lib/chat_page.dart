import 'package:flutter/cupertino.dart';
import 'widgets/chat_area.dart';
import 'widgets/chat_text_field.dart';
import 'enum.dart';
import 'business/api_connector.dart';
import 'business/api_dto.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.title,
    required this.attitude,
    this.assistantId,
  });

  final String title;
  final Attitude attitude;
  final String? assistantId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Attitude _attitude;
  late String? _assistantId;
  final List<String> _chatLines = [];

  @override
  void initState() {
    super.initState();
    _attitude = widget.attitude;
    _assistantId = widget.assistantId;
    _chatLines.add('Welcome to Theme Chat!');
    _chatLines.add('Your current attitude is: $_attitude');
  }

  @override
  void didUpdateWidget(ChatPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.attitude != widget.attitude) {
      setState(() {
        _attitude = widget.attitude;
        _assistantId = widget.assistantId;
        _chatLines.add('Attitude changed to: $_attitude');
      });
    }
  }

  void _addMessage(String message) {
    if (_assistantId != null) {
      setState(() {
        _chatLines.add(message);
        ApiConnector.chat(ChatRequest(assistantId: _assistantId!, query: message));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_assistantId == null) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
        child: SafeArea(
          child: Column(
            children: [
              Text(
                "No assistant selected, please select an assistant before chatting",
              ),
            ],
          ),
        ),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: ChatArea(chatLines: _chatLines)),
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
    }
  }
}
