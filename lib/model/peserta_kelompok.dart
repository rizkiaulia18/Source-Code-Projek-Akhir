class PesertaKelompok {
  final String idPeserta;
  final String idKelompok;
  final String namaPeserta;
  final String biaya;

  PesertaKelompok({
    required this.idPeserta,
    required this.idKelompok,
    required this.namaPeserta,
    required this.biaya,
  });

  factory PesertaKelompok.fromJson(Map<String, dynamic> json) {
    return PesertaKelompok(
      idPeserta: json['id_peserta'],
      idKelompok: json['id_kelompok'],
      namaPeserta: json['nama_peserta'],
      biaya: json['biaya'],
    );
  }
}
