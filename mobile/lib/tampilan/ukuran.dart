import 'package:flutter/material.dart';

class UkuranBajuScreen extends StatefulWidget {
  @override
  _UkuranBajuScreenState createState() => _UkuranBajuScreenState();
}

class _UkuranBajuScreenState extends State<UkuranBajuScreen> {
  String? _selectedSize; // Variabel untuk menyimpan ukuran yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Ukuran Baju'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pilih Ukuran Baju Anda:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              hint: Text('Pilih ukuran'), // Teks placeholder
              value: _selectedSize,
              isExpanded: true,
              items: ['S', 'M', 'L', 'XL'].map((String size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSize = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedSize != null) {
                  Navigator.pop(context, _selectedSize); // Send selected size back
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Silakan pilih ukuran terlebih dahulu'),
                    ),
                  );
                }
              },
              child: Text('Pilih'),
            ),
          ],
        ),
      ),
    );
  }
}
