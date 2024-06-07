import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class editalamat extends StatefulWidget {
  final Map ListData;
  const editalamat({super.key, required this.ListData});

  @override
  State<editalamat> createState() => _editalamatState();
}

class _editalamatState extends State<editalamat> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_alamat=TextEditingController();
   TextEditingController nama_lengkap =TextEditingController();
   TextEditingController nomortelp =TextEditingController();
   TextEditingController kota =TextEditingController();
   TextEditingController namajalan=TextEditingController();

 Future  _ubah() async {
  final respon = await 
  http.post(Uri.parse('http://10.128.35.134/api/editalamat.php'),
    body: {
      'id_alamat': id_alamat.text, // Pass the ID of the product to update
      'nama': nama_lengkap.text,
      'nomortelp': nomortelp.text,
      'kota': kota.text,
      'namajalan': namajalan.text,
    },
  );
  if (respon.statusCode == 200) {
    final responseJson = jsonDecode(respon.body);
    return responseJson['pesan'] == 'sukses'; // Check for 'sukses' instead of 'sukses update'
  }
  return false;
}

  @override
  Widget build(BuildContext context) {
    id_alamat.text = widget.ListData['id_alamat'];
     nama_lengkap.text = widget.ListData['nama_lengkap'];
      nomortelp.text = widget.ListData['nomortelp'];
       kota.text = widget.ListData['kota'];
       namajalan.text = widget.ListData['namajalan'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit alamat'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_lengkap,
                decoration: InputDecoration(
                  hintText: 'Nama lengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama lengkap tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nomortelp,
                decoration: InputDecoration(
                  hintText: ' nomor telp',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "nomor telp tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: kota,
                decoration: InputDecoration(
                  hintText: 'kota',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "kota tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: namajalan,
                decoration: InputDecoration(
                  hintText: 'nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Jenis baju tidak boleh kosong!";
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
