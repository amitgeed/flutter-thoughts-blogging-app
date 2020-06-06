import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twbh/screens/home_screen.dart';
import 'package:twbh/screens/post_screen.dart';
import 'package:twbh/screens/profile_screen.dart';
import 'package:twbh/screens/setting_screen.dart';

class MyBottomNavbar extends StatefulWidget {
  static const String id = 'my_bottom_navbar';
  @override
  _MyBottomNavbarState createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    PostScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return SafeArea(
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.black.withOpacity(0.9),
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.deepOrange.withOpacity(0.5),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          // elevation: 10.0,
          onTap: onTappedBar,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Posts'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
