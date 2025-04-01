import 'package:flutter/cupertino.dart';
import 'widgets/file_upload_button.dart';
import 'business/file_content.dart';
import 'business/api_connector.dart';
import 'business/api_dto.dart';
import 'state/app_state.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key, required this.title});

  final String title;

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final List<FileContent> _files = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemGrey6,
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Next'),
          onPressed: () async {
            showCupertinoDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const CupertinoActivityIndicator(),
            );

            AssistantResponse assistantResponse =
                await ApiConnector.createAssistant(
              AssistantRequest(
                files: _files.map((file) => file.toFileDto()).toList(),
              ),
            );
            print('assistantId: ${assistantResponse.assistantId}');
            AppState().setAssistantId(assistantResponse.assistantId);
            Navigator.of(context).pop(); // Dismiss loading indicator
            Navigator.pushNamed(
              context,
              '/chat',
              arguments: <String, String>{
                'title': widget.title,
              },
            );
          },
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FileUploadButton(
              label: 'Upload Document',
              type: 'txt,pdf,docx',
              onFileSelected: (file) => setState(() => _files.add(file)),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: _files.isEmpty
                  ? const Center(child: Text('No files uploaded'))
                  : ListView.builder(
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 16,
                          ),
                          child: Text(
                            _files[index].fileName,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
