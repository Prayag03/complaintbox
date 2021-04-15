import 'package:complaintbox/pages/screen/profile.dart';
import 'package:complaintbox/pages/screen/selection2.dart';
import 'package:complaintbox/pages/screen/status.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  final FirebaseUser user;

  const UserHome({Key key, this.user}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState(user);
}

class _UserHomeState extends State<UserHome> {
  final FirebaseUser user;
  _UserHomeState(this.user);
  final PageController _pageController = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Selection(user: user),
          Status(user: user),
          Profile(user: user),
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
