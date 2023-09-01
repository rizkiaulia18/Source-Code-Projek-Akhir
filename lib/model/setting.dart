class Setting {
  final String id;
  final String namaMasjid;
  final String idKota;
  final String alamat;
  final String logo;

  Setting({
    required this.id,
    required this.namaMasjid,
    required this.idKota,
    required this.alamat,
    required this.logo,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json['id'],
      namaMasjid: json['nama_masjid'],
      idKota: json['id_kota'],
      alamat: json['alamat'],
      logo: json['logo'],
    );
  }
}
