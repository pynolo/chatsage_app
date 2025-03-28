import 'dart:typed_data';

class FileContent {
  final String fileName;
  final String mimeType;
  final Uint8List bytes;

  FileContent({
    required this.fileName,
    required this.mimeType,
    required this.bytes,
  });
}
