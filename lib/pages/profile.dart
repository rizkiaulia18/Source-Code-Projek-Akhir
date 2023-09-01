import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/pages/home.dart';
import 'package:simasjid/pages/v_login.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String displayName = ''; // State untuk menyimpan nama pengguna
  String email = ''; // State untuk menyimpan email pengguna
  String photoURL = ''; // State untuk menyimpan URL gambar profil
  String nama = ''; // State untuk menyimpan URL gambar profil

  Future<void> logout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('displayName');
    prefs.remove('photoUrl');
    prefs.remove('nama');
    prefs.remove('googleToken');
  }

  Future<void> loadUserGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName') ?? '';
      email = prefs.getString('email') ?? '';
      photoURL = prefs.getString('photoUrl') ?? '';
      nama = prefs.getString('nama') ?? '';
    });
    print(email);
  }

  @override
  void initState() {
    super.initState();
    loadUserGoogle();
    // _user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Akun',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  if (photoURL.isNotEmpty)
                    CircleAvatar(
                      backgroundImage: NetworkImage(photoURL),
                      radius: 50,
                    ),
                  if (photoURL.isEmpty)
                    CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey,
                      ),
                      radius: 50,
                    ),
                  SizedBox(height: 20),
                  Text(
                    displayName.isNotEmpty
                        ? displayName
                        : (nama.isNotEmpty ? nama : 'Tidak Diketahui'),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    email.isNotEmpty ? email : 'Tidak Diketahui',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  if (email.isNotEmpty)
                    ElevatedButton(
                      onPressed: () async {
                        await logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => HomePage()),
                          (route) => false,
                        );
                      },
                      child: Text('Logout'),
                    ),
                  if (email.isEmpty)
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => LoginView()),
                          (route) => false,
                        );
                      },
                      child: Text('Login'),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
