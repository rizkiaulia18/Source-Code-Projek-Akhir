class PesertaPribadi {
  final String id;
  final String idTahun;
  final String namaPeserta;
  final int biaya;

  PesertaPribadi({
    required this.id,
    required this.idTahun,
    required this.namaPeserta,
    required this.biaya,
  });

  factory PesertaPribadi.fromJson(Map<String, dynamic> json) {
    return PesertaPribadi(
      id: json['id_peserta_p'].toString(),
      idTahun: json['id_tahun'].toString(),
      namaPeserta: json['nama_peserta'].toString(),
      biaya: int.parse(json['biaya'].toString()),
    );
  }
}
