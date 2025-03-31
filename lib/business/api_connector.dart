import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:theme_chat/business/api_dto.dart';
import 'package:theme_chat/constants.dart';

class ApiConnector {
  static Future<AssistantResponse> createAssistant(
    AssistantRequest request,
  ) async {
    print('calling createAssistant');
    final response = await http.post(
      Uri.parse(Constants.assistantEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return AssistantResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to generate response: ${response.statusCode}');
    }
  }

  static Future<AssistantResponse> updateAssistant(
    AssistantRequest request,
  ) async {
    print('calling updateAssistant');
    if (request.assistantId == null) {
      throw Exception('Assistant ID is required');
    }
    final response = await http.put(
      Uri.parse('${Constants.assistantEndpoint}/${request.assistantId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return AssistantResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to generate response: ${response.statusCode}');
    }
  }

  static Future<ChatResponse> chat(ChatRequest request) async {
    print('calling chat');
    final response = await http.get(
      Uri.parse(
        '${Constants.chatEndpoint}'
        '?assistantId=${request.assistantId}'
        '&query=${Uri.encodeComponent(request.query)}',
      ),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return ChatResponse.fromJson(responseData);
    } else {
      throw Exception('Failed to generate response: ${response.statusCode}');
    }
  }
}
