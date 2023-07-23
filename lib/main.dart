import 'package:flutter/material.dart';
// import 'package:simasjid/pages/home.dart';
import 'package:simasjid/pages/splash.dart';
import 'package:simasjid/pages/v_login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
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
