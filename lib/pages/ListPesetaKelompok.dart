import 'package:flutter/material.dart';
import 'package:simasjid/model/peserta_kelompok.dart';
import 'package:simasjid/service/PesertaKelompokService.dart'; // Import service PesertaKelompokService

class ListPesertaKelompok extends StatefulWidget {
  final int idKelompokDipilih;

  const ListPesertaKelompok(
      {Key? key,
      required this.idKelompokDipilih,
      required List<PesertaKelompok> pesertaKelompokList})
      : super(key: key);

  @override
  State<ListPesertaKelompok> createState() => _ListPesertaKelompokState();
}

class _ListPesertaKelompokState extends State<ListPesertaKelompok> {
  List<PesertaKelompok> _filteredPesertaKelompokList = [];

  @override
  void initState() {
    super.initState();
    _fetchPesertaKelompokByKelompok();
  }

  Future<void> _fetchPesertaKelompokByKelompok() async {
  try {
    List<PesertaKelompok>? pesertaKelompokList =
        await PesertaKelompokService()
            .fetchPesertaKelompok(widget.idKelompokDipilih);

    if (pesertaKelompokList != null) {
      setState(() {
        _filteredPesertaKelompokList = pesertaKelompokList;
      });
    } else {
      print('Response is null or empty.');
      // Handle empty response or show appropriate message.
    }
  } catch (e) {
    print('Error fetching peserta kelompok data: $e');
    // Handle error here, show error message, etc.
  }
}


  // ... (code for build method and other parts)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Peserta Kelompok',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 150, 126, 118),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: _filteredPesertaKelompokList.isEmpty
          ? Center(child: Text('Tidak ada data peserta kelompok'))
          : ListView.builder(
              itemCount: _filteredPesertaKelompokList.length,
              itemBuilder: (context, index) {
                final pesertaKelompok = _filteredPesertaKelompokList[index];
                return ListTile(
                  title: Text('Nama Peserta: ${pesertaKelompok.namaPeserta}'),
                  subtitle: Text('Alamat: ${pesertaKelompok.biaya}'),
                  // Add more fields as needed to display relevant information.
                );
              },
            ),
    );
  }
}
