import 'package:intl/intl.dart';

class JadwalShalat {
  String lokasi;
  Jadwal jadwal;

  JadwalShalat({required this.lokasi, required this.jadwal});

  factory JadwalShalat.fromJson(Map<String, dynamic> json) {
    return JadwalShalat(
      lokasi: json['lokasi'],
      jadwal: Jadwal.fromJson(json['jadwal']),
    );
  }
}

class Jadwal {
  String tanggal;
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;

  Jadwal({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      tanggal: json['tanggal'],
      imsak: json['imsak'],
      subuh: json['subuh'],
      terbit: json['terbit'],
      dhuha: json['dhuha'],
      dzuhur: json['dzuhur'],
      ashar: json['ashar'],
      maghrib: json['maghrib'],
      isya: json['isya'],
    );
  }

  // Tambahkan method untuk menguraikan waktu shalat
  DateTime parseTime(String time) {
    return DateFormat('HH:mm').parse(time);
  }
}
