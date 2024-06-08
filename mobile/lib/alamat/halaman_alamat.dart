import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/alamat/detail_alamat.dart';
import 'package:mobile/alamat/editalamat.dart';
import 'package:mobile/alamat/tambah_alamat.dart';
import 'package:mobile/halaman_produk.dart';
import 'package:mobile/tampilan/beranda.dart';
import 'package:mobile/tampilan/buat.dart';
import 'package:mobile/tampilan/mydesign.dart';

class halamanalamat extends StatefulWidget {
  const halamanalamat({super.key});

  @override
  State<halamanalamat> createState() => _halamanalamatState();
}

class _halamanalamatState extends State<halamanalamat> {
  List _listdata = [];
  bool _loading = true;
  int _selectedIndex = 4; // Initial index for HalamanProduk

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.6/api/readalamat.php'));
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

  Future<bool> _hapus(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.6/api/deletealamat.php'),
        body: {
          "id_alamat": id,
        },
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['pesan'] == 'sukses hapus') {
          return true;
        } else {
          print('Server error: ${result['pesan']}');
          return false;
        }
      } else {
        print('Server error: ${response.statusCode}');
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => HalamanProduk()),
        // );
        break;
      case 4:
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HalamanProduk ()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghapus tombol kembali
        title: Text('Alamat'),
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
                            builder: (context) => detailalamat(
                              produk: item,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        item['nama_lengkap'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text('Nomor: ${item['nomortelp']}'),
                          Text('Kota: ${item['kota']}'),
                          Text('Jalan: ${item['namajalan']}'),
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
                                  builder: (context) => editalamat(
                                    ListData: {
                                      'id_alamat': _listdata[index]['id_alamat'],
                                      'nama_lengkap': _listdata[index]['nama_lengkap'],
                                      'nomortelp': _listdata[index]['nomortelp'],
                                      'kota': _listdata[index]['kota'],
                                      'namajalan': _listdata[index]['namajalan'],
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
                                          _hapus(_listdata[index]['id_alamat']).then((success) {
                                            if (success) {
                                              setState(() {
                                                _listdata.removeAt(index);
                                              });
                                              Navigator.of(context).pop();
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Failed to delete item')),
                                              );
                                            }
                                          });
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
        backgroundColor: Color.fromARGB(255, 3, 101, 213),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => tambahalamat()));
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
