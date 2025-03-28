import 'dart:typed_data';
import 'dart:convert';

class AssistantRequest {
  final String? assistantId;
  final List<FileDto> files;

  // Assistant API DTOs

  AssistantRequest({this.assistantId, required this.files});

  Map<String, dynamic> toJson() {
    return {
      'assistantId': assistantId,
      'files': files.map((file) => file.toJson()).toList(),
    };
  }

  factory AssistantRequest.fromJson(Map<String, dynamic> json) {
    return AssistantRequest(
      assistantId: json['assistantId'] as String?,
      files: json['files'].map((file) => FileDto.fromJson(file)).toList(),
    );
  }
}

class FileDto {
  final String fileName;
  final String mimeType;
  final Uint8List bytes;

  FileDto({
    required this.fileName,
    required this.mimeType,
    required this.bytes,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'mimeType': mimeType,
      'bytes': base64Encode(bytes),
    };
  }

  factory FileDto.fromJson(Map<String, dynamic> json) {
    return FileDto(
      fileName: json['fileName'] as String,
      mimeType: json['mimeType'] as String,
      bytes: base64Decode(json['bytes'] as String),
    );
  }
}

class AssistantResponse {
  final String assistantId;

  AssistantResponse({required this.assistantId});

  Map<String, dynamic> toJson() {
    return {'assistantId': assistantId};
  }

  factory AssistantResponse.fromJson(Map<String, dynamic> json) {
    return AssistantResponse(assistantId: json['assistantId'] as String);
  }
}

// Chat API DTOs

class ChatRequest {
  final String assistantId;
  final String query;

  ChatRequest({required this.assistantId, required this.query});

  Map<String, dynamic> toJson() {
    return {'assistantId': assistantId, 'query': query};
  }

  factory ChatRequest.fromJson(Map<String, dynamic> json) {
    return ChatRequest(
      assistantId: json['assistantId'] as String,
      query: json['query'] as String,
    );
  }
}

class ChatResponse {
  final String answer;

  ChatResponse({required this.answer});

  Map<String, dynamic> toJson() {
    return {'answer': answer};
  }

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(answer: json['answer'] as String);
  }
}
