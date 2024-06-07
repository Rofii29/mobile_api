import 'package:flutter/material.dart';
import 'package:mobile/tampilan/beranda.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Welcome to Fashion design',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTivGtkvouHRIV8bU-QUwolApbeeLGyjEwZfA&s', // Ganti dengan URL logo Anda
              height: 100,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Beranda()));
              },
              child: Text('Login'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.blue, backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // Aksi ketika tombol Signup ditekan
              },
              child: Text('Signup'),
            ),
            SizedBox(height: 20),
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/a/a5/Instagram_icon.png', // Ganti dengan URL ikon Instagram
                    height: 50,
                    width: 50,
                  ),
                  iconSize: 50,
                  onPressed: () {
                    // Aksi ketika ikon Instagram ditekan
                  },
                ),
                SizedBox(width: 30),
                IconButton(
                  icon: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSTLNyHEp8ERADDJDy5wXQLoV_Lj0YTmv6eA&s', // Ganti dengan URL ikon Google
                    height: 50,
                    width: 50,
                  ),
                  iconSize: 50,
                  onPressed: () {
                    // Aksi ketika ikon Google ditekan
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
