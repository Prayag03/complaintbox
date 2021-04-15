import 'package:complaintbox/pages/login/loginScreen.dart';
import 'package:complaintbox/pages/screen/selection.dart';
import 'package:complaintbox/pages_a/screen_a/firstpage_a.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String boxname = '';

Future<void> main() async {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      /*  darkTheme: ThemeData.dark().copyWith(
         textTheme: GoogleFonts.darkerGrotesqueTextTheme(
          Theme.of(context).textTheme,
        ), 
      ), */
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  final String uid;

  const Homepage({Key key, this.uid}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState(uid);
}

class _HomepageState extends State<Homepage> {
  final String uid;
  _HomepageState(this.uid);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          if (user.email == "waterdepartment@gmail.com") {
            return Screen_aw1(category: "water supply");
          } else if (user.email == "electricitydepartment@gmail.com") {
            return Screen_aw1(category: "electeicity");
          } else if (user.email == "roaddepartment@gmail.com") {
            return Screen_aw1(category: 'roads and footpath');
          } else if (user.email == "garbagedepartment@gmail.com") {
            return Screen_aw1(category: 'grabage and cleanliness');
          } else if (user.email == "drainagedepartment@gmail.com") {
            return Screen_aw1(category: 'drainage and storm drain');
          } else if (user.email == "smcstaffcomdepartment@gmail.com") {
            return Screen_aw1(category: 'complaints againts smc staff');
          } else if (user.email == "toiletdepartment@gmail.com") {
            return Screen_aw1(category: 'public toilet');
          } else if (user.email == "hospitaldepartment@gmail.com") {
            return Screen_aw1(category: "hospitals and dispensaries");
          } else if (user.email == "animaldepartment@gmail.com") {
            return Screen_aw1(category: "stray and dead animals");
          } else if (user.email == "othercomdepartment@gmail.com") {
            return Screen_aw1(category: "others");
          } else {
            return UserHome(user: user);
          }
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
