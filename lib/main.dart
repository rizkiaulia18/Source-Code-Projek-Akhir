import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simasjid/firebase_options.dart';
// import 'package:simasjid/pages/home.dart';
import 'package:simasjid/pages/splash.dart';
import 'package:simasjid/pages/v_login.dart';

// void main() {
//   runApp(MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Simasjid',
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            home: LoginView(),
          );
        }
      },
    );
    // return MaterialApp(
    //   title: 'Simasjid',
    //   theme: ThemeData(
    //     primarySwatch: Colors.amber,
    //   ),
    //   home: SplashScreen(),
    // );
  }
}
