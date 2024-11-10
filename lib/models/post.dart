class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  Post.fromJson(Map map) {
    userId = map['userId'];
    id = map['id'];
    title = map['title'];
    body = map['body'];
  }

  Map toMap() {
    return {
      'user': userId,
      'id': id,
      'title': title,
      'body': body
    };
  }
  
}