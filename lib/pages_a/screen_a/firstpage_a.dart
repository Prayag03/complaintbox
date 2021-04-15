import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaintbox/pages_a/screen_a/AHome.dart';
import 'package:complaintbox/pages_a/screen_a/profile.dart';
import 'package:complaintbox/pages_a/screen_a/status.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Screen_aw1 extends StatefulWidget {
  final String category;

  const Screen_aw1({Key key, this.category}) : super(key: key);

  @override
  _Screen_aw1State createState() => _Screen_aw1State(category);
}

// ignore: camel_case_types
class _Screen_aw1State extends State<Screen_aw1> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  final String category;
  _Screen_aw1State(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          AHome(category: category),
          AStatus(category: category),
          // Report(),
          // SearchBarDemoHome(category: category),
          AProfile(category: category),
        ],
        onPageChanged: (pageIndex) {
          setState(() {
            currentIndex = pageIndex;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        curve: Curves.easeInCubic,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.add_box),
            title: Text("complaint"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.timer),
            title: Text("status"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_box),
            title: Text("profile"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
