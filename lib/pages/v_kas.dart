import 'package:flutter/material.dart';

import '../model/kas.dart';
import '../service/KasService.dart';

class KasView extends StatefulWidget {
  const KasView({Key? key}) : super(key: key);

  @override
  State<KasView> createState() => _KasViewState();
}

class _KasViewState extends State<KasView> {
  List<Kas> _kasList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKasData();
  }

  void fetchKasData() async {
    try {
      KasService kasService = KasService();
      List<Kas> kasList = await kasService.getKas();
      setState(() {
        _kasList = kasList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Kas',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 150, 126, 118)))),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: <DataColumn>[
                  // DataColumn(label: Text('ID_Kas')),
                  DataColumn(label: Text('Tanggal')),
                  DataColumn(label: Text('Keterangan')),
                  DataColumn(label: Text('Masuk')),
                  DataColumn(label: Text('Keluar')),
                ],
                rows: _kasList.map((kas) {
                  return DataRow(
                    cells: <DataCell>[
                      // DataCell(Text(kas.idKas)),
                      DataCell(Text(kas.tanggal)),
                      DataCell(Text(kas.keterangan)),
                      DataCell(Text(kas.kasMasuk.toString())),
                      DataCell(Text(kas.kasKeluar.toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
