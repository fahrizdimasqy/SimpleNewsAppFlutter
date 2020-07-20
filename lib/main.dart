import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/detail_screen.dart';
import 'news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  int _currenttab = 0;
  final String url =
      'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d04170c862564246a9865ac63f2cd6ff';
  List data;
  List filteredNews;
  _HomePageState({this.data, this.filteredNews});

  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['articles'];
      filteredNews = content['articles'];
      // filteredNews = data;
    });
    return 'success!';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Fahriz Dimasqy',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Find News',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 30),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          BoxShadow(
                              color: Colors.white,
                              spreadRadius: -7.0,
                              blurRadius: 5)
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search News',
                          icon: Icon(Icons.search, color: Colors.grey[400]),
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (string) {
                          setState(() {
                            filteredNews = data
                                .where((element) => element['title']
                                    .toLowerCase()
                                    .contains(string.toLowerCase()))
                                .toList();
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Container(
                margin: EdgeInsets.only(bottom: 150),
                child: ListView.builder(
                  itemCount: filteredNews == null ? 0 : filteredNews.length,
                  itemBuilder: (BuildContext context, int index) {
                    // data = filteredNews;
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  data: data,
                                  index: index,
                                )));
                      },
                      child: Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: MediaQuery.of(context).size.height / 3,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 7,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        filteredNews[index]['urlToImage']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 16,
                                      top: 16,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 19,
                                            width: 180,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.date_range,
                                                  size: 12,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  filteredNews[index]
                                                      ['publishedAt'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 16,
                                      top: 16,
                                      child: Container(
                                        height: 42,
                                        width: 42,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.stars,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    )),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      top: 20,
                                      child: Container(
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(16),
                                            topLeft: Radius.circular(16),
                                          ),
                                        ),
                                        padding: EdgeInsets.only(left: 16),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              filteredNews[index]['author'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16,
                                      top: 8,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 200,
                                            child: Text(
                                              filteredNews[index]['title'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          // Text(
                                          //   hotel.location,
                                          //   style: TextStyle(
                                          //     color: Colors.blueAccent,
                                          //     fontSize: 12,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currenttab,
        onTap: (int value) {
          setState(() {
            _currenttab = value;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Back'),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
                icon: Icon(
                  Icons.home,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Home'),
          ),
          // BottomNavigationBarItem(
          //   icon: CircleAvatar(
          //     radius: 15.0,
          //     // backgroundImage: AssetImage('images/fahriz.png'),
          //   ),
          //   title: SizedBox.shrink(),
          // )
        ],
      ),
    );
  }
}
