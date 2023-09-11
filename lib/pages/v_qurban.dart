import 'package:flutter/material.dart';
import '../model/Kelompok.dart';
import '../model/PesertaPribadi.dart';
import '../model/peserta_kelompok.dart';
import '../service/KelompokService.dart';
import '../service/PesertaKelompokService.dart';
import '../service/PesertaPribadiService.dart';
import 'ListPesetaKelompok.dart';

class QurbanView extends StatefulWidget {
  const QurbanView({Key? key}) : super(key: key);

  @override
  State<QurbanView> createState() => _QurbanViewState();
}

class _QurbanViewState extends State<QurbanView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Kelompok> _kelompokList = [];
  List<PesertaPribadi> _pesertaPribadiList =
      []; // Tambahkan list peserta pribadi

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _fetchKelompok();
    _fetchPesertaPribadi(); // Panggil fungsi untuk mengambil data peserta pribadi
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchKelompok() async {
    try {
      final List<Kelompok>? kelompokList =
          await KelompokService().fetchKelompokList();

      if (kelompokList != null) {
        // Filter daftar kelompok berdasarkan tahun saat ini (2023 dalam contoh ini)
        final int currentYear = DateTime.now().year;
        final List<Kelompok> filteredKelompokList = kelompokList
            .where((kelompok) => kelompok.tahunM == currentYear)
            .toList();

        setState(() {
          _kelompokList = filteredKelompokList;
        });
      } else {
        print('Response is null or empty.');
        // Handle empty response or show appropriate message.
      }
    } catch (e) {
      print('Error fetching kelompok data: $e');
      // Handle error here, show error message, etc.
    }
  }

  Future<void> _fetchPesertaPribadi() async {
    try {
      final List<PesertaPribadi>? pesertaPribadiList =
          await PesertaPribadiService().fetchPesertaPribadi();

      if (pesertaPribadiList != null) {
        setState(() {
          _pesertaPribadiList = pesertaPribadiList;
        });
      } else {
        print('Response is null or empty.');
        // Handle empty response or show appropriate message.
      }
    } catch (e) {
      print('Error fetching peserta pribadi data: $e');
      // Handle error here, show error message, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Qurban',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Kelompok'),
            Tab(text: 'Pribadi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Konten halaman Kelompok
          // Konten halaman Kelompok
          _kelompokList.isEmpty
              ? Center(child: Text('Tidak ada data kelompok '))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                  child: ListView.separated(
                    itemCount: _kelompokList.length,
                    separatorBuilder: (context, index) =>
                        Divider(thickness: 1), // Add a Divider between items
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title:
                                  Text('${_kelompokList[index].namaKelompok}'),
                              onTap: () async {
                                final List<PesertaKelompok>?
                                    pesertaKelompokList =
                                    await PesertaKelompokService()
                                        .fetchPesertaKelompok(
                                            _kelompokList[index].idKelompok);

                                if (pesertaKelompokList != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListPesertaKelompok(
                                        idKelompokDipilih:
                                            _kelompokList[index].idKelompok,
                                        pesertaKelompokList:
                                            pesertaKelompokList,
                                      ),
                                    ),
                                  );
                                } else {
                                  print('Response is null or empty.');
                                  // Handle empty response or show an appropriate message.
                                }
                              },
                            ),
                          ),
                          // Divider(
                          //   thickness: 1,
                          // ), // Add a Divider widget here
                        ],
                      );
                    },
                  ),
                ),

          // Konten halaman Pribadi
          // Konten halaman Pribadi
          _pesertaPribadiList.isEmpty
              ? Center(child: Text('Tidak ada data peserta pribadi'))
              : Padding(
                  padding: const EdgeInsets.fromLTRB(5, 8, 5, 0),
                  child: ListView.separated(
                    itemCount: _pesertaPribadiList.length,
                    separatorBuilder: (context, index) =>
                        Divider(thickness: 1), // Add a Divider between items
                    itemBuilder: (context, index) {
                      final pesertaPribadi = _pesertaPribadiList[index];
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text('${pesertaPribadi.namaPeserta}'),
                              subtitle: Text('Rp. ${pesertaPribadi.biaya}'),
                            ),
                          ),
                          // Divider(thickness: 1), // Add a Divider widget here
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
