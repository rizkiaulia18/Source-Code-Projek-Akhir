import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simasjid/model/agenda.dart';
import 'package:simasjid/service/AgendaService.dart';

import '../details/detail_agenda.dart';

class ListAgenda extends StatefulWidget {
  final DateTime selectedDay;

  const ListAgenda({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _ListAgendaState createState() => _ListAgendaState();
}

class _ListAgendaState extends State<ListAgenda> {
  List<Agenda> listAgenda = [];
  AgendaService agendaService = AgendaService();
  bool isLoading = true; // Tambahkan variabel isLoading

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    List<Agenda> data = await agendaService.getAgenda();

    // Menghentikan loading
    setState(() {
      listAgenda = data;
      isLoading = false;
    });
  }

  void navigateToDetailAgenda(Agenda agenda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailAgenda(agenda: agenda)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Agenda> filteredAgenda = listAgenda.where((agenda) {
      DateTime agendaDate = DateTime.parse(agenda.tglKegiatan);
      return agendaDate.year == widget.selectedDay.year &&
          agendaDate.month == widget.selectedDay.month &&
          agendaDate.day == widget.selectedDay.day;
    }).toList();

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
      body: isLoading // Periksa isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Tampilkan CircularProgressIndicator
            )
          : filteredAgenda.isNotEmpty
              ? ListView.separated(
                  itemCount: filteredAgenda.length,
                  itemBuilder: (context, index) {
                    Agenda agenda = filteredAgenda[index];
                    DateTime tglKegiatan = DateTime.parse(agenda.tglKegiatan);
                    String formattedDate =
                        DateFormat('dd MMM yyyy').format(tglKegiatan);
                    // String formattedTime =
                    //     DateFormat('HH:mm').format(DateTime.parse(agenda.wktKegiatan));
                    return ListTile(
                      title: Text(agenda.namaKegiatan),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formattedDate),
                          Text(agenda.wktKegiatan),
                        ],
                      ),
                      onTap: () {
                        navigateToDetailAgenda(agenda);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                )
              : Center(
                  child: Text('Tidak ada data agenda pada tanggal ini.'),
                ),
    );
  }
}
