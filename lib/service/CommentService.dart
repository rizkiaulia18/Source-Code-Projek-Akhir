import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simasjid/service/url.dart';
import '../model/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  Future<List<Comment>> fetchComments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail =
        prefs.getString('email') ?? ''; // Default value jika email tidak ada

    final response = await http.get(Uri.parse(
        '${BaseUrl.baseUrl}/ApiKomentar/getByEmail?email=$userEmail'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Comment> comments =
          jsonData.map((data) => Comment.fromJson(data)).toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<String> postComment(
      String content, String email, String createdBy) async {
    final url = Uri.parse('${BaseUrl.baseUrl}/ApiKomentar/create');
    final request = http.MultipartRequest('POST', url);
    request.fields['content'] = content;
    request.fields['email'] = email;
    request.fields['created_by'] = createdBy;

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonData = jsonDecode(responseBody);
      if (jsonData['message'] == 'Komentar berhasil ditambahkan.') {
        return 'Komentar berhasil ditambahkan.';
      } else {
        throw Exception('Gagal menambahkan komentar');
      }
    } else {
      throw Exception(
          'Gagal menambahkan komentar. Error: ${response.statusCode}');
    }
  }
}
