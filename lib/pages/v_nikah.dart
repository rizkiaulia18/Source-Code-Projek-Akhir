import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/model/nikah.dart';
import 'package:simasjid/pages/AddNikah.dart';
import 'package:simasjid/pages/ListNikah.dart';
import 'package:simasjid/service/NikahService.dart';
import 'package:table_calendar/table_calendar.dart';

import 'button.dart';

class NikahView extends StatefulWidget {
  const NikahView({Key? key}) : super(key: key);

  @override
  State<NikahView> createState() => _NikahViewState();
}

class _NikahViewState extends State<NikahView> {
  List<Nikah> listNikah = [];
  NikahService nikahservice = NikahService();
  DateTime _selectedDay = DateTime.now();
  String email = "";

  getData() async {
    listNikah = await nikahservice.getData();
    setState(() {});
  }
  // getData() async {
  //   listNikah = await nikahservice.getData(); // Mengambil semua data
  //   // Filter data hanya dengan status "aktif"
  //   listNikah = listNikah.where((nikah) => nikah.status == 'aktif').toList();
  //   setState(() {});
  // }

  Future<void> loadUserGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? '';
    });
  }

  void initState() {
    getData();
    super.initState();
    loadUserGoogle();
  }

  List<Nikah> filterNikahByDate(DateTime selectedDate) {
    return listNikah.where((nikah) {
      DateTime nikahDate = DateTime.parse(nikah.tgl_nikah);
      return nikahDate.year == selectedDate.year &&
          nikahDate.month == selectedDate.month &&
          nikahDate.day == selectedDate.day;
    }).toList();
  }

  void navigateToListNikah() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListNikah(selectedDay: _selectedDay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nikah',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true, // Tambahkan ini untuk mengatur judul di tengah
        backgroundColor: Color.fromARGB(255, 238, 227, 203),

        // actions: [
        //   ElevatedButton(
        //     onPressed: () {
        //       // Arahkan ke halaman AddNikah
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => AddNikah()),
        //       );
        //     },
        //     child: Text(
        //       'Boking',
        //       style: TextStyle(color: Colors.white, fontSize: 16),
        //     ),
        //     style: buttonPrimary,
        //   ),
        // ],
      ),
      body: ListView(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              titleCentered: true,
            ),
            calendarFormat: CalendarFormat.month,
            focusedDay: _selectedDay,
            firstDay: DateTime.utc(2023),
            lastDay: DateTime.utc(2040),
            availableCalendarFormats: {
              CalendarFormat.month: 'Bulan',
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
              navigateToListNikah();
            },
            eventLoader: (date) {
              List<Nikah> nikahList = filterNikahByDate(date);

              return nikahList.isNotEmpty ? [date] : [];
            },
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Arahkan ke halaman AddNikah
                if (email.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNikah()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Belum Login'),
                        content: Text(
                            'Maaf Anda belum login, Silahkan login untuk mendaftar nikah'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog
                              // Navigator.pop(context); // Kembali ke halaman sebelumnya
                            },
                            child: Text(
                              'OK',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            style: buttonPrimary,
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'Daftar Nikah',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: buttonPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
