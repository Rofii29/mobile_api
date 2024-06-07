import 'package:flutter/material.dart';

class DetailProduk extends StatelessWidget {
  final Map produk;

  const DetailProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      produk['image_url'] ?? 'https://smpn3girimulyo.sch.id/media_library/images/078cef7e0da81598b49794ea180ade91.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    produk['nama'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.straighten, color: Colors.deepOrange),
                  title: Text(
                    'Ukuran',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(produk['ukuran']),
                ),
                ListTile(
                  leading: Icon(Icons.attach_money, color: Colors.deepOrange),
                  title: Text(
                    'Harga',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Rp ${produk['harga']}'),
                ),
                ListTile(
                  leading: Icon(Icons.category, color: Colors.deepOrange),
                  title: Text(
                    'Jenis Baju',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(produk['jenis_baju']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
