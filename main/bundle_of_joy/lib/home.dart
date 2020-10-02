import 'package:bundle_of_joy/mother-for-baby.dart';
import 'package:bundle_of_joy/mother-to-be.dart';
import "package:flutter/material.dart";
import "profile.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageState(),
    );
  }
}

class HomePageState extends StatefulWidget {
  final String title;
  HomePageState({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  int _selectedIndex = 0;
  String _title = "Test";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    MotherToBeTab(),
    MotherForBabyTab(),
    Text(
      "Notification",
      style: optionStyle,
    ),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _title = "Mother-to-be";
          }
          break;
        case 1:
          {
            _title = "Mother-for-baby";
          }
          break;
        case 2:
          {
            _title = "Notification";
          }
          break;
        case 3:
          {
            _title = "Profile";
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFCFFD5),
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Mother-to-be"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text("Mother-for-baby"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text("Profile"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
