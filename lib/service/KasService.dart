import 'package:simasjid/model/kas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:simasjid/service/url.dart';

class KasService {
  static final String _baseUrl = '${BaseUrl.baseUrl}/ApiKasmasjid/';

  Future<List<Kas>> getKas() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final response = await http.get(urlApi);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Kas> kasList =
          jsonResponse.map((data) => Kas.fromJson(data)).toList();
      return kasList;
    } else {
      throw Exception("Failed to load data Kas");
    }
  }
}
