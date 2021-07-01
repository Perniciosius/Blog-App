import 'dart:ui';

import 'package:blog_app/constants.dart';
import 'package:blog_app/pages/blog_view.dart';
import 'package:blog_app/pages/create_edit_blog.dart';
import 'package:blog_app/providers/blog_provider.dart';
import 'package:blog_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var blogList = Provider.of<BlogProvider>(context).blogList;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<BlogProvider>(context, listen: false).fetchBlog();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Blog',
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
              actions: [
                IconButton(
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (context, animation, _) => BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Center(
                          child: ThemeDialog(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.dark_mode_rounded),
                )
              ],
            ),
            (blogList == null)
                ? SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    hasScrollBody: false,
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Card(
                        elevation: 10.0,
                        margin: EdgeInsets.all(margin),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)),
                        clipBehavior: Clip.antiAlias,
                        child: ListTile(
                          title: Text(blogList[index].title),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BlogView(
                                  blogId: blogList[index].id!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      childCount: blogList.length,
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateEditBlog(),
            ),
          );
        },
        label: Text('New'),
        icon: Icon(Icons.create_rounded),
      ),
    );
  }
}

class ThemeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _themeMode = Provider.of<ThemeProvider>(context).themeMode;
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: SizedBox(
        height: dialogSize,
        width: dialogSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(padding),
              child: Text(
                'THEME',
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 20.0,
                ),
              ),
            ),
            RadioListTile<ThemeMode>(
              title: Text('System'),
              value: ThemeMode.system,
              groupValue: _themeMode,
              onChanged: onThemeChange(context, _themeMode),
            ),
            RadioListTile<ThemeMode>(
              title: Text('Light'),
              value: ThemeMode.light,
              groupValue: _themeMode,
              onChanged: onThemeChange(context, _themeMode),
            ),
            RadioListTile<ThemeMode>(
              title: Text('Dark'),
              value: ThemeMode.dark,
              groupValue: _themeMode,
              onChanged: onThemeChange(context, _themeMode),
            ),
          ],
        ),
      ),
    );
  }

  Function(ThemeMode?) onThemeChange(
      BuildContext context, ThemeMode themeMode) {
    return (ThemeMode? value) {
      themeMode = value!;
      Provider.of<ThemeProvider>(context, listen: false).setThemeMode(value);
      Navigator.of(context).pop();
    };
  }
}
