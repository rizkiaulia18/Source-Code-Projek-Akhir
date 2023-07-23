import 'package:flutter/material.dart';
import 'package:simasjid/pages/v_agenda.dart';
import 'package:simasjid/pages/v_jadwal_shalat.dart';
import 'package:simasjid/pages/v_kas.dart';
import 'package:simasjid/pages/v_nikah.dart';
import 'package:simasjid/pages/v_qurban.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Selamat Datang di Aplikasi SIMASJID",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "~Rizki Aulia~",
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
            child: Image.asset("assets/logo/simasjid.png"),
          ),
          Column(
            children: [
              SizedBox(height: 10),
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
                  // Column(
                  //   children: [
                  //     Container(
                  //       width: 70,
                  //       height: 70,
                  //       child: IconButton(
                  //         onPressed: () {
                  //           Navigator.push(context,
                  //               MaterialPageRoute(builder: (context) {
                  //             return JadwalShalatView();
                  //           }));
                  //         },
                  //         icon: Image.asset("assets/icons/icon_kas.png"),
                  //       ),
                  //     ),
                  //     Text(
                  //       "Jadwal Shalat",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 12,
                  //         color: Color.fromARGB(255, 150, 126, 118),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
