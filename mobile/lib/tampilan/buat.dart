import 'package:flutter/material.dart';
import 'package:mobile/alamat/halaman_alamat.dart';
import 'package:mobile/halaman_produk.dart';
import 'text.dart'; // Import file text.dart
import 'gallery.dart'; // Import file gallery.dart
import 'beranda.dart'; // Import file beranda.dart
import 'ukuran.dart'; // Import file ukuran.dart
import 'mydesign.dart'; // Import file mydesign.dart

void main() => runApp(Buatan());

class Buatan extends StatefulWidget {
  final String imageUrl;
  final String text;

  Buatan({this.imageUrl = "", this.text = ""});

  @override
  _BuatanState createState() => _BuatanState();
}

class _BuatanState extends State<Buatan> {
  int _selectedIndex = 1;
  String _displayText = "";
  String _selectedSize = "";
  Offset _textPosition = Offset(0, 0);
  Offset _sizePosition = Offset(0, 50);

  @override
  void initState() {
    super.initState();
    _displayText = widget.text;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Beranda()),
        );
        break;
      case 1:
        setState(() {
          _selectedIndex = index;
        });
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyDesign()),
        );
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

  void _navigateToGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GalleryScreen()),
    );
  }

  void _navigateToUkuran() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UkuranBajuScreen()),
    );
    if (result != null) {
      setState(() {
        _selectedSize = result;
      });
    }
  }

  void _navigateToText() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TextScreen()),
    );
    if (result != null) {
      setState(() {
        _displayText = result;
      });
    }
  }

  void _saveDesign() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyDesign(
          imageUrl: widget.imageUrl,
          text: _displayText,
          size: _selectedSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Fashion Design',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fashion Design'),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveDesign,
            ),
          ],
        ),
        body: Stack(
          children: [
            if (widget.imageUrl.isNotEmpty)
              Center(
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            if (_displayText.isNotEmpty)
              Positioned(
                left: _textPosition.dx,
                top: _textPosition.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _textPosition += details.delta;
                    });
                  },
                  child: Text(
                    _displayText,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
            if (_selectedSize.isNotEmpty)
              Positioned(
                left: _sizePosition.dx,
                top: _sizePosition.dy,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _sizePosition += details.delta;
                    });
                  },
                  child: Text(
                    _selectedSize,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  ),
                ),
              ),
            Positioned(
              bottom: 10.0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.checkroom, color: Colors.white),
                                onPressed: _navigateToGallery,
                              ),
                              Text(
                                'Pakaian',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.straighten, color: Colors.white),
                                onPressed: _navigateToUkuran,
                              ),
                              Text(
                                'Ukuran',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.text_fields, color: Colors.white),
                                onPressed: _navigateToText,
                              ),
                              Text(
                                'Tulisan',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(child: Container()), // Filler to push bottom navigation to the bottom
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Add this line
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 171, 171, 171),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
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
              label: 'My design',
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
      ),
    );
  }
}
