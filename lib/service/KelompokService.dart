// service/KelompokService.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Kelompok.dart'; // Pastikan alamat direktori model Kelompok sudah sesuai dengan struktur proyek Anda
import 'package:simasjid/service/url.dart';

class KelompokService {
  Future<List<Kelompok>> fetchKelompokList() async {
    final response = await http.get(Uri.parse(
        '${BaseUrl.baseUrl}ApiKelompokQurban/getAllKelompokWithTahun'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> jsonData = responseData[
          'kelompok_qurban_with_tahun']; // Ambil bagian 'kelompok_qurban_with_tahun' dari respon JSON

      return jsonData.map((data) => Kelompok.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
