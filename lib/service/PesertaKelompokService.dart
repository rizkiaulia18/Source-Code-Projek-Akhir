import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simasjid/service/url.dart';

import '../model/peserta_kelompok.dart';

class PesertaKelompokService {
  Future<List<PesertaKelompok>?> fetchPesertaKelompok(int idKelompok) async {
    try {
      final response = await http.get(Uri.parse(
          '${BaseUrl.baseUrl}apipesertakelompok?id_kelompok=$idKelompok'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic>? jsonData = responseData['peserta_kelompok'];

        if (jsonData != null) {
          return jsonData
              .map((data) => PesertaKelompok.fromJson(data))
              .toList();
        } else {
          return []; // Return an empty list if jsonData is null
        }
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching peserta kelompok data: $e');
      throw e;
    }
  }
}
