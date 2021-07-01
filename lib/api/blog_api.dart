import 'dart:convert';
import 'package:blog_app/api/api_host.dart';
import 'package:blog_app/model/blog.dart';
import 'package:http/http.dart' as http;

class BlogApi {
  final path = 'json-server/blog/';
  final scheme = 'http';
  final httpClient = http.Client();

  Future<List<Blog>> getAll() async {
    final res = await httpClient.get(Uri(
      scheme: scheme,
      host: host,
      path: path,
    ));
    if (res.statusCode < 200 && res.statusCode >= 400)
      throw HTTPException(res.statusCode, 'Unable to fetch data');
    var blogJson = json.decode(res.body);
    var blogList = <Blog>[];
    for (final item in blogJson) {
      blogList.add(Blog.fromJson(item));
    }
    return blogList;
  }

  Future<Blog> getBlogById(int id) async {
    final res = await httpClient.get(Uri(
      scheme: scheme,
      host: host,
      path: path + '$id',
    ));
    if (res.statusCode < 200 && res.statusCode >= 400)
      throw HTTPException(res.statusCode, 'Unable to fetch data');
    var blogJson = json.decode(res.body);
    return Blog.fromJson(blogJson);
  }

  Future postBlog(Blog blog) async {
    final res = await httpClient.post(
      Uri(
        scheme: scheme,
        host: host,
        path: path,
      ),
      body: blog.toJson(),
    );
    if (res.statusCode < 200 && res.statusCode >= 400)
      throw HTTPException(res.statusCode, 'Failed to post data');
  }

  Future putBlog(Blog blog) async {
    final res = await httpClient.put(
      Uri(
        scheme: scheme,
        host: host,
        path: path + blog.id.toString(),
      ),
      body: blog.toJson(),
    );
    if (res.statusCode < 200 && res.statusCode >= 400)
      throw HTTPException(res.statusCode, 'Failed to update data');
  }
}

class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException(this.code, this.message);

  @override
  String toString() {
    return 'HTTPException {code: $code, message: $message}';
  }
}
