import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  final TextEditingController _textController = TextEditingController();

  void _sendTextBack() {
    Navigator.pop(context, _textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Text'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _sendTextBack,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your text',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendTextBack,
              child: Text('Pilih'),
            ),
          ],
        ),
      ),
    );
  }
}
