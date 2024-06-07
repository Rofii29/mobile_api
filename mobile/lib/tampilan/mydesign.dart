import 'package:flutter/material.dart';
import 'package:mobile/alamat/halaman_alamat.dart';
import 'package:mobile/halaman_produk.dart';
import 'beranda.dart'; // Ensure this file is in the correct path
import 'buat.dart'; // Ensure this file is in the correct path


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDesign(),
    );
  }
}

class MyDesign extends StatefulWidget {
  final String imageUrl;
  final String text;
  final String size;

  MyDesign({this.imageUrl = "", this.text = "", this.size = ""});

  @override
  _MyDesignState createState() => _MyDesignState();
}

class _MyDesignState extends State<MyDesign> {
  int _selectedIndex = 2; // Default index to 'My Design' page
  List<Map<String, String>> designs = [];

  @override
  void initState() {
    super.initState();
    if (widget.imageUrl.isNotEmpty || widget.text.isNotEmpty || widget.size.isNotEmpty) {
      designs.add({
        'imageUrl': widget.imageUrl,
        'text': widget.text,
        'size': widget.size,
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Beranda()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Buatan()),
        );
        break;
      case 2:
        // Already on 'My Design' page, no action needed
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => halamanalamat()), // Navigate to HalamanProduk
        );
        break;
       case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HalamanProduk()), // Navigate to HalamanProduk
        );
        break;
    }
  }

  void _addDesign(Map<String, String> design) {
    setState(() {
      designs.add(design);
    });
  }

  void _editDesign(int index, Map<String, String> updatedDesign) {
    setState(() {
      designs[index] = updatedDesign;
    });
  }

  void _deleteDesign(int index) {
    setState(() {
      designs.removeAt(index);
    });
  }

  void _showDesignDialog({Map<String, String>? design, int? index}) {
    final TextEditingController imageUrlController = TextEditingController(text: design?['imageUrl'] ?? '');
    final TextEditingController textController = TextEditingController(text: design?['text'] ?? '');
    final TextEditingController sizeController = TextEditingController(text: design?['size'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Add Design' : 'Edit Design'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Text'),
              ),
              TextField(
                controller: sizeController,
                decoration: InputDecoration(labelText: 'Size'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newDesign = {
                  'imageUrl': imageUrlController.text,
                  'text': textController.text,
                  'size': sizeController.text,
                };

                if (index == null) {
                  _addDesign(newDesign);
                } else {
                  _editDesign(index, newDesign);
                }

                Navigator.of(context).pop();
              },
              child: Text(index == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('My Design'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _showDesignDialog(),
              child: Text('Add Design'),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Image',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Text',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Size',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Actions',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ...designs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final design = entry.value;
                    return TableRow(
                      children: [
                        TableCell(
                          child: design['imageUrl']!.isNotEmpty
                              ? Image.network(
                                  design['imageUrl']!,
                                  fit: BoxFit.contain,
                                )
                              : Container(),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              design['text']!,
                              style: TextStyle(fontSize: 24, color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              design['size']!,
                              style: TextStyle(fontSize: 24, color: Colors.black),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => _showDesignDialog(design: design, index: index),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteDesign(index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure labels are always visible
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 171, 171, 171),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Buat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.straighten),
            label: 'My Design',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari',
          ),
        ],
      ),
    );
  }
}

class Buat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat'),
      ),
      body: Center(
        child: Text(
          'Halaman Buat',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
