import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import '../business/file_content.dart';

class FileUploadButton extends StatelessWidget {
  final String label;
  final String? type;
  final Function(FileContent) onFileSelected;

  const FileUploadButton({
    super.key,
    required this.label,
    this.type,
    required this.onFileSelected,
  });

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: type == null ? FileType.any : FileType.custom,
      allowedExtensions: type == null ? null : [type!],
    );

    if (result != null) {
      final file = result.files.first;
      onFileSelected(
        FileContent(
          fileName: file.name,
          mimeType: file.extension ?? 'application/octet-stream',
          bytes: file.bytes!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.doc, color: CupertinoColors.systemGrey),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
