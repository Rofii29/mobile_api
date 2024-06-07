import 'package:flutter/material.dart';

class detailalamat extends StatelessWidget {
  final Map produk;

  const detailalamat({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail alamat'),
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
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.deepOrange,
                    child: Text(
                      produk['nama_lengkap'][0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    produk['nama_lengkap'],
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
                  leading: Icon(Icons.phone, color: Colors.deepOrange),
                  title: Text(
                    'Nomor Telepon',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(produk['nomortelp']),
                ),
                ListTile(
                  leading: Icon(Icons.location_city, color: Colors.deepOrange),
                  title: Text(
                    'Kota',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(produk['kota']),
                ),
                ListTile(
                  leading: Icon(Icons.location_on, color: Colors.deepOrange),
                  title: Text(
                    'Nama Jalan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(produk['namajalan']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
