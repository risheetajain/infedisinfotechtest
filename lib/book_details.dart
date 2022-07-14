import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:infedisinfotechtest/constant/color.dart';
import 'package:infedisinfotechtest/modals/book_modal.dart';
import 'package:infedisinfotechtest/widgets/widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({
    Key? key,
    required this.book,
  }) : super(key: key);
  final BookModel book;

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headingWidget("Title"),
                descriptionWidget(widget.book.volumeInfo!.title!),
                headingWidget("Subtitle"),
                descriptionWidget(widget.book.volumeInfo!.subtitle!),
                headingWidget("Description"),
                descriptionWidget(widget.book.volumeInfo!.description!),
                headingWidget("Authors"),
                descriptionWidget(widget.book.volumeInfo!.authors!.join(", ")),
                headingWidget("Publisher"),
                descriptionWidget(widget.book.volumeInfo!.publisher!),
                headingWidget("Published Date"),
                descriptionWidget(widget.book.volumeInfo!.publishedDate!),
                headingWidget("Category"),
                SizedBox(
                  height: size.height * 0.09,
                  child: ListView(
                    padding: EdgeInsets.all(12),
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        widget.book.volumeInfo!.categories!.length, (index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                            border: Border.all(color: mainColor)),
                        child: Text(
                          widget.book.volumeInfo!.categories![index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                headingWidget("Page Count"),
                descriptionWidget(
                    widget.book.volumeInfo!.pageCount!.toString()),
                headingWidget("Language"),
                descriptionWidget(widget.book.volumeInfo!.language!),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Widgets.buildButton(
            text: "Get Book", onTap: () {}, context: context),
      ),
    );
  }

  Widget headingWidget(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Container(
        height: 30,
        color: Color.fromARGB(255, 223, 131, 240),
        alignment: Alignment.center,
        width: double.infinity,
        child: Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget descriptionWidget(String title) {
    return Text(title);
  }

  Widget webvi2(String selectedUrl) {
// ignore: prefer_collection_literals

    return WebviewScaffold(
      url: selectedUrl,
      //  javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text('Widget WebView'),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      // initialChild: Container(
      //   child: const Center(
      //     child: Text('Waiting.....'),
      //   ),
      // )
    );
  }
}
