import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/alamat/halaman_alamat.dart';
import 'package:mobile/detail_produk.dart';
import 'package:mobile/edit_produk.dart';
import 'package:mobile/tambah_produk.dart';
import 'package:mobile/tampilan/beranda.dart';
import 'package:mobile/tampilan/buat.dart';
import 'package:mobile/tampilan/mydesign.dart';

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;
  int _selectedIndex = 4; // Initial index for HalamanProduk

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.6/api/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data as List;
          _loading = false;
        });
      } else {
        print('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future _hapus(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.6/api/delete.php'),
        body: {
          "id_produk": id,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => HalamanProduk()),
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghapus tombol kembali
        title: Text('Cari Barang'),
        backgroundColor: Colors.blue,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _getData,
              child: ListView.builder(
                itemCount: _listdata.length,
                itemBuilder: (context, index) {
                  final item = _listdata[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailProduk(
                              produk: item,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        item['nama'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text('Size: ${item['ukuran']}'),
                          Text('Price: ${item['harga']}'),
                          Text('Type: ${item['jenis_baju']}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditProduk(
                                    ListData: {
                                      'id_produk': _listdata[index]['id_produk'],
                                      'nama': _listdata[index]['nama'],
                                      'ukuran': _listdata[index]['ukuran'],
                                      'harga': _listdata[index]['harga'],
                                      'jenis_baju': _listdata[index]['jenis_baju'],
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Confirm Delete'),
                                    content: Text('Are you sure you want to delete this item?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _hapus(_listdata[index]['id_produk']).then((value) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => HalamanProduk()),
                                              (Route<dynamic> route) => false,
                                            );
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Delete', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 245, 53, 4),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahProduk()));
        },
        child: Icon(Icons.add),
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
}
