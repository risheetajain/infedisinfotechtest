import 'package:flutter/material.dart';
import 'package:infedisinfotechtest/constant/route.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List myGrid = [
    {
      "title": "Book",
      "image": "assets/books.jfif",
      "route": bookRoute,
      "count": 10
    },
    {
      "title": "Articles",
      "image": "assets/news.jfif",
      "route": articleRoute,
      "count": 100
    }
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('HIDOC Technology Pvt. Ltd.'),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, myGrid[index]["route"]);
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                height: size.height * 0.2,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18),
                alignment: index % 2 == 1
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(
                          myGrid[index]["image"],
                        ),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      myGrid[index]["title"],
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    Text(myGrid[index]["count"].toString(),
                        style: TextStyle(fontSize: 24, color: Colors.white))
                  ],
                ),
              ),
            );
          },
          itemCount: myGrid.length,
        ),
      ),
    );
  }
}
