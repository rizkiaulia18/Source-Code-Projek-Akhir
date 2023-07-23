import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
        body: Center(
          child: Container(
            // width: 400,
            // height: 400,
            child: Image.asset("assets/logo/simasjid.png"),
          ),
        ),
      ),
    );
  }
}
