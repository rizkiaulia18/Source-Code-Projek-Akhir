import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simasjid/model/comment.dart';
import 'package:simasjid/service/CommentService.dart';
// import 'package:simasjid/service/auth.dart';

class KomentarView extends StatefulWidget {
  const KomentarView({Key? key}) : super(key: key);

  @override
  State<KomentarView> createState() => _KomentarViewState();
}

class _KomentarViewState extends State<KomentarView> {
  TextEditingController _commentController = TextEditingController();
  CommentService _commentService = CommentService();
  List<Comment> comments = [];
  String _email = '';
  String _createdBy = '';

  // Auth _auth = Auth(); // Buat instance dari kelas Auth

  @override
  void initState() {
    super.initState();
    _fetchComments();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? '';
      _createdBy =
          prefs.getString('displayName') ?? ''; // Ambil dari displayName
    });

    // Jika _createdBy kosong, ambil dari nama
    if (_createdBy.isEmpty) {
      _createdBy = prefs.getString('nama') ?? '';
    }
  }

  Future<void> _fetchComments() async {
    try {
      List<Comment> fetchedComments = await _commentService.fetchComments();
      setState(() {
        comments = fetchedComments;
      });
    } catch (e) {
      print('Failed to fetch comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Komentar',
          style: TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 150, 126, 118),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 238, 227, 203),
      ),
      body: // Cek apakah email (token) tidak kosong
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Komentar:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                Comment comment = comments[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.createdAt,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            comment.createdBy,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(comment.content),
                          SizedBox(height: 10),
                          Align(
                            alignment:
                                Alignment.centerRight, // Mengatur rata kanan
                            child: comment.contentAdmin.isNotEmpty
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        comment.createdAtAdmin,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "Admin Masjid",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        comment.contentAdmin,
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  )
                                : Text("Belum Dibalas"),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Masukkan komentar Anda...',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_commentController.text.isNotEmpty) {
                      try {
                        await _commentService.postComment(
                          _commentController.text,
                          _email,
                          _createdBy,
                        );
                        _fetchComments();
                        _commentController.clear();
                      } catch (e) {
                        print('Failed to post comment: $e');
                      }
                    }
                  },
                  child: Text('Kirim'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
