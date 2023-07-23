import 'dart:convert';

List<Agenda> agendaFromJson(String str) =>
    List<Agenda>.from(json.decode(str).map((x) => Agenda.fromJson(x)));

String agendaToJson(List<Agenda> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Agenda {
  String idKegiatan;
  String namaKegiatan;
  String plkKegiatan;
  String tmpKegiatan;
  DateTime tglKegiatan;

  Agenda({
    required this.idKegiatan,
    required this.namaKegiatan,
    required this.plkKegiatan,
    required this.tmpKegiatan,
    required this.tglKegiatan,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        idKegiatan: json["id_kegiatan"],
        namaKegiatan: json["nama_kegiatan"],
        plkKegiatan: json["plk_kegiatan"],
        tmpKegiatan: json["tmp_kegiatan"],
        tglKegiatan: DateTime.parse(json["tgl_kegiatan"]),
      );

  Map<String, dynamic> toJson() => {
        "id_kegiatan": idKegiatan,
        "nama_kegiatan": namaKegiatan,
        "plk_kegiatan": plkKegiatan,
        "tmp_kegiatan": tmpKegiatan,
        "tgl_kegiatan":
            "${tglKegiatan.year.toString().padLeft(4, '0')}-${tglKegiatan.month.toString().padLeft(2, '0')}-${tglKegiatan.day.toString().padLeft(2, '0')}",
      };
}
