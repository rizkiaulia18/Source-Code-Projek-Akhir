class Nikah {
  final String id_nikah;
  final String nama_pengantin_p;
  final String nama_pengantin_w;
  final String nama_penghulu;
  final String nama_wali;
  final String nama_qori;
  final String tgl_nikah;
  final String jam_nikah;

  const Nikah({
    required this.id_nikah,
    required this.nama_pengantin_p,
    required this.nama_pengantin_w,
    required this.nama_penghulu,
    required this.nama_wali,
    required this.nama_qori,
    required this.tgl_nikah,
    required this.jam_nikah,
  });

  factory Nikah.fromJson(Map<String, dynamic> json) {
    return Nikah(
      id_nikah: json['id_nikah'],
      nama_pengantin_p: json['nama_pengantin_p'],
      nama_pengantin_w: json['nama_pengantin_w'],
      nama_penghulu: json['nama_penghulu'],
      nama_wali: json['nama_wali'],
      nama_qori: json['nama_qori'],
      tgl_nikah: json['tgl_nikah'],
      jam_nikah: json['jam_nikah'],
    );
  }
}
