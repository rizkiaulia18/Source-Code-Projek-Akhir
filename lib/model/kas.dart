class Kas {
  final String idKas;
  final String tanggal;
  final String keterangan;
  final int kasMasuk;
  final int kasKeluar;
  final String status;

  Kas({
    required this.idKas,
    required this.tanggal,
    required this.keterangan,
    required this.kasMasuk,
    required this.kasKeluar,
    required this.status,
  });

  factory Kas.fromJson(Map<String, dynamic> json) {
    return Kas(
      idKas: json['id_kas'],
      tanggal: json['tanggal'],
      keterangan: json['ket'],
      kasMasuk: int.parse(json['kas_masuk']),
      kasKeluar: int.parse(json['kas_keluar']),
      status: json['status'],
    );
  }
}
