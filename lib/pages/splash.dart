import 'package:flutter/material.dart';
import 'package:simasjid/model/setting.dart';
import 'package:simasjid/service/url.dart';

import '../service/SettingService.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Setting>>(
      future: _fetchSettingData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan loading indicator jika data sedang diambil
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color.fromARGB(255, 238, 227, 203),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Menampilkan pesan error jika terjadi kesalahan saat mengambil data
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color.fromARGB(255, 238, 227, 203),
              body: Center(
                child: Text("Failed to load data"),
              ),
            ),
          );
        } else {
          // Menampilkan logo dan nama masjid jika data berhasil diambil
          final List<Setting> settings = snapshot.data ?? [];
          String logoUrl = settings.isNotEmpty
              ? "${BaseUrl.baseUrlImg}${settings[0].logo}"
              : "assets/logo/simasjid.png";
          String namaMasjid =
              settings.isNotEmpty ? settings[0].namaMasjid : "Nama Masjid";
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Color.fromARGB(255, 238, 227, 203),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      child: Image.network(logoUrl),
                    ),
                    SizedBox(height: 20),
                    Text(
                      namaMasjid,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<List<Setting>> _fetchSettingData() async {
    try {
      final SettingService settingService = SettingService();
      final List<Setting> settings = await settingService.fetchSettings();
      return settings;
    } catch (e) {
      // Handle error
      return [];
    }
  }
}
