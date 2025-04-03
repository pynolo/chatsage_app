import 'dart:typed_data';
import 'package:chatsage_app/business/api_dto.dart';

class FileContent {
  final String fileName;
  final String mimeType;
  final Uint8List content;

  FileContent({
    required this.fileName,
    required this.mimeType,
    required this.content,
  });

  FileDto toFileDto() {
    return FileDto(fileName: fileName, mimeType: mimeType, content: content);
  }
}
