import 'package:flutter/material.dart';
import 'package:infedisinfotechtest/HomePage.dart';
import 'package:infedisinfotechtest/constant/route.dart';
import 'package:infedisinfotechtest/get_books.dart';

import 'main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hidoc App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          toolbarTextStyle: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ).headline6,
        ),
        primarySwatch: Colors.purple,
      ),
      // home: MainPage(),
      initialRoute: homeRoute,
      routes: {
        bookRoute: (context) => GetBooks(),
        articleRoute: (context) => HomePage(),
        homeRoute: (context) => MainPage(),
      },
    );
  }
}
