import 'package:blog_app/constants.dart';
import 'package:blog_app/pages/create_edit_blog.dart';
import 'package:blog_app/providers/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogView extends StatelessWidget {
  final int blogId;

  const BlogView({Key? key, required this.blogId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BlogProvider>(
        builder: (context, blogProvider, _) {
          var blog = blogProvider.getBlogById(blogId);
          return CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Blog'),
                centerTitle: true,
                // titlePadding: EdgeInsetsDirectional.only(
                //   start: padding,
                //   bottom: padding / 2,
                // ),
              ),
              expandedHeight: 100.0,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateEditBlog(blog: blog),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Text(blog.content),
              ),
            ),
          ],
        );
        },
      ),
    );
  }
}
