import 'package:http/http.dart' as http;
import 'package:simasjid/service/url.dart';
import 'dart:convert';

import '../model/setting.dart'; // Ganti 'your_app' dengan package name Anda

class SettingService {
  Future<List<Setting>> fetchSettings() async {
    final response = await http.get(Uri.parse('${BaseUrl.baseUrl}ApiSetting'));

    if (response.statusCode == 200) {
      return parseSettings(response.body);
    } else {
      throw Exception('Failed to load settings');
    }
  }

  List<Setting> parseSettings(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Setting>((json) => Setting.fromJson(json)).toList();
  }
}
