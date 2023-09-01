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
        title: Text(
          'Detail Agenda',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Nama Kegiatan:', agenda.namaKegiatan),
                    // SizedBox(height: 16),
                    _buildDetailRow('Pelaksana Kegiatan:', agenda.plkKegiatan),
                    // SizedBox(height: 16),
                    _buildDetailRow('Tempat Kegiatan:', agenda.tmpKegiatan),
                    // SizedBox(height: 16),
                    _buildDetailRow('Tanggal Kegiatan:', formattedDate),
                    // SizedBox(height: 16),
                    _buildDetailRow('Waktu Kegiatan:', agenda.wktKegiatan),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
