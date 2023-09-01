import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/jadwal_shalat.dart';

class JadwalShalatService {
  Future<JadwalShalat?> fetchJadwalShalat() async {
    String formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.now());
    final response = await http.get(Uri.parse(
        'https://api.myquran.com/v1/sholat/jadwal/0119/$formattedDate'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print('Response Data: $responseData'); // Tambahkan pernyataan print ini
      final Map<String, dynamic> data = responseData['data'] ?? {};
      // print('Data from API: $data'); // Tambahkan pernyataan print ini
      return JadwalShalat.fromJson(data);
    } else {
      print('HTTP Error: ${response.statusCode}');
    }
    return null;
  }
}
