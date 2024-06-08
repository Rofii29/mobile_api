import 'package:flutter/material.dart';
import 'package:mobile/alamat/halaman_alamat.dart';
import 'package:mobile/halaman_produk.dart';
import 'package:mobile/profile/profile.dart';
import 'buat.dart'; // Ensure this file is in the correct path
import 'mydesign.dart'; // Ensure this file is in the correct path

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Beranda(),
    );
  }
}

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int _selectedIndex = 0;

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
          MaterialPageRoute(builder: (context) => Buatan()), // Navigate to Buatan
        );
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
          MaterialPageRoute(builder: (context) => halamanalamat()), // Navigate to Halaman Alamat
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HalamanProduk()), // Navigate to Halaman Produk
        );
        break;
    }
  }

  void _goToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: _goToProfilePage, // Add the onTap action
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  'https://torch.id/cdn/shop/articles/style_casual_pria_indonesia.webp?v=1701262587',
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'FASHION',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Ingin style apa hari ini?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 180.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildImageItem('https://cdns.klimg.com/dream.co.id/resources//real/2023/08/21/1140177/blazer.jpg', 'Kasual'),
                buildImageItem('https://shopee.co.id/inspirasi-shopee/wp-content/uploads/2023/09/smart-casual-outfit-8.jpg', 'Smart Casual'),
                buildImageItem('https://cdn.antaranews.com/cache/1200x800/2024/03/26/1000003926.jpg', 'chic'),
                buildImageItem('https://www.smartfren.com/app/uploads/2021/12/featured-image-22.png', 'Streetwear'),
                buildImageItem('https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/radarmalang/2021/09/18-Vintage-Lokks.jpg', 'Vintage'),
                buildImageItem('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd2Ppsr8eQ4yHcvhtb3-DyiBFeVGXmJAg--A&s', 'sporty'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildHorizontalImagePair(
                  'https://asset.kompas.com/crops/95izYJtVJU7igRCVAa275CkwQFY=/0x58:913x667/230x153/data/photo/2024/01/10/659e01f11bee9.jpg', '8 Kombinasi pakaian yang tidak pernah salah',
                  'https://asset.kompas.com/crops/gCoQbqsz3uVXW3CUkEsDsT6KXQg=/0x0:0x0/230x153/data/photo/2024/05/27/6653fee6bd8c4.jpg', 'Motif Tradisional Aceh Diangkat Jadi Fashion Agar Tak Hilang Ditelan Jaman '),
                buildHorizontalImagePair(
                  'https://asset.kompas.com/crops/kEXBiCd07bjA8O_kQ1x9aeswafs=/0x0:0x0/230x153/data/photo/2024/05/27/6653fedb83b35.jpg', 'Dekranasda Aceh Selatan Angkat Motif Tradisional ke Ranah Fashion',
                  'https://asset.kompas.com/crops/2sy_RB9bQSRIsoaDrVnrM3LwL0M=/426x0:3804x2252/230x153/data/photo/2024/05/17/6646e0e594aa0.jpg', 'Cerita Zahro Manfaatkan Arang Batok Kelapa untuk Bisnis Pakaian'),
                buildHorizontalImagePair(
                  'https://asset.kompas.com/crops/uXz0yCFDvMUoXEeqm0r1DSZQZZI=/67x4:2070x1339/230x153/data/photo/2024/05/11/663ef59c7ff12.jpg', 'Inspirasi Gaya Sporty dari Legenda Tenis Roger Federer',
                  'https://asset.kompas.com/crops/QDIB4EcOP_9Po_tTCQ-PftB4HGE=/0x0:826x551/230x153/data/photo/2024/05/16/66456888d5a75.jpg', 'Memadukan Tren Mode Tahun 80-an untuk Tampil Masa Kini'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 171, 171, 171),
        showSelectedLabels: true,
        showUnselectedLabels: true,
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

  Widget buildImageItem(String imageUrl, String label) {
    return Container(
      width: 160.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 120.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalImagePair(String imageUrl1, String label1, String imageUrl2, String label2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildVerticalImageItem(imageUrl1, label1),
        buildVerticalImageItem(imageUrl2, label2),
      ],
    );
  }

  Widget buildVerticalImageItem(String imageUrl, String label) {
    return Container(
      width: 160.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
