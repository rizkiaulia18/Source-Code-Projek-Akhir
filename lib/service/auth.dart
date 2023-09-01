import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/pages/home.dart';
import 'package:simasjid/service/UsersService.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final UsersService _usersService =
      UsersService(); // Create an instance of UsersService
  // final storage = new FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> registerWithEmailPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Kirim email verifikasi
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      print('Kesalahan registrasi: $e');
      throw e;
    }
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String displayName = userCredential.user!.displayName ?? '';
      String userEmail = userCredential.user!.email ?? '';
      String? photoUrl = userCredential.user!.photoURL;

      // Mengambil data nama dari UsersService
      String? nama = await _usersService.getUserName(userEmail);

      storeUserData(displayName, userEmail, photoUrl,
          nama); // Menambahkan data nama ke storeUserData

      return userCredential;
    } catch (e) {
      print('Kesalahan login dengan email dan password: $e');
      throw e;
    }
  }

  // Future<void> storeTokenAndData(UserCredential userCredential,
  //     [String? token]) async {
  //   String value = token ?? userCredential.credential!.token.toString();
  //   await storage.write(key: "token", value: value);
  //   await storage.write(
  //       key: "userCredential", value: userCredential.toString());
  // }

  // Future<String?> getToken() async {
  //   return await storage.read(key: "token");
  // }

  Future<void> storeUserData(
    String displayName,
    String email,
    String? photoUrl,
    String? nama,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('displayName', displayName);
    prefs.setString('email', email);
    if (photoUrl != null) {
      prefs.setString('photoUrl', photoUrl);
    }

    if (nama != null) {
      prefs.setString('nama', nama);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Simpan data pengguna dalam shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('displayName', userCredential.user!.displayName!);
        prefs.setString('email', userCredential.user!.email!);
        prefs.setString('photoUrl', userCredential.user!.photoURL!);
        prefs.setString('googleToken', googleAuth.idToken ?? '');

        // Pindahkan ke halaman utama setelah login
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return HomePage();
        }));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login Berhasil!",
              style: TextStyle(color: Colors.black),
            ),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ),
        );
      } else {
        print("Login dengan Google dibatalkan");
      }
    } catch (e) {
      if (e is PlatformException && e.code == 'sign_in_canceled') {
        print("Login dengan Google dibatalkan");
        Navigator.pop(context);
      } else {
        print('Kesalahan login dengan Google: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Terjadi kesalahan saat login dengan Google"),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
