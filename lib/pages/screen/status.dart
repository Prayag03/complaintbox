import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaintbox/pages/screen/statusdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  final FirebaseUser user;

  const Status({Key key, this.user}) : super(key: key);
  @override
  _StatusState createState() => _StatusState(user);
}

class _StatusState extends State<Status> {
  final FirebaseUser user;
  String uid;
  _StatusState(this.user);

  List<Map<String, dynamic>> data2 = new List<Map<String, dynamic>>();
  List<DocumentSnapshot> documents;

  Future<void> getdata() async {
    final Future<DocumentSnapshot> document =
        Firestore.instance.collection('users').document(user.uid).get();
    document.then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data2 = List.from(snapshot.data['complaints']);
        data2 = data2.reversed.toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return getdata();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("status",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: [
            Tooltip(
              message: 'sort by decresing date',
              textStyle: TextStyle(fontSize: 15, color: Colors.white),
              child: new IconButton(
                icon: new Icon(Icons.sort, color: Colors.white),
                onPressed: () {
                  setState(() {
                    data2 = data2.reversed.toList();
                  });
                },
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          itemCount: data2.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusDetails(data: data2[index]),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 7, 7),
                //child: Card(
                child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    border: Border.all(
                      width: 0.3,
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Material(
                    elevation: 20,
                    borderRadius: BorderRadius.circular(15),
                    shadowColor: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '  Complaint Number',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Date            ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '           ' +
                                  '${data2[index]['complaint_number']}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 25),
                            ),
                            Text(
                              data2[index]['date'] + '      ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 25),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '  Status: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 25),
                            ),
                            data2[index]["status"] == ""
                                ? Text(
                                    'not updoaded',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.0,
                                    ),
                                  )
                                : Text(
                                    data2[index]['status'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.0,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
