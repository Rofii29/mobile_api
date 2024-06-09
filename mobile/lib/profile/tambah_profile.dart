import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/profile/profile.dart';

class tambahprofile extends StatefulWidget {
  const tambahprofile({super.key});

  @override
  State<tambahprofile> createState() => _tambahprofileState();
}

class _tambahprofileState extends State<tambahprofile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password= TextEditingController();

  Future _simpan() async {
    final respon = await http.post(
      Uri.parse('http://192.168.11.125/api/createprofile.php'),
      body: {
        'nama': nama.text,
        'email': email.text,
        'password': password.text,
      },
    );
    if (respon.statusCode == 200) {
      final result = jsonDecode(respon.body);
      print(result);
      return result['pesan'] == 'sukses';
    }
    print('Error: ${respon.statusCode}');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Profile'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: 'Nama ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama  tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: ' Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "email tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: password,
                decoration: InputDecoration(
                  hintText: 'password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "password tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value ? 'Data berhasil disimpan' : 'Data gagal disimpan'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
