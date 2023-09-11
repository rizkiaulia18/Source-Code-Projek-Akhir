import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simasjid/pages/button.dart';
import 'package:simasjid/pages/home.dart';
import 'package:simasjid/model/setting.dart';
import 'package:simasjid/pages/registrasi.dart';
import 'package:simasjid/service/UsersService.dart';
import 'package:simasjid/service/auth.dart';
import 'package:simasjid/service/url.dart';

import '../service/SettingService.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late String _logoUrl = '';
  late Auth _auth = Auth();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late UsersService _usersService; // Inisialisasi di sini

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _usersService = UsersService(); // Inisialisasi di sini
    _fetchSettingData();
  }

  get auth => null;

  Future<void> _handleSignInWithEmail(BuildContext context) async {
    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    Auth auth = Auth();
    try {
      UserCredential userCredential =
          await auth.signInWithEmailPassword(email, password);

      if (userCredential.user!.emailVerified) {
        String displayName = userCredential.user!.displayName ?? '';
        String userEmail = userCredential.user!.email ?? '';
        String? photoUrl = userCredential.user!.photoURL;

        // Mengambil data nama dari UsersService
        String? nama = await _usersService.getUserName(userEmail);

        // Menyimpan data ke shared preferences
        auth.storeUserData(
          displayName,
          userEmail,
          photoUrl,
          nama,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Login Berhasil!", style: TextStyle(color: Colors.black)),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.white,
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Gagal', textAlign: TextAlign.center),
              content: const Text(
                'Harap Verifikasi email terlebih dahulu!',
                textAlign: TextAlign.center,
              ),
              actions: [
                ElevatedButton(
                  style: buttonPrimary,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                      child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Kesalahan login dengan email dan password: $e');
      if (e is FirebaseAuthException) {
        String errorMessage = '';
        if (e.code == 'user-not-found') {
          errorMessage = "Email tidak terdaftar!";
        } else if (e.code == 'wrong-password') {
          errorMessage = "Password salah!";
        } else if (e.code == 'invalid-email') {
          errorMessage = "Format email tidak sesuai!";
        } else {
          errorMessage = "Login Gagal, Coba lagi!";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage, style: TextStyle(color: Colors.black)),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.grey,
          ),
        );
      }
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
                    labelText: "Email",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegistrasiView()));
                      },
                      child: Text(
                        "Belum Punya Akun? Registrasi",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => HomePage()));
                      },
                      child: Text(
                        "Lewati",
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
                            _handleSignInWithEmail(context);
                          },
                          child: Text(
                            "Login",
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
                            await _auth.signInWithGoogle(context);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/logo/google_logo.png', // Ganti dengan path logo Google Anda
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



// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:simasjid/pages/button.dart';
// import 'package:simasjid/pages/home.dart';
// import 'package:simasjid/model/setting.dart';
// import 'package:simasjid/pages/registrasi.dart';
// import 'package:simasjid/service/UsersService.dart';
// import 'package:simasjid/service/auth.dart';
// import 'package:simasjid/service/url.dart';

// import '../service/SettingService.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({Key? key}) : super(key: key);

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   late String _logoUrl = '';
//   late Auth _auth = Auth();
//   late TextEditingController _usernameController;
//   late TextEditingController _passwordController;
//   late UsersService _usersService; // Inisialisasi di sini

//   @override
//   void initState() {
//     super.initState();
//     _usernameController = TextEditingController();
//     _passwordController = TextEditingController();
//     _usersService = UsersService(); // Inisialisasi di sini
//     _fetchSettingData();
//   }

//   get auth => null;

//   // Tambahkan field untuk input email lupa password
//   final TextEditingController _emailController = TextEditingController();

//   Future<void> _handleSignInWithEmail(BuildContext context) async {
//     String email = _usernameController.text.trim();
//     String password = _passwordController.text.trim();

//     Auth auth = Auth();
//     try {
//       UserCredential userCredential =
//           await auth.signInWithEmailPassword(email, password);

//       if (userCredential.user!.emailVerified) {
//         String displayName = userCredential.user!.displayName ?? '';
//         String userEmail = userCredential.user!.email ?? '';
//         String? photoUrl = userCredential.user!.photoURL;

//         // Mengambil data nama dari UsersService
//         String? nama = await _usersService.getUserName(userEmail);

//         // Menyimpan data ke shared preferences
//         auth.storeUserData(
//           displayName,
//           userEmail,
//           photoUrl,
//           nama,
//         );

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => HomePage(),
//           ),
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content:
//                 Text("Login Berhasil!", style: TextStyle(color: Colors.black)),
//             duration: const Duration(seconds: 1),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.white,
//           ),
//         );
//         // Panggil _showLupaPasswordDialog() ketika tombol "Lupa Password" ditekan
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Gagal', textAlign: TextAlign.center),
//               content: const Text(
//                 'Harap Verifikasi email terlebih dahulu!',
//                 textAlign: TextAlign.center,
//               ),
//               actions: [
//                 ElevatedButton(
//                   style: buttonPrimary,
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Center(
//                       child: Text(
//                     'OK',
//                     style: TextStyle(color: Colors.white),
//                   )),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       print('Kesalahan login dengan email dan password: $e');
//       if (e is FirebaseAuthException) {
//         String errorMessage = '';
//         if (e.code == 'user-not-found') {
//           errorMessage = "Email tidak terdaftar!";
//         } else if (e.code == 'wrong-password') {
//           errorMessage = "Password salah!";
//         } else if (e.code == 'invalid-email') {
//           errorMessage = "Format email tidak sesuai!";
//         } else {
//           errorMessage = "Login Gagal, Coba lagi!";
//         }

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage, style: TextStyle(color: Colors.black)),
//             duration: const Duration(seconds: 2),
//             behavior: SnackBarBehavior.floating,
//             backgroundColor: Colors.grey,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _fetchSettingData() async {
//     try {
//       final SettingService settingService = SettingService();
//       final List<Setting> settings = await settingService.fetchSettings();
//       if (settings.isNotEmpty) {
//         setState(() {
//           _logoUrl = "${BaseUrl.baseUrlImg}${settings[0].logo}";
//         });
//       }
//     } catch (e) {
//       // Handle error
//     }
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // Tambahkan fungsi _showLupaPasswordDialog untuk menampilkan dialog "Lupa Password"
//   void _showLupaPasswordDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Lupa Password?"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller:
//                     _emailController, // Gunakan controller untuk input email
//                 decoration: InputDecoration(
//                   labelText: "Alamat Email",
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Tutup dialog
//                 _handleLupaPassword(_emailController
//                     .text); // Panggil fungsi untuk mengirim email reset password
//               },
//               child: Text("Kirim"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Tutup dialog jika dibatalkan
//               },
//               child: Text("Batal"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Tambahkan fungsi _handleLupaPassword untuk mengirim email reset password
//   Future<void> _handleLupaPassword(String email) async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Reset Password Berhasil"),
//             content:
//                 Text("Silakan cek email Anda untuk instruksi selanjutnya."),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       print("Gagal mengirim reset password: $e");
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Gagal Reset Password"),
//             content: Text("Terjadi kesalahan saat mengirim reset password."),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child: Text('SIMASJID',
//                 style: TextStyle(
//                     fontSize: 25, color: Color.fromARGB(255, 150, 126, 118)))),
//         backgroundColor: Color.fromARGB(255, 238, 227, 203),
//       ),
//       body: Container(
//         margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//         child: ListView(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),

//                 Center(
//                   child: Container(
//                     width: 280,
//                     child: _logoUrl.isNotEmpty
//                         ? Image.network(_logoUrl)
//                         : Image.asset("assets/logo/masjid.png"),
//                   ),
//                 ),
//                 SizedBox(height: 10),

//                 const Text(
//                   "Silahkan Login !!!",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 // Tambahkan field Username
//                 TextField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 // Tambahkan field Password
//                 TextField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(
//                     labelText: "Password",
//                   ),
//                   obscureText: true, // Agar karakter password tersembunyi
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => RegistrasiView()));
//                       },
//                       child: Text(
//                         "Belum Punya Akun? Registrasi",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(context,
//                             MaterialPageRoute(builder: (_) => HomePage()));
//                       },
//                       child: Text(
//                         "Lewati",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             _handleSignInWithEmail(context);
//                           },
//                           child: Text(
//                             "Login",
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                           style: buttonPrimary,
//                         ),
//                         Center(
//                           child: Text(
//                             "Atau",
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             await _auth.signInWithGoogle(context);
//                           },
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     'assets/logo/google_logo.png', // Ganti dengan path logo Google Anda
//                                     width: 24,
//                                     height: 24,
//                                   ),
//                                   SizedBox(width: 8),
//                                   Text(
//                                     "Google",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 16),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           style: buttonPrimary,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _showLupaPasswordDialog();
//                   },
//                   child: Text(
//                     "Lupa Password?",
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 14,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
