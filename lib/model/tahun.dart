class Tahun {
  final String id;
  final String tahunHijriah;
  final String tahunMasehi;

  Tahun({
    required this.id,
    required this.tahunHijriah,
    required this.tahunMasehi,
  });

  factory Tahun.fromJson(Map<String, dynamic> json) {
    return Tahun(
      id: json['id_tahun'].toString(),
      tahunHijriah: json['tahun_h'].toString(),
      tahunMasehi: json['tahun_m'].toString(),
    );
  }
}
