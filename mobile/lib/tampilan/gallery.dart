import 'package:flutter/material.dart';
import 'buat.dart'; // Import file buat.dart

// void main() {
//   runApp(GalleryScreen());
// }

class GalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Buatan()),
              );
            },
          ),
        ),
        body: VerticalScrollWithButtons(),
      ),
    );
  }
}

class VerticalScrollWithButtons extends StatelessWidget {
  final List<Map<String, String>> images = [
    {'url': 'https://www.paeko.id/storage/products/2d7cd6c8214834ad9a902d4e75324654.png', 'button': 'A'},
    {'url': 'https://www.paeko.id/storage/products/b1c043a714d8b9a0cbcc3077aa3724d9.png', 'button': 'B'},
    {'url': 'https://www.paeko.id/storage/products/d007316a4089475783b0c85023762197.png', 'button': 'C'},
    {'url': 'https://www.paeko.id/storage/products/bd41494775b4484b6db05725442bc566.png', 'button': 'D'},
    {'url': 'https://www.paeko.id/storage/products/3ad7fd428ab726381b422086a44235d0.png', 'button': 'E'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: images.map((image) {
          return ImageWithButton(imageUrl: image['url']!, buttonText: image['button']!);
        }).toList(),
      ),
    );
  }
}

class ImageWithButton extends StatelessWidget {
  final String imageUrl;
  final String buttonText;

  ImageWithButton({required this.imageUrl, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    bool underline = ['A', 'B', 'C', 'D'].contains(buttonText);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.network(imageUrl),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Buatan(imageUrl: imageUrl)),
              );
            },
            child: Text(buttonText),
          ),
          if (underline)
            Container(
              margin: EdgeInsets.only(top: 4.0),
              height: 2.0,
              color: Colors.blue, // Choose the color you prefer for the underline
            ),
        ],
      ),
    );
  }
}
