import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/pages/button.dart';
import 'package:simasjid/pages/v_agenda.dart';
import 'package:simasjid/pages/v_jadwal_shalat.dart';
import 'package:simasjid/pages/v_kas.dart';
import 'package:simasjid/pages/v_komentar.dart';
import 'package:simasjid/pages/v_nikah.dart';
import 'package:simasjid/pages/v_qurban.dart';
import '../model/setting.dart';
import '../service/SettingService.dart';
import '../service/url.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String email = '';
  final SettingService settingService = SettingService();

  Future<void> loadEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'SIMASJID',
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 150, 126, 118),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: FutureBuilder<List<Setting>>(
        future: settingService.fetchSettings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            String namaMasjid = snapshot.data?.isEmpty == false
                ? snapshot.data![0].namaMasjid
                : "Nama Masjid";
            String? logoUrl =
                snapshot.data?.isEmpty == false ? snapshot.data![0].logo : null;

            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selamat Datang di Aplikasi SIMASJID",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        namaMasjid,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 300,
                  child: logoUrl != null
                      ? Image.network("${BaseUrl.baseUrlImg}$logoUrl")
                      : Image.asset("assets/logo/default_logo.png"),
                ),
                SizedBox(height: 10),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AgendaView();
                              }));
                            },
                            icon: Image.asset("assets/icons/ijadwal.png"),
                          ),
                        ),
                        Text(
                          "Agenda",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 126, 118),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NikahView();
                              }));
                            },
                            icon: Image.asset("assets/icons/icon_nikah.png"),
                          ),
                        ),
                        Text(
                          "Nikah",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 126, 118),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return QurbanView();
                              }));
                            },
                            icon: Image.asset("assets/icons/icon_goat.png"),
                          ),
                        ),
                        Text(
                          "Qurban",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 126, 118),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return KasView();
                              }));
                            },
                            icon: Image.asset("assets/icons/icon_kas.png"),
                          ),
                        ),
                        Text(
                          "Kas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 126, 118),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            onPressed: () {
                              if (email.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return KomentarView();
                                  }),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Belum Login'),
                                      content: Text(
                                          'Maaf Anda belum login, Anda harus login untuk melihat dan mengirim komentar.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          style: buttonPrimary,
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            icon: Image.asset("assets/icons/icon_comment.png"),
                          ),
                        ),
                        Text(
                          "Komentar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 126, 118),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return JadwalShalatView();
                              }));
                            },
                            icon: Image.asset("assets/icons/ijadwal.png"),
                          ),
                        ),
                        Text(
                          "Jadwal Shalat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 150, 126, 118),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
