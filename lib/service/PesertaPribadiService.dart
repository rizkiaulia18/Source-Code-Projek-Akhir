import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simasjid/service/url.dart';
import '../model/PesertaPribadi.dart';

class PesertaPribadiService {
  Future<List<PesertaPribadi>> fetchPesertaPribadi() async {
    final now = DateTime.now();
    final tahunM = now.year;

    final response = await http
        .get(Uri.parse('${BaseUrl.baseUrl}ApiPesertaPribadi?tahun_m=$tahunM'));

    if (response.statusCode == 200) {
      return parsePesertaPribadi(response.body);
    } else {
      throw Exception('Gagal memuat data peserta pribadi');
    }
  }

  List<PesertaPribadi> parsePesertaPribadi(String responseBody) {
    final parsed = jsonDecode(responseBody)['peserta_pribadi']
        .cast<Map<String, dynamic>>();
    return parsed
        .map<PesertaPribadi>((json) => PesertaPribadi.fromJson(json))
        .toList();
  }
}
