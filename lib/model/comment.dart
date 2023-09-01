class Comment {
  final String idComment;
  final String content;
  final String contentAdmin;
  final String email;
  final String createdBy;
  final String createdAt;
  final String createdAtAdmin;
  final String status;

  Comment({
    required this.idComment,
    required this.content,
    required this.contentAdmin,
    required this.email,
    required this.createdBy,
    required this.createdAt,
    required this.createdAtAdmin,
    required this.status,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      idComment: json['id_comment'],
      content: json['content'],
      contentAdmin: json['content_admin'],
      email: json['email'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      createdAtAdmin: json['created_at_admin'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id_comment': idComment,
        'content': content,
        'content_admin': contentAdmin,
        'email': email,
        'created_by': createdBy,
        'created_at': createdAt,
        'created_at_admin': createdAtAdmin,
        'status': status,
      };
}
