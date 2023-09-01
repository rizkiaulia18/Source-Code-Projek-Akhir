import 'package:flutter/material.dart';
import 'package:simasjid/pages/button.dart';
import 'package:simasjid/pages/home.dart';
import 'package:simasjid/model/setting.dart';
import 'package:simasjid/service/url.dart';

import '../service/SettingService.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String _logoUrl = '';

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _fetchSettingData();
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('SIMASJID',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 150, 126, 118)))),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    child: _logoUrl.isNotEmpty
                        ? Image.network(_logoUrl)
                        : Image.asset(
                            "assets/logo/masjid.png"), // Placeholder while loading the logo
                  ),
                ),
                const Text(
                  "Silahkan Login !!!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Tambahkan field Username
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                ),
                SizedBox(height: 10),
                // Tambahkan field Password
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true, // Agar karakter password tersembunyi
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Masukkan logika autentikasi di sini
                      // Misalnya, memeriksa apakah username dan password sesuai dengan yang valid
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      // Contoh autentikasi sederhana
                      if (username == "" && password == "") {
                        // Jika username dan password valid, pindah ke halaman HomePage
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      } else {
                        // Jika username atau password salah, tampilkan pesan error
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login Gagal"),
                              content: Text(
                                  "Username atau Password yang Anda masukkan salah."),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: buttonPrimary,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Login dengan Google",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: buttonPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
