import 'package:flutter/material.dart';
import 'package:simasjid/model/nikah.dart';

import '../service/NikahService.dart';

class AddNikah extends StatefulWidget {
  @override
  _AddNikahState createState() => _AddNikahState();
}

class _AddNikahState extends State<AddNikah> {
  final _formKey = GlobalKey<FormState>();
  final _nikahService = NikahService();

  String _namaPengantinP = '';
  String _namaPengantinW = '';
  String _namaPenghulu = '';
  String _namaWali = '';
  String _namaQori = '';
  DateTime _tglNikah = DateTime.now();
  TimeOfDay _jamNikah = TimeOfDay.now();

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Buat objek Nikah berdasarkan data yang diisi oleh pengguna
      Nikah newNikah = Nikah(
        id_nikah: '', // Jika Anda menggunakan auto-increment id, biarkan kosong
        nama_pengantin_p: _namaPengantinP,
        nama_pengantin_w: _namaPengantinW,
        nama_penghulu: _namaPenghulu,
        nama_wali: _namaWali,
        nama_qori: _namaQori,
        tgl_nikah: _tglNikah.toString(),
        jam_nikah: _formatTimeOfDay(
            _jamNikah), // Menggunakan metode _formatTimeOfDay dari kelas ini
      );

      // Kirim data nikah baru ke API
      await _nikahService.postData(newNikah);

      // Tampilkan snackbar sebagai notifikasi bahwa data berhasil ditambahkan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data nikah berhasil ditambahkan!'),
        ),
      );

      // Kembali ke halaman sebelumnya
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Nikah'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Pengantin Pria'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Pengantin Pria tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _namaPengantinP = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Pengantin Wanita'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Pengantin Wanita tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _namaPengantinW = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Penghulu'),
                onSaved: (value) {
                  _namaPenghulu = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Wali'),
                onSaved: (value) {
                  _namaWali = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Qori'),
                onSaved: (value) {
                  _namaQori = value!;
                },
              ),
              SizedBox(height: 16),
              Text('Tanggal Nikah'),
              InkWell(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _tglNikah = selectedDate;
                    });
                  }
                },
                child: Text(
                  '${_tglNikah.day}/${_tglNikah.month}/${_tglNikah.year}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              Text('Jam Nikah'),
              InkWell(
                onTap: () async {
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (selectedTime != null) {
                    setState(() {
                      _jamNikah = selectedTime;
                    });
                  }
                },
                child: Text(
                  _formatTimeOfDay(_jamNikah),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Tambah Data Nikah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
