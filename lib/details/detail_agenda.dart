import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simasjid/model/agenda.dart';

class DetailAgenda extends StatelessWidget {
  final Agenda agenda;

  const DetailAgenda({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd MMMM yyyy').format(DateTime.parse(agenda.tglKegiatan));

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Agenda',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 150, 126, 118),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Kegiatan :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              agenda.namaKegiatan,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Pelaksana Kegiatan :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              agenda.plkKegiatan,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Tempat Kegiatan :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              agenda.tmpKegiatan,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Tanggal Kegiatan :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              formattedDate,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Waktu Kegiatan :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              agenda.wktKegiatan,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}



// // ignore_for_file: unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:simasjid/model/agenda.dart';

// class AgendaDetailPage extends StatelessWidget {
//   final Agenda agenda;

//   AgendaDetailPage({required this.agenda});

//   @override
//   Widget build(BuildContext context) {
//     final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
//     final DateFormat timeFormat = DateFormat('HH:mm');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Detail Agenda',
//           style: TextStyle(
//             fontSize: 20,
//             color: Color.fromARGB(255, 150, 126, 118),
//           ),
//         ),
//         backgroundColor: Color.fromARGB(255, 238, 227, 203),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               agenda.namaKegiatan,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             // Text(dateFormat.format(agenda.tglKegiatan as DateTime),
//             Text(
//               agenda.tglKegiatan,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             // Text(timeFormat.format(agenda.wktKegiatan as DateTime),
//             Text(
//               agenda.wktKegiatan,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Pelaksanaan Kegiatan:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               agenda.plkKegiatan,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text(
//               'Tempat Kegiatan:',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               agenda.tmpKegiatan,
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
