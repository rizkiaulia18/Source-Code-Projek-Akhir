import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Akun',
                style: TextStyle(
                    fontSize: 25, color: Color.fromARGB(255, 150, 126, 118)))),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
    );
  }
}
