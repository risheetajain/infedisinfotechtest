import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:infedisinfotechtest/modals/articles.dart';

import '../modals/book_modal.dart';

class ApiServices {
  Future<List<Articles>?> getList() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2022-06-14&sortBy=publishedAt&apiKey=b984efd5b82a4a9bafb5acd2baf0eb9f";
    try {
      final response = await http.get(Uri.parse(url));

      // throw HttpException('${response.statusCode}');
      print("respinse $response");
      var jsonMap = jsonDecode(response.body);
      List<dynamic> data = jsonMap["articles"];

      List<Articles> rs =
          List<Articles>.from(data.map((e) => Articles.fromJson(e)));
      print(rs.length);
      return rs;
    } on SocketException {
      print('No Internet connection ');
    } on FormatException {
      print("Bad response format ");
    }
    return null;
  }

  Future<List<BookModel>?> getBooks(String query) async {
    String url = "https://www.googleapis.com/books/v1/volumes?q=$query";
    try {
      final response = await http.get(Uri.parse(url));

      // throw HttpException('${response.statusCode}');
      print("respinse $response");
      var jsonMap = jsonDecode(response.body);
      List<dynamic> data = jsonMap["items"];

      List<BookModel> rs =
          List<BookModel>.from(data.map((e) => BookModel.fromJson(e)));
      print(rs.length);
      return rs;
    } on SocketException {
      print('No Internet connection ');
    } on FormatException {
      print("Bad response format ");
    }
    return null;
  }
}
