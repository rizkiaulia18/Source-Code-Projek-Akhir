class Userr {
  final int? idUser;
  final String nama;
  final String? email;

  Userr({
    this.idUser,
    required this.nama,
    this.email,
  });

  factory Userr.fromJson(Map<String, dynamic> json) {
    return Userr(
      idUser: json['id_user'],
      nama: json['nama'],
      email: json['email'],
    );
  }
}
