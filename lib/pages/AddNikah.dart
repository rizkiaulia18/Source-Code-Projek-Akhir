import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/model/nikah.dart';
import 'dart:io';
import '../service/NikahService.dart';
import '../service/SettingService.dart';
import '../model/setting.dart';
import 'button.dart';

class AddNikah extends StatefulWidget {
  @override
  _AddNikahState createState() => _AddNikahState();
}

class _AddNikahState extends State<AddNikah> {
  final _formKey = GlobalKey<FormState>();
  final _nikahService = NikahService();
  final ImagePicker _imagePicker = ImagePicker();
  File? _buktiDp;
  List<Setting> _settings = [];
  List<Nikah> _nikah = [];

  String _namaPengantinP = '';
  String _namaPengantinW = '';
  String _namaPenghulu = '';
  String _namaWali = '';
  String _namaQori = '';
  String _no_hp = '';
  DateTime _tglNikah = DateTime.now();
  TimeOfDay _jamNikah = TimeOfDay.now();
  String _status = 'pending';
  String _email = '';
  String _createdBy = '';
  String _createdAt = '';

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  Future<void> _fetchSettings() async {
    try {
      List<Setting> settings = await SettingService().fetchSettings();
      setState(() {
        _settings = settings;
      });
    } catch (error) {
      // Handle error
    }
  }

  Future<void> _fetchNikahData() async {
    try {
      List<Nikah> nikahData = await _nikahService
          .getData(); // Gantilah ini dengan cara Anda mengambil data nikah
      setState(() {
        _nikah = nikahData;
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSettings();
    _fetchUserInfo();
    _fetchNikahData(); // Panggil fungsi untuk mengambil data nikah
  }

  Future<void> _fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
      _createdBy =
          prefs.getString('displayName') ?? ''; // Ambil dari displayName
    });

    // Jika _createdBy kosong, ambil dari nama
    if (_createdBy.isEmpty) {
      _createdBy = prefs.getString('nama') ?? '';
    }
  }

  int _countNikahOnSelectedDate(DateTime selectedDate) {
    int count = 0;
    for (var nikah in _nikah) {
      DateTime nikahDate = DateTime.parse(nikah.tgl_nikah);
      if (nikahDate.year == selectedDate.year &&
          nikahDate.month == selectedDate.month &&
          nikahDate.day == selectedDate.day) {
        count++;
      }
    }
    return count;
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_buktiDp == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Anda harus memilih gambar bukti DP')),
        );
        return;
      }

      _formKey.currentState!.save();

      int nikahCount = _countNikahOnSelectedDate(_tglNikah);

      if (nikahCount >= 3) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content: Text('Maksimal 3 data nikah pada tanggal yang sama')),
        // );
        String result1 =
            "Maksimal 3 data nikah pada tanggal yang sama, silahkan pilih tanggal lain";
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Info!!!',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              content: Text(result1),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: buttonPrimary,
                ),
              ],
            );
          },
        );
        return;
      }

      try {
        DateTime now = DateTime.now();
        _createdAt =
            '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
        String result = await _nikahService.postData(
          _namaPengantinP,
          _namaPengantinW,
          _namaPenghulu,
          _namaWali,
          _namaQori,
          _no_hp,
          _tglNikah.toString(),
          _formatTimeOfDay(_jamNikah),
          _buktiDp!,
          _status,
          _email,
          _createdBy,
          _createdAt,
        );

        // Tampilkan alert dialog jika data berhasil ditambahkan
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sukses'),
              content: Text(result),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: buttonPrimary,
                ),
              ],
            );
          },
        );

        _formKey.currentState!.reset();
        setState(() {
          _buktiDp = null;
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _buktiDp = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _buktiDp = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Jadwal Nikah',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true, // Tambahkan ini untuk mengatur judul di tengah
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
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
                decoration: InputDecoration(
                    labelText: 'Nama Orang Tua / Wali dari Pengantin Wanita'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Wali tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _namaWali = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor HP / WA'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nomor HP tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) {
                  _no_hp = value!;
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
              Text(
                '*Silahkan input bukti pembayaran DP ke Rekening berikut :',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(
                _settings.isNotEmpty
                    ? '${_settings[0].rek}'
                    : 'Nomor Rekening tidak tersedia',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Pilih Sumber Gambar'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _pickImage();
                                },
                                child: Text(
                                  'Galeri',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                style: buttonPrimary,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _pickImageFromCamera();
                                },
                                child: Text(
                                  'Kamera',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                style: buttonPrimary,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: Text(
                  'Pilih Bukti DP',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: buttonPrimary,
              ),
              if (_buktiDp != null)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Image.file(_buktiDp!),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Image.file(
                      _buktiDp!,
                      height: 100,
                    ),
                  ),
                ),
              SizedBox(height: 16),
              if (_buktiDp != null)
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Booking Nikah',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: buttonPrimary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
