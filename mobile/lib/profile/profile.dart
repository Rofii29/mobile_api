import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/profile/detail_profile.dart';
import 'package:mobile/profile/edit_profile.dart';
import 'package:mobile/profile/tambah_profile.dart';
import 'package:mobile/tampilan/beranda.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List _listdata = [];
  bool _loading = true;

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.6/api/readprofile.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            _listdata = data;
            _loading = false;
          });
        } else {
          // Handle unexpected data format
          print('Unexpected data format: $data');
        }
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
        Uri.parse('http://192.168.1.6/api/delete.profile.php'),
        body: {
          "id_profile": id,
        },
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['pesan'] == 'sukses hapus') {
          return true;
        } else {
          print('Error: ${result['pesan']}');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('PROFILE'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Beranda()),
            );
          },
        ),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0), // Ubah padding di sini
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 4), // Ubah jarak antar elemen di sini
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => detailprofile(
                                    produk: item,
                                  ),
                                ),
                              );
                            },
                            title: Center(
                              child: Text(
                                item['nama'],
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            subtitle: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text('Email: ${item['email']}'),
                                  Text('Password: ${item['password']}'),
                                ],
                              ),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => editprofile(
                                        ListData: {
                                          'id_profile': _listdata[index]['id_profile'],
                                          'nama': _listdata[index]['nama'],
                                          'email': _listdata[index]['email'],
                                          'password': _listdata[index]['password'],
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
                                              _hapus(_listdata[index]['id_profile']).then((value) {
                                                if (value) {
                                                  setState(() {
                                                    _listdata.removeAt(index);
                                                  });
                                                  _getData();
                                                }
                                                Navigator.of(context).pop();
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => tambahprofile()));
        },
        child: Icon(Icons.add, color: Colors.white),
        elevation: 4,
      ),
    );
  }
}
