import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/service/url.dart';

import '../model/users.dart';

class UsersService {
  Future<String?> getUserName(String email) async {
    try {
      final response =
          await http.get(Uri.parse('${BaseUrl.baseUrl}ApiUsers/show/$email'));
      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        return userData['nama']; // Mengambil data nama dari respons
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load user data, error: $e');
    }
  }

  Future<List<Userr>> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = prefs.getString('email') ?? '';
    try {
      final response = await http
          .get(Uri.parse('${BaseUrl.baseUrl}apiusers/show/$userEmail'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Userr> users = it.map((e) => Userr.fromJson(e)).toList();
        return users;
      } else {
        throw Exception(
            'Failed to load users, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load users, error: $e');
    }
  }

  Future<String> uploadUserData(String nama, String email) async {
    final url = Uri.parse('${BaseUrl.baseUrl}apiusers/create');

    final request = http.MultipartRequest('POST', url);
    request.fields['nama'] = nama;
    request.fields['email'] = email;

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseBody);

      if (jsonData['error'] == true) {
        throw Exception(jsonData['errors']['max_size']);
      } else if (jsonData['message'] == 'Pengguna berhasil dibuat') {
        return 'Data user berhasil ditambahkan';
      } else {
        throw Exception('Gagal menambahkan data user');
      }
    } else {
      throw Exception(
          'Gagal menambahkan data user. Error: ${response.statusCode}');
    }
  }
}
