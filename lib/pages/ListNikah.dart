import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simasjid/model/nikah.dart';
import 'package:simasjid/service/NikahService.dart';

import '../details/detail_nikah.dart';

class ListNikah extends StatefulWidget {
  final DateTime selectedDay;

  const ListNikah({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _ListNikahState createState() => _ListNikahState();
}

class _ListNikahState extends State<ListNikah> {
  List<Nikah> listNikah = [];
  NikahService nikahService = NikahService();
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
    List<Nikah> data = await nikahService.getData();

    // Menghentikan loading
    setState(() {
      listNikah = data;
      isLoading = false;
    });
  }

  void navigateToDetailNikah(Nikah nikah) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailNikah(nikah: nikah)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Nikah> filteredNikah = listNikah.where((nikah) {
      DateTime nikahDate = DateTime.parse(nikah.tgl_nikah);
      return nikahDate.year == widget.selectedDay.year &&
          nikahDate.month == widget.selectedDay.month &&
          nikahDate.day == widget.selectedDay.day;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Nikah',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true, // Tambahkan ini untuk mengatur judul di tengah
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: isLoading // Periksa isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Tampilkan CircularProgressIndicator
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: filteredNikah.isNotEmpty
                  ? ListView.separated(
                      itemCount: filteredNikah.length,
                      itemBuilder: (context, index) {
                        Nikah nikah = filteredNikah[index];
                        DateTime tglNikah = DateTime.parse(nikah.tgl_nikah);
                        String formattedDate =
                            DateFormat('dd MMM yyyy').format(tglNikah);
                        // String formattedTime =
                        //     DateFormat('HH:mm').format(DateTime.parse(nikah.jam_nikah));
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(
                                10), // Tambahkan radius di sini
                          ),
                          child: ListTile(
                            title: Text('${nikah.nama_pengantin_p}' +
                                ' Dan ' +
                                '${nikah.nama_pengantin_w}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$formattedDate'),
                              ],
                            ),
                            trailing: Text(nikah.jam_nikah),
                            onTap: () {
                              navigateToDetailNikah(nikah);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                            // thickness: 10,
                            );
                      },
                    )
                  : Center(
                      child: Text('Tidak ada data nikah pada tanggal ini.'),
                    ),
            ),
    );
  }
}
