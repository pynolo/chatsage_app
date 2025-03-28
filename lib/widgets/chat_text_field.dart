import 'package:flutter/cupertino.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key, required this.onSubmitted});

  final void Function(String) onSubmitted;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _text = '';

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_text.isNotEmpty) {
      widget.onSubmitted(_text);
      _controller.clear();
      setState(() {
        _text = '';
      });
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              focusNode: _focusNode,
              placeholder: 'Type a message...',
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 8),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.arrow_up_circle_fill),
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }
}
