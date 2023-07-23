import 'package:flutter/material.dart';
import 'package:simasjid/pages/v_nikah.dart';

import '../model/nikah.dart';
import '../service/nikahService.dart';

class AddNikah extends StatefulWidget {
  const AddNikah({Key? key}) : super(key: key);

  @override
  State<AddNikah> createState() => _AddNikahState();
}

class _AddNikahState extends State<AddNikah> {
  NikahService nikahService = NikahService();
  final _nama_pengantin_pController = TextEditingController();
  final _nama_pengantin_wController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Nikah',
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 150, 126, 118),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nama_pengantin_pController,
              decoration: InputDecoration(
                hintText: 'Nama Pengantin Pria',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nama_pengantin_wController,
              decoration: InputDecoration(
                hintText: 'Nama Pengantin Wanita',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_nama_pengantin_pController.text.isEmpty ||
                    _nama_pengantin_wController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content:
                          Text('Nama pengantin pria dan wanita harus diisi.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                Nikah newNikah = Nikah(
                  id_nikah: '',
                  nama_pengantin_p: _nama_pengantin_pController.text,
                  nama_pengantin_w: _nama_pengantin_wController.text,
                  nama_penghulu: '',
                  nama_wali: '',
                  nama_qori: '',
                  tgl_nikah: '',
                  jam_nikah: '',
                );

                bool response = await nikahService.postData(
                  newNikah.nama_pengantin_p,
                  newNikah.nama_pengantin_w,
                );

                if (response) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => NikahView()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Gagal Menambahkan Nikah'),
                      content: Text(
                          'Terjadi kesalahan saat menambahkan data nikah.'),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
