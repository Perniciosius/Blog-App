import 'package:blog_app/api/blog_api.dart';
import 'package:blog_app/model/blog.dart';
import 'package:flutter/material.dart';

class BlogProvider with ChangeNotifier {

  final _blogApi = BlogApi();

  List<Blog>? _blogList;

  List<Blog>? get blogList => _blogList;

  Blog getBlogById(int id) => _blogList!.where((element) => element.id == id).first;

  BlogProvider() {
    fetchBlog();
  }

  void fetchBlog() async {
    _blogList = await _blogApi.getAll();
    notifyListeners();
  }

  void postBlog(Blog blog) async {
    await _blogApi.postBlog(blog);
    fetchBlog();
  }

  void updateBlog(Blog blog) async {
    await _blogApi.putBlog(blog);
    fetchBlog();
  }
}