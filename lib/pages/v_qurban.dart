import 'package:flutter/material.dart';
import '../model/Kelompok.dart';
import '../model/PesertaPribadi.dart';
import '../model/peserta_kelompok.dart';
import '../service/KelompokService.dart';
import '../service/PesertaPribadiService.dart';
import '../service/PesertaKelompokService.dart';
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
  List<PesertaPribadi> _pesertaPribadiList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _fetchKelompok();
    _fetchPesertaPribadi();
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

  Future<void> _fetchPesertaKelompokByKelompok(int idKelompok) async {
    try {
      final List<PesertaKelompok>? pesertaKelompokList =
          await PesertaKelompokService().fetchPesertaKelompok(idKelompok);

      if (pesertaKelompokList != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListPesertaKelompok(
              idKelompokDipilih: idKelompok,
              pesertaKelompokList: pesertaKelompokList,
            ),
          ),
        );
      } else {
        print('Response is null or empty.');
        // Handle empty response or show appropriate message.
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
        title: Center(
          child: Text(
            'Qurban',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 150, 126, 118),
            ),
          ),
        ),
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
          _kelompokList.isEmpty
              ? Center(child: Text('Tidak ada data kelompok '))
              : ListView.builder(
                  itemCount: _kelompokList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${_kelompokList[index].namaKelompok}'),
                      onTap: () {
                        _fetchPesertaKelompokByKelompok(
                            _kelompokList[index].idKelompok);
                      },
                    );
                  },
                ),

          // Konten halaman Pribadi
          _pesertaPribadiList.isEmpty
              ? Center(child: Text('Tidak ada data peserta pribadi'))
              : ListView.builder(
                  itemCount: _pesertaPribadiList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          'Nama Peserta: ${_pesertaPribadiList[index].namaPeserta}'),
                      subtitle:
                          Text('Biaya: ${_pesertaPribadiList[index].biaya}'),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
