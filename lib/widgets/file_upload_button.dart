import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    } else if (Platform.isIOS) {
      // On iOS, we don't need to request storage permission explicitly
      // as it's handled by the file picker
      return true;
    } else if (kIsWeb) {
      // Web doesn't need explicit permissions
      return true;
    }
    return false;
  }

  Future<void> _pickFile(BuildContext context) async {
    if (kIsWeb) {
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
            content: file.bytes!,
          ),
        );
      }
      return;
    }

    final hasPermission = await _requestPermissions();
    if (!hasPermission) {
      print('Permission not granted');
      showCupertinoDialog(
        context: context,
        builder:
            (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Error'),
              content: const Text('File access: Permission not granted'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
      // Show error message or prompt user to enable permissions in settings
      return;
    }

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
          content: file.bytes!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickFile(context),
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
