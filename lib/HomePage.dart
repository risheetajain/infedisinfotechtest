import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:infedisinfotechtest/api/ApiServices.dart';
import 'package:infedisinfotechtest/modals/articles.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constant/color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiProvider = ApiServices();
  var isLoading = false;
  List<Articles>? list = [];
  @override
  void initState() {
    _loadFromApi();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infedis Infotech'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : list == null || list!.isEmpty
              ? Center(child: CircularProgressIndicator())
              : _buildEmployeeListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });
    apiProvider.getList().then((value) {
      setState(() {
        isLoading = false;
      });
      list = value;
    });

    // wait for 2 seconds to simulate loading of data
  }

  _buildEmployeeListView() {
    return ListView.builder(
      itemCount: list!.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: InkWell(
            onTap: () {
              webvi2(list![index].url.toString());
            },
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: mainColor,
                      width: 1,
                    )),
                margin: EdgeInsets.all(5),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list![index].title.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(list![index].description.toString()),
                      Text("Author: " + list![index].author.toString()),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
  // }

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
