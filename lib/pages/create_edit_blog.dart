import 'package:blog_app/constants.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/providers/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEditBlog extends StatefulWidget {
  final Blog? blog;
  CreateEditBlog({Key? key, this.blog}) : super(key: key);

  @override
  _CreateEditBlogState createState() => _CreateEditBlogState();
}

class _CreateEditBlogState extends State<CreateEditBlog> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late FocusNode _titleFocusNode;
  late FocusNode _contentFocusNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title);
    _contentController = TextEditingController(text: widget.blog?.content);
    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.blog == null ? 'New' : 'Edit',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Theme.of(context).textTheme.headline1?.color,
                ),
              ),
              titlePadding: EdgeInsetsDirectional.only(
                start: padding,
                bottom: padding / 2,
              ),
            ),
            expandedHeight: 100.0,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                textInputAction: TextInputAction.next,
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
                cursorColor: secondaryTextColor,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2?.color),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2?.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: _contentController,
                focusNode: _contentFocusNode,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                cursorColor: secondaryTextColor,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2?.color),
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyText2?.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 3 * padding),
              child: Center(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    if (_titleController.text == '') {
                      _titleFocusNode.requestFocus();
                      return;
                    }
                    if (_contentController.text == '') {
                      _contentFocusNode.requestFocus();
                      return;
                    }
                    if (widget.blog != null) {
                      Provider.of<BlogProvider>(context, listen: false)
                          .updateBlog(Blog(
                        id: widget.blog!.id,
                        title: _titleController.text,
                        content: _contentController.text,
                      ));
                    } else {
                      Provider.of<BlogProvider>(context, listen: false)
                          .postBlog(Blog(
                        title: _titleController.text,
                        content: _contentController.text,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                  label: Text(widget.blog == null ? 'Create new' : 'Update'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
