import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:simasjid/service/url.dart';

import '../model/tahun.dart';

class TahunService {
  Future<List<Tahun>> fetchTahun() async {
    final response = await http.get(Uri.parse('${BaseUrl.baseUrl}apitahun'));

    if (response.statusCode == 200) {
      return parseTahun(response.body);
    } else {
      throw Exception('Gagal memuat data tahun');
    }
  }

  List<Tahun> parseTahun(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Tahun>((json) => Tahun.fromJson(json)).toList();
  }
}
