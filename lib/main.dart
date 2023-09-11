import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/firebase_options.dart';
import 'package:simasjid/pages/home.dart';
import 'package:simasjid/pages/splash.dart';
import 'package:simasjid/pages/v_login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Mengecek apakah pengguna sudah login (email tersimpan di SharedPreferences)
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String email = prefs.getString('email') ??
      ''; // Mendapatkan email dari SharedPreferences

  runApp(
      MyApp(isLoggedIn: email.isNotEmpty)); // Mengirimkan status login ke MyApp
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn; // Tambahkan properti isLoggedIn

  MyApp({Key? key, this.isLoggedIn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          // Berdasarkan status isLoggedIn, arahkan pengguna ke halaman yang sesuai
          if (isLoggedIn) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Simasjid',
              theme: ThemeData(
                primarySwatch: Colors.grey,
              ),
              home:
                  HomePage(), // Arahkan ke halaman beranda jika isLoggedIn true
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Simasjid',
              theme: ThemeData(
                primarySwatch: Colors.grey,
              ),
              home:
                  LoginView(), // Arahkan ke halaman login jika isLoggedIn false
            );
          }
        }
      },
    );
  }
}
