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

      if (pesertaKelompokList != null && pesertaKelompokList.isNotEmpty) {
        setState(() {
          _filteredPesertaKelompokList = pesertaKelompokList;
        });
      } else {
        setState(() {
          _filteredPesertaKelompokList = []; // Clear the list
        });
      }
    } catch (e) {
      print('Error fetching peserta kelompok data: $e');
      // Handle error here, show error message, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Peserta Kelompok',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true, // Tambahkan ini untuk mengatur judul di tengah
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: _filteredPesertaKelompokList.isNotEmpty
          ? ListView.builder(
              itemCount: _filteredPesertaKelompokList.length,
              itemBuilder: (context, index) {
                final pesertaKelompok = _filteredPesertaKelompokList[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius:
                        BorderRadius.circular(10), // Tambahkan radius di sini
                  ),
                  child: ListTile(
                    title: Text('${pesertaKelompok.namaPeserta}'),
                    subtitle: Text('Rp. ${pesertaKelompok.biaya}'),
                    // Add more fields as needed to display relevant information.
                  ),
                );
              },
            )
          : Center(child: Text('Tidak ada data peserta kelompok')),
    );
  }
}
