import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProduk extends StatefulWidget {
  final Map ListData;
  const EditProduk({super.key, required this.ListData});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_produk = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController ukuran = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController jenisBaju = TextEditingController();

  Future<bool> _ubah() async {
    final respon = await http.post(
      Uri.parse('http://192.168.1.6/api/edit.php'),
      body: {
        'id_produk': id_produk.text,  // Pass the ID of the product to update
        'nama': nama.text,
        'ukuran': ukuran.text,
        'harga': harga.text,
        'jenis_baju': jenisBaju.text,
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
    id_produk.text = widget.ListData['id_produk'];
    nama.text = widget.ListData['nama'];
    ukuran.text = widget.ListData['ukuran'];
    harga.text = widget.ListData['harga'];
    jenisBaju.text = widget.ListData['jenis_baju'];
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
                  hintText: 'Nama Produk',
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
                controller: ukuran,
                decoration: InputDecoration(
                  hintText: 'Ukuran Produk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ukuran produk tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: harga,
                decoration: InputDecoration(
                  hintText: 'Harga Produk',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harga produk tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jenisBaju,
                decoration: InputDecoration(
                  hintText: 'Jenis Baju',
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
