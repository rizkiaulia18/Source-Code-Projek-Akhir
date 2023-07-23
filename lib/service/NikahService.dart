import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simasjid/model/nikah.dart';
import 'package:simasjid/service/url.dart';

class NikahService {
  final String _baseUrl = '${BaseUrl.baseUrl}/apinikah';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Nikah> nikah = it.map((e) => Nikah.fromJson(e)).toList();
        return nikah;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> postData(String nama_penganti_p, String nama_penganti_w) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + '/create'),
        body: {
          "nama_penganti_p": nama_penganti_p,
          "nama_penganti_w": nama_penganti_w,
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Future postData(String nama_penganti_p, String nama_penganti_w) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(_baseUrl + '/create'),
  //       body: {
  //         "nama_penganti_p": postDatanama_penganti_p,
  //         "nama_penganti_w": nama_penganti_w,
  //       },
  //     );

  //     if (response.statusCode == 201) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
