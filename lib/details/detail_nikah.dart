import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simasjid/model/nikah.dart';

class DetailNikah extends StatelessWidget {
  final Nikah nikah;

  const DetailNikah({Key? key, required this.nikah}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        DateFormat('dd MMMM yyyy').format(DateTime.parse(nikah.tgl_nikah));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Nikah',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: _buildDetailRow(
                          'Nama Pengantin Pria :', nikah.nama_pengantin_p),
                    ),
                    _buildDetailRow(
                        'Nama Pengantin Wanita :', nikah.nama_pengantin_w),
                    _buildDetailRow('Nama Penghulu :', nikah.nama_penghulu),
                    _buildDetailRow('Nama Wali :', nikah.nama_wali),
                    _buildDetailRow('Nama Qori :', nikah.nama_qori),
                    _buildDetailRow('Tanggal Nikah :', formattedDate),
                    _buildDetailRow('Jam Nikah :', nikah.jam_nikah),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
