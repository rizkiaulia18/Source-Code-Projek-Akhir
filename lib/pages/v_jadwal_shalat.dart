import 'package:flutter/material.dart';
import '../model/jadwal_shalat.dart';
import '../service/JadwalShalatService.dart';

class JadwalShalatView extends StatefulWidget {
  const JadwalShalatView({Key? key}) : super(key: key);

  @override
  _JadwalShalatViewState createState() => _JadwalShalatViewState();
}

class _JadwalShalatViewState extends State<JadwalShalatView> {
  late JadwalShalat? jadwalShalat;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    JadwalShalatService jadwalService = JadwalShalatService();
    try {
      jadwalShalat = await jadwalService.fetchJadwalShalat();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
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
        title: Text(
          'Jadwal Shalat',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${jadwalShalat?.jadwal.tanggal ?? ''}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 5),
                buildListTile('Imsak', jadwalShalat?.jadwal.imsak ?? ''),
                buildListTile('Subuh', jadwalShalat?.jadwal.subuh ?? ''),
                buildListTile('Terbit', jadwalShalat?.jadwal.terbit ?? ''),
                buildListTile('Dhuha', jadwalShalat?.jadwal.dhuha ?? ''),
                buildListTile('Dzuhur', jadwalShalat?.jadwal.dzuhur ?? ''),
                buildListTile('Ashar', jadwalShalat?.jadwal.ashar ?? ''),
                buildListTile('Maghrib', jadwalShalat?.jadwal.maghrib ?? ''),
                buildListTile('Isya', jadwalShalat?.jadwal.isya ?? ''),
              ],
            ),
    );
  }

  Widget buildListTile(String title, String value) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Divider(thickness: 5),
      ],
    );
  }
}
