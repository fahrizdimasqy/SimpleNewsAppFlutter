import 'package:flutter/material.dart';
import 'news.dart';
// import 'package:toast/toast.dart';

class DetailScreen extends StatelessWidget {
  int count = 0;
  List data;
  int index;
  final String news;
  DetailScreen({@required this.data, this.index, this.news});
  int _currenttab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black26,
                  ),
                  height: 400,
                  child: Image.network(
                    data[index]['urlToImage'],
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(top: 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          data[index]['title'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16.0,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              data[index]['author'],
                            ),
                          ),
                          Spacer(),
                          FavoriteButton()
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(32.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            color: Colors.blue,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.blue,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.blue,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.blue,
                                          ),
                                          Icon(
                                            Icons.star_border,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      data[index]['publishedAt'],
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              'Description'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              data[index]['description'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: double.infinity,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    //   Toast.show("Booking Success", context,
                                    //       duration: Toast.LENGTH_SHORT,
                                    //       backgroundColor: Colors.greenAccent,
                                    //       gravity: Toast.BOTTOM);
                                  },
                                  child: Text('Read More'),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 32.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: AppBar(
                    title: Text(
                      'Detail',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currenttab,
        backgroundColor: Colors.white,
        elevation: 0,
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
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundImage: AssetImage('images/fahriz.png'),
            ),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.star : Icons.star_border,
        color: Colors.blue,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}
