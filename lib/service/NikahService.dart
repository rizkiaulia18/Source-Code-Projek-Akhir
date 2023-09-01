// NikahService.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simasjid/model/nikah.dart';
import 'package:simasjid/service/url.dart';

class NikahService {
  final String _baseUrl = '${BaseUrl.baseUrl}/apinikah';

  Future<List<Nikah>> getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Nikah> nikah = it.map((e) => Nikah.fromJson(e)).toList();
        return nikah;
      } else {
        throw Exception(
            'Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data, error: $e');
    }
  }

  Future<String> postData(Nikah newNikah) async {
    final url = Uri.parse('$_baseUrl/create');
    final request = http.MultipartRequest('POST', url);
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['nama_pengantin_p'] = newNikah.nama_pengantin_p;
    request.fields['nama_pengantin_w'] = newNikah.nama_pengantin_w;
    request.fields['nama_penghulu'] = newNikah.nama_penghulu;
    request.fields['nama_wali'] = newNikah.nama_wali;
    request.fields['nama_qori'] = newNikah.nama_qori;
    request.fields['tgl_nikah'] = newNikah.tgl_nikah.toString();
    request.fields['jam_nikah'] = newNikah.jam_nikah.toString();

    final response = await request.send();
    // final responseBody = await response.stream.bytesToString();
    // final jsonData = jsonDecode(responseBody);

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseBody);
      if (jsonData['messages'] == 'Data nikah berhasil ditambahkan') {
        return 'Data nikah berhasil ditambahkan';
      } else {
        throw Exception(
            'Respon dari server tidak sesuai dengan yang diharapkan.');
      }
    } else {
      throw Exception(
          'Gagal menambahkan data nikah. Error: ${response.statusCode}');
    }
  }
}
