import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infedisinfotechtest/api/ApiServices.dart';
import 'package:infedisinfotechtest/book_details.dart';
import 'package:infedisinfotechtest/modals/book_modal.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constant/color.dart';

class GetBooks extends StatefulWidget {
  @override
  _GetBooksState createState() => _GetBooksState();
}

class _GetBooksState extends State<GetBooks> {
  ApiServices apiProvider = ApiServices();
  var isLoading = false;
  List<BookModel>? list = [];
  @override
  void initState() {
    _loadFromApi("cancer");
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infedis Infotech'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _loadFromApi(value);
                });
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : list != null && list!.isNotEmpty
              ? _buildEmployeeListView()
              : Center(child: Text('No Data Found')),
    );
  }

  _loadFromApi(String query) async {
    setState(() {
      isLoading = true;
    });
    list = await apiProvider.getBooks(query);

    // wait for 2 seconds to simulate loading of data

    setState(() {
      isLoading = false;
    });
  }

  _buildEmployeeListView() {
    return ListView.builder(
      itemCount: list!.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsScreen(
                  book: list![index],
                ),
              ),
            );
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: mainColor,
                    width: 1,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1.0,
                        offset: Offset(0, 0),
                        spreadRadius: 1.0)
                  ],
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      list![index].volumeInfo!.title.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(list![index].volumeInfo!.subtitle ?? ""),
                    Text("Publisher Name:" +
                        list![index].volumeInfo!.publisher.toString()),
                  ],
                ),
              )),
        );
      },
    );
  }
  // }

}
