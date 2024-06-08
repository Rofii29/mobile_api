
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/alamat/halaman_alamat.dart';


class tambahalamat extends StatefulWidget {
  const tambahalamat({super.key});


  @override
  State<tambahalamat> createState() => _tambahalamatState();
}


class _tambahalamatState extends State<tambahalamat> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama_lengkap = TextEditingController();
  TextEditingController nomortelp = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController namajalan = TextEditingController();



  Future _simpan() async {
    final respon = await http
        .post(Uri.parse('http://192.168.1.6/api/createalamat.php'), body: {
      'nama_lengkap': nama_lengkap.text,
      'nomortelp': nomortelp.text,
      'kota': kota.text,
      'namajalan': namajalan.text,
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah alamat'),
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
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama lengkap tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nomortelp,
                  decoration: InputDecoration(
                      hintText: 'nomor telefon ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Harga produk tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: kota,
                  decoration: InputDecoration(
                      hintText: 'kota ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "kota tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: namajalan,
                  decoration: InputDecoration(
                      hintText: 'nama jalan ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "nama jalan tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _simpan().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data berhasil disimpan'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data gagal disimpan'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => halamanalamat())),
                            (route) => false);
                      }
                    },
                    child: Text('Simpan'))
              ],
            ),
          )),
    );
  }
}

