import 'package:flutter/foundation.dart';
import '../enum.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  Attitude _attitude = Attitude.kind;
  String? _assistantId;
  final List<ChatLine> _chatLines = [];

  Attitude get attitude => _attitude;
  String? get assistantId => _assistantId;
  List<ChatLine> get chatLines => _chatLines;

  void setAttitude(Attitude value) {
    _attitude = value;
    notifyListeners();
  }

  void setAssistantId(String value) {
    _assistantId = value;
    notifyListeners();
  }

  void addChatLine(String message, Speaker speaker) {
    _chatLines.add(ChatLine(message: message, speaker: speaker));
    notifyListeners();
  }

  void clearChat() {
    _chatLines.clear();
    notifyListeners();
  }
}

class ChatLine {
  final String message;
  final Speaker speaker;

  ChatLine({required this.message, required this.speaker});
}
