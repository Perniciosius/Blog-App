import 'package:blog_app/pages/homepage.dart';
import 'package:blog_app/providers/blog_provider.dart';
import 'package:blog_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<BlogProvider>(
          create: (_) => BlogProvider(),
          lazy: false,
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) => MaterialApp(
          title: 'To Do',
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: lightBackgroundColor,
              elevation: 0.0,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: lightBackgroundColor,
            buttonColor: lightButtonColor,
            iconTheme: IconThemeData(color: lightTextColor),
            scaffoldBackgroundColor: lightBackgroundColor,
            cardColor: lightListItemColor,
            accentColor: lightButtonColor,
            textTheme: TextTheme(
              bodyText2: TextStyle(
                color: lightTextColor,
              ),
              headline1: TextStyle(
                color: lightTextColor,
              ),
              headline4: TextStyle(
                color: lightTextColor,
              ),
              subtitle1: TextStyle(
                color: lightTextColor,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: lightButtonColor,
              foregroundColor: darkTextColor,
              focusColor: lightButtonColor,
            ),
          ),
          darkTheme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: darkBackgroundColor,
              elevation: 0.0,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: darkBackgroundColor,
            scaffoldBackgroundColor: darkBackgroundColor,
            buttonColor: darkButtonColor,
            iconTheme: IconThemeData(color: darkTextColor),
            cardColor: darkListItemColor,
            accentColor: darkButtonColor,
            textTheme: TextTheme(
              bodyText2: TextStyle(
                color: darkTextColor,
              ),
              headline1: TextStyle(
                color: darkTextColor,
              ),
              headline4: TextStyle(
                color: darkTextColor,
              ),
              subtitle1: TextStyle(
                color: darkTextColor,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: darkButtonColor,
              foregroundColor: darkTextColor,
              focusColor: darkButtonColor,
            ),
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
