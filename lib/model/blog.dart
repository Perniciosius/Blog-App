class Blog {
  int? id;
  late String title;
  late String content;

  Blog({this.id, required this.title, required this.content});

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    content = json['content'] as String;
  }

  Map<String, Object> toJson() {
    return <String, Object> {
      'title' : title,
      'content' : content,
    };
  }
}