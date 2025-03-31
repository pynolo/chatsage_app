import 'dart:typed_data';
import 'package:theme_chat/business/api_dto.dart';

class FileContent {
  final String fileName;
  final String mimeType;
  final Uint8List bytes;

  FileContent({
    required this.fileName,
    required this.mimeType,
    required this.bytes,
  });

  FileDto toFileDto() {
    return FileDto(fileName: fileName, mimeType: mimeType, bytes: bytes);
  }
}
