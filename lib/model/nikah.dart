class Nikah {
  final String id_nikah;
  final String nama_pengantin_p;
  final String nama_pengantin_w;
  final String nama_penghulu;
  final String nama_wali;
  final String nama_qori;
  final String no_hp;
  final String tgl_nikah;
  final String jam_nikah;
  final String bukti_dp;
  final String status;
  final String email;
  final String created_by;
  final String created_at;

  const Nikah({
    required this.id_nikah,
    required this.nama_pengantin_p,
    required this.nama_pengantin_w,
    required this.nama_penghulu,
    required this.nama_wali,
    required this.nama_qori,
    required this.no_hp,
    required this.tgl_nikah,
    required this.jam_nikah,
    required this.bukti_dp,
    required this.status,
    required this.email,
    required this.created_by,
    required this.created_at,
  });

  factory Nikah.fromJson(Map<String, dynamic> json) {
    return Nikah(
      id_nikah: json['id_nikah'],
      nama_pengantin_p: json['nama_pengantin_p'],
      nama_pengantin_w: json['nama_pengantin_w'],
      nama_penghulu: json['nama_penghulu'],
      nama_wali: json['nama_wali'],
      nama_qori: json['nama_qori'],
      no_hp: json['no_hp'],
      tgl_nikah: json['tgl_nikah'],
      jam_nikah: json['jam_nikah'],
      bukti_dp: json['bukti_dp'],
      status: json['status'],
      email: json['email'],
      created_by: json['created_by'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_nikah': id_nikah,
      'nama_pengantin_p': nama_pengantin_p,
      'nama_pengantin_w': nama_pengantin_w,
      'nama_penghulu': nama_penghulu,
      'nama_wali': nama_wali,
      'nama_qori': nama_qori,
      'no_hp': no_hp,
      'tgl_nikah': tgl_nikah,
      'jam_nikah': jam_nikah,
      'bukti_dp': bukti_dp,
      'status': status,
      'email': email,
      'created_by': created_by,
      'created_at': created_at,
    };
  }
}
