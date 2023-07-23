import 'package:flutter/material.dart';
import '../model/jadwal_shalat.dart';
import '../service/JadwalShalatService.dart';

class JadwalShalatView extends StatefulWidget {
  const JadwalShalatView({Key? key}) : super(key: key);

  @override
  _JadwalShalatViewState createState() => _JadwalShalatViewState();
}

class _JadwalShalatViewState extends State<JadwalShalatView> {
  late JadwalShalat jadwalShalat;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    JadwalShalatService jadwalService = JadwalShalatService();
    DateTime today = DateTime.now();
    try {
      jadwalShalat = await jadwalService.getJadwalShalat('0119', today);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handling error, misalnya menampilkan pesan kesalahan jika API tidak berhasil diambil.
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Shalat'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lokasi: ${jadwalShalat.lokasi}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tanggal: ${jadwalShalat.jadwal.tanggal}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Imsak: ${jadwalShalat.jadwal.imsak}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Subuh: ${jadwalShalat.jadwal.subuh}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Terbit: ${jadwalShalat.jadwal.terbit}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Dhuha: ${jadwalShalat.jadwal.dhuha}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Dzuhur: ${jadwalShalat.jadwal.dzuhur}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Ashar: ${jadwalShalat.jadwal.ashar}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Maghrib: ${jadwalShalat.jadwal.maghrib}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Isya: ${jadwalShalat.jadwal.isya}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
