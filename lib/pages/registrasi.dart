import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simasjid/pages/button.dart';
import 'package:simasjid/pages/home.dart';
import 'package:simasjid/model/setting.dart';
import 'package:simasjid/pages/v_login.dart';
import 'package:simasjid/service/UsersService.dart';
import 'package:simasjid/service/auth.dart';
import 'package:simasjid/service/url.dart';
import '../service/SettingService.dart';

class RegistrasiView extends StatefulWidget {
  const RegistrasiView({Key? key}) : super(key: key);

  @override
  State<RegistrasiView> createState() => _RegistrasiViewState();
}

class _RegistrasiViewState extends State<RegistrasiView> {
  Auth auth = Auth();
  bool _isLoading = false;

  late String _logoUrl = '';
  late TextEditingController _namaUserController;
  late TextEditingController _emailUserController;
  late TextEditingController _passwordController;
  final UsersService _usersService = UsersService();

  @override
  void initState() {
    super.initState();
    _namaUserController = TextEditingController();
    _emailUserController = TextEditingController();
    _passwordController = TextEditingController();
    _fetchSettingData();
  }

  Future<void> _uploadUser() async {
    final nama = _namaUserController.text;
    final email = _emailUserController.text.trim();
    final password = _passwordController.text;

    try {
      if (nama.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Loading'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text('Mengupload data registrasi...'),
                ],
              ),
            );
          },
        );

        await auth.registerWithEmailPassword(email, password);
        await _usersService.uploadUserData(nama, email);

        // await _userRepo.uploadUser(nama, email);

        // Setelah email diverifikasi, user sudah seharusnya ada di dalam instance FirebaseAuth
        User? user = FirebaseAuth.instance.currentUser;

        Navigator.pop(context); // Tutup dialog loading

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Berhasil',
                textAlign: TextAlign.center,
              ),
              content: Text('Registrasi berhasil. ' +
                  (user != null && !user.emailVerified
                      ? 'Silakan cek email Anda untuk verifikasi.'
                      : 'Akan dikonfirmasi oleh Admin')),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: buttonPrimary,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ).then((_) {
          // Setelah dialog berhasil ditutup, reset form
          _namaUserController.clear();
          _emailUserController.clear();
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Peringatan'),
              content: const Text('Harap isi semua kolom'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(
            content: Text("email sudah terdaftar!",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.grey,
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pendaftaran Gagal!",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.grey,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchSettingData() async {
    try {
      final SettingService settingService = SettingService();
      final List<Setting> settings = await settingService.fetchSettings();
      if (settings.isNotEmpty) {
        setState(() {
          _logoUrl = "${BaseUrl.baseUrlImg}${settings[0].logo}";
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrasi Akun',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 280,
                    child: _logoUrl.isNotEmpty
                        ? Image.network(_logoUrl)
                        : Image.asset("assets/logo/masjid.png"),
                  ),
                ),
                SizedBox(height: 10),
                const Text(
                  "Registrasi",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _namaUserController,
                  decoration: InputDecoration(
                    labelText: "Nama",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailUserController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginView()));
                      },
                      child: Text(
                        "Sudah punya akun ? Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _isLoading ? null : _uploadUser();
                          },
                          child: Text(
                            "Daftar",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: buttonPrimary,
                        ),
                        Center(
                          child: Text(
                            "Atau",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await auth.signInWithGoogle(context);
                            if (mounted) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage()));
                            }
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/logo/google_logo.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          style: buttonPrimary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
