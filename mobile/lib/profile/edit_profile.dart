import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class editprofile extends StatefulWidget {
  final Map ListData;
  const editprofile({super.key, required this.ListData});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_profile = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<bool> _ubah() async {
    final respon = await http.post(
      Uri.parse('http://192.168.1.6/api/editprofile.php'),
      body: {
        'id_profile': id_profile.text,  // Pass the ID of the product to update
        'nama': nama.text,
        'email': email.text,
        'password': password.text,
      },
    );

    if (respon.statusCode == 200) {
      final responseJson = jsonDecode(respon.body);
      return responseJson['pesan'] == 'sukses';  // Check for 'sukses' instead of 'sukses update'
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    id_profile.text = widget.ListData['id_profile'];
    nama.text = widget.ListData['nama'];
    email.text = widget.ListData['email'];
    password.text = widget.ListData['password'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Produk'),
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
                  hintText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama produk tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: 'email ',
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
                    _ubah().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value ? 'Data berhasil diupdate' : 'Data gagal diupdate'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (value) {
                        Navigator.pop(context, true); // Return true if update is successful
                      }
                    });
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
