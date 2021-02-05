import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user_feed_page.dart';
import 'messages_page.dart';
import 'notification_page.dart';
import 'search_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Twitter Challenge',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedPageIndex = 0;

  var pages = [
    UserFeedPage(),
    SearchPage(),
    NotificationPage(),
    MessagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.home,
              color: selectedPageIndex == 0 ? Colors.blue : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.search,
              color: selectedPageIndex == 1 ? Colors.blue : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.bell,
              color: selectedPageIndex == 2 ? Colors.blue : Colors.blueGrey,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.envelope,
              color: selectedPageIndex == 3 ? Colors.blue : Colors.blueGrey,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
        currentIndex: selectedPageIndex,
      ),
    );
  }
}
