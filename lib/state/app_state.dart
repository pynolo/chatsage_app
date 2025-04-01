import 'package:flutter/foundation.dart';
import '../enum.dart';

class AppState extends ChangeNotifier {
  static final AppState _instance = AppState._internal();
  factory AppState() => _instance;
  AppState._internal();

  Attitude _attitude = Attitude.kind;
  String? _assistantId;
  final List<String> _chatLines = [];

  Attitude get attitude => _attitude;
  String? get assistantId => _assistantId;
  List<String> get chatLines => _chatLines;

  void setAttitude(Attitude value) {
    _attitude = value;
    notifyListeners();
  }

  void setAssistantId(String value) {
    _assistantId = value;
    notifyListeners();
  }

  void addChatLine(String message) {
    _chatLines.add(message);
    notifyListeners();
  }

  void clearChat() {
    _chatLines.clear();
    notifyListeners();
  }
}
