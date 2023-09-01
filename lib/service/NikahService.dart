import 'dart:convert';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:simasjid/model/nikah.dart';
import 'package:simasjid/service/url.dart';

class NikahService {
  // final String _baseUrl = '${BaseUrl.baseUrl}/apinikah';

  Future<List<Nikah>> getData() async {
    try {
      final response =
          await http.get(Uri.parse('${BaseUrl.baseUrl}apinikah?status=aktif'));
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

  Future<String> postData(
    String nama_pengantin_p,
    String nama_pengantin_w,
    String nama_penghulu,
    String nama_wali,
    String nama_qori,
    String no_hp,
    String tgl_nikah,
    String jam_nikah,
    io.File? bukti_dp,
    String status,
    String email,
    String created_by,
    String created_at,
  ) async {
    // Konversi tgl_nikah ke dalam format yang diharapkan (misal: 'yyyy-MM-dd')
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(tgl_nikah));

    final url = Uri.parse('${BaseUrl.baseUrl}apinikah/create');

    final request = http.MultipartRequest('POST', url);
    request.fields['nama_pengantin_p'] = nama_pengantin_p;
    request.fields['nama_pengantin_w'] = nama_pengantin_w;
    request.fields['nama_penghulu'] = nama_penghulu;
    request.fields['nama_wali'] = nama_wali;
    request.fields['nama_qori'] = nama_qori;
    request.fields['no_hp'] = no_hp;
    request.fields['tgl_nikah'] =
        formattedDate; // Gunakan tanggal yang sudah diubah formatnya
    request.fields['jam_nikah'] = jam_nikah;
    request.fields['status'] = status;
    request.fields['email'] = email;
    request.fields['created_by'] = created_by;
    request.fields['created_at'] = created_at;

    if (bukti_dp != null) {
      request.files
          .add(await http.MultipartFile.fromPath('bukti_dp', bukti_dp.path));
    }
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseBody);
      print(jsonData);

      if (jsonData['error'] != null && jsonData['error'] == true) {
        throw Exception(jsonData['errors']['max_size'] ??
            'Terjadi kesalahan saat mengunggah gambar.');
      } else if (jsonData['message'] == 'Data nikah berhasil dibuat') {
        return 'Data nikah berhasil berhasil dibuat, Silahkan menunggu komfirmasi dari admin';
      } else {
        throw Exception('Gagal menambahkan data nikah');
      }
    } else {
      throw Exception(
          'Gagal menambahkan data nikah. Error: ${response.statusCode}');
    }
  }
}
