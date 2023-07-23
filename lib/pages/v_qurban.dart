import 'package:flutter/material.dart';

class QurbanView extends StatefulWidget {
  const QurbanView({Key? key}) : super(key: key);

  @override
  State<QurbanView> createState() => _QurbanViewState();
}

class _QurbanViewState extends State<QurbanView>
    with SingleTickerProviderStateMixin {
  // Controller untuk mengontrol TabBar dan TabBarView
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi TabController dengan jumlah tab yang diinginkan
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // Jangan lupa untuk melepaskan resource saat widget dihapus
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Qurban',
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 150, 126, 118)),
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
          // Ganti dengan konten halaman 1
          Center(child: Text('data kelompok')),
          // Ganti dengan konten halaman 2
          Center(child: Text('data pribadi')),
        ],
      ),
    );
  }
}
