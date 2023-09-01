class Kelompok {
  final int idKelompok;
  final int idTahun;
  final String namaKelompok;
  final int tahunM;

  Kelompok({
    required this.idKelompok,
    required this.idTahun,
    required this.namaKelompok,
    required this.tahunM,
  });

  factory Kelompok.fromJson(Map<String, dynamic> json) {
    return Kelompok(
      idKelompok: int.parse(json['id_kelompok'].toString()),
      idTahun: int.parse(json['id_tahun'].toString()),
      namaKelompok: json['nama_kelompok'],
      tahunM: int.parse(json['tahun_m'].toString()),
    );
  }
}
