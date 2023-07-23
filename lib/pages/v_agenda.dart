import 'package:flutter/material.dart';
import 'package:simasjid/model/agenda.dart';
import 'package:simasjid/pages/ListAgenda.dart';
import 'package:simasjid/service/AgendaService.dart';
import 'package:table_calendar/table_calendar.dart';

class AgendaView extends StatefulWidget {
  const AgendaView({Key? key}) : super(key: key);

  @override
  State<AgendaView> createState() => _AgendaViewState();
}

class _AgendaViewState extends State<AgendaView> {
  List<Agenda> listAgenda = [];
  AgendaService agendaService = AgendaService();
  DateTime _selectedDay = DateTime.now();

  getData() async {
    listAgenda = await agendaService.getAgenda();
    setState(() {});
  }

  void initState() {
    getData();
    super.initState();
  }

  List<Agenda> filterAgendaByDate(DateTime selectedDate) {
    return listAgenda.where((agenda) {
      DateTime agendaDate = DateTime.parse(agenda.tglKegiatan);
      return agendaDate.year == selectedDate.year &&
          agendaDate.month == selectedDate.month &&
          agendaDate.day == selectedDate.day;
    }).toList();
  }

  void navigateToListAgenda() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListAgenda(selectedDay: _selectedDay)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          navigateToListAgenda();
        },
        eventLoader: (date) {
          List<Agenda> agendaList = filterAgendaByDate(date);
          return agendaList.isNotEmpty ? [date] : [];
        },
      ),
    );
  }
}
