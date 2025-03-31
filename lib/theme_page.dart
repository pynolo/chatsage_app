import 'package:flutter/cupertino.dart';
import 'widgets/file_upload_button.dart';
import 'business/file_content.dart';

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
      navigationBar: CupertinoNavigationBar(middle: Text('Theme Chat')),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FileUploadButton(
              label: 'Upload Document',
              onFileSelected: (file) => setState(() => _files.add(file)),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child:
                  _files.isEmpty
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
            const SizedBox(height: 20),
            CupertinoButton(
              child: const Text('Confirm Theme'),
              onPressed: () {
                Navigator.pushNamed(context, '/chat');
                /* Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/chat',
                  (route) => false,
                ); */
              },
            ),
          ],
        ),
      ),
    );
  }
}
