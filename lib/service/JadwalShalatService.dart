import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../model/jadwal_shalat.dart';

class JadwalShalatService {
  static final String _baseUrl = 'https://api.myquran.com/v1/sholat/jadwal/';

  Future<JadwalShalat> getJadwalShalat(String id, DateTime date) async {
    String formattedDate = DateFormat('yyyy/MM/dd').format(date);
    Uri urlApi = Uri.parse('$_baseUrl$id/$formattedDate');

    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return JadwalShalat.fromJson(data['data']);
    } else {
      throw Exception("Failed to load data Jadwal Shalat");
    }
  }
}
