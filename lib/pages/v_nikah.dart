import 'package:flutter/material.dart';
import 'package:simasjid/model/nikah.dart';
import 'package:simasjid/pages/AddNikah.dart';
import 'package:simasjid/pages/ListNikah.dart';
import 'package:simasjid/service/NikahService.dart';
import 'package:table_calendar/table_calendar.dart';

class NikahView extends StatefulWidget {
  const NikahView({Key? key}) : super(key: key);

  @override
  State<NikahView> createState() => _NikahViewState();
}

class _NikahViewState extends State<NikahView> {
  List<Nikah> listNikah = [];
  NikahService nikahservice = NikahService();
  DateTime _selectedDay = DateTime.now();

  getData() async {
    listNikah = await nikahservice.getData();
    setState(() {});
  }

  void initState() {
    getData();
    super.initState();
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
          builder: (context) => ListNikah(selectedDay: _selectedDay)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Nikah',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 150, 126, 118),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
        actions: [
          IconButton(
            onPressed: () {
              // Arahkan ke halaman AddNikah
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNikah()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: TableCalendar(
        headerStyle: HeaderStyle(
          titleCentered: true,
        ),
        calendarFormat: CalendarFormat.month,
        focusedDay: _selectedDay,
        firstDay: DateTime.utc(2023),
        lastDay: DateTime.utc(2040),
        availableCalendarFormats: {
          CalendarFormat.month: 'Bulan',
          // Hapus CalendarFormat.week di sini
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
    );
  }
}

        // calendarBuilders: CalendarBuilders(
        //   selectedBuilder: (context, date, events) {
        //     List<Nikah> nikahList = filterNikahByDate(date);
        //     bool hasNikah = nikahList.isNotEmpty;
        //     return Container(
        //       margin: const EdgeInsets.all(4),
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //         color: hasNikah ? Colors.red : Colors.blue,
        //         shape: BoxShape.circle,
        //       ),
        //       child: Text(
        //         '${date.day}',
        //         style: TextStyle(
        //           color: Colors.white,
        //         ),
        //       ),
        //     );
        //   },
        // ),

// listNikah.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.separated(
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   // leading: CircleAvatar(
//                   //   child: Text('${index + 1}'), // Menampilkan nomor item
//                   // ),
//                   title: Text(
//                     listNikah[index].nama_pengantin_p +
//                         " & " +
//                         listNikah[index].nama_pengantin_w,
//                   ),
//                   subtitle: Text(listNikah[index].tgl_nikah),
//                   trailing: Icon(Icons.arrow_forward_ios),
//                   onTap: () {},
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 return Divider();
//               },
//               itemCount: listNikah.length,
//             ),
