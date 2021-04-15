import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'complaint.dart';

class Selection extends StatefulWidget {
  final FirebaseUser user;

  const Selection({Key key, this.user}) : super(key: key);

  @override
  _SelectionState createState() => _SelectionState(user);
}

class _SelectionState extends State<Selection> {
  final FirebaseUser user;
  String uid;
  _SelectionState(this.user);
  String category;
  List<String> entries = <String>[
    'Water Supply',
    'Electricity',
    'Roads and Footpath',
    'Garbage and Cleanliness',
    'Drainage and Storm Drain',
    'Complaints againts SMC Staff',
    'Public Toilet',
    'Hospitals and Dispensaries',
    ' Stray and Dead Animals',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Category",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterComplaint(
                          uid: user.uid,
                          category: '${entries[index]}'.toLowerCase()),
                    ));
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                /* child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: BorderSide(
                      color: Colors.blue.withOpacity(0.2),
                      width: 1,
                    ),
                  ), */
                child: Container(
                  width: 300,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(
                      width: 0.5,
                      color: Colors.blue[100],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Material(
                    elevation: 15,
                    borderRadius: BorderRadius.circular(40),
                    shadowColor: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${entries[index]}" /* Complaints */,
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                // ),
              ),
            );
          }),
    );
  }
}
