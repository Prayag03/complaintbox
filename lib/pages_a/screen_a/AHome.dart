import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaintbox/pages_a/screen_a/complaintdetails.dart';
import 'package:flutter/material.dart';

class AHome extends StatefulWidget {
  final String category;

  const AHome({Key key, this.category}) : super(key: key);
  @override
  _AHomeState createState() => _AHomeState(category);
}

class _AHomeState extends State<AHome> {
  QuerySnapshot result;
  bool isLoading = false;

  final db = Firestore.instance;
  List<Map<String, dynamic>> complaints;
  final String category;
  _AHomeState(this.category);

  Future comlist() async {
    complaints = new List<HashMap<String, dynamic>>();
    setState(() {
      isLoading = true;
    });
    result = await db.collection('users').getDocuments();
    result.documents.forEach((ele) {
      for (int i = 0; i < ele.data['complaints'].length; i++) {
        if (ele.data['complaints'][i]['category'] == category) {
          Map<String, dynamic> tmp = HashMap<String, dynamic>();
          tmp['complaint_number'] =
              ele.data['complaints'][i]['complaint_number'];
          tmp['date'] = ele.data['complaints'][i]['date'];
          tmp['due_date'] = ele.data['complaints'][i]['due_date'];
          tmp['description'] = ele.data['complaints'][i]['description'];
          tmp['location'] = ele.data['complaints'][i]['location'];
          tmp['landmark'] = ele.data['complaints'][i]['landmark'];
          tmp['imageUrl1'] = ele.data['complaints'][i]['imageUrl1'];
          tmp['imageUrl2'] = ele.data['complaints'][i]['imageUrl2'];
          tmp['time'] = ele.data['complaints'][i]['time'];
          tmp['category'] = ele.data['complaints'][i]['category'];
          tmp['status'] = ele.data['complaints'][i]['status'];
          tmp['employee_cno'] = ele.data['complaints'][i]['employee_cno'];
          tmp['employee_name'] = ele.data['complaints'][i]['employee_name'];
          tmp['employee_designation'] =
              ele.data["complaints"][i]['employee_designation'];
          complaints.add(tmp);
        }
      }
    });
    setState(() {
      isLoading = false;
    });
    //print(isLoading);
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    comlist();
  }

  @override
  // ignore: must_call_super
  void didChangeDependencies() {}

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return comlist();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Complaints",
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          actions: [
            Tooltip(
              message: 'sort all complaints',
              textStyle: TextStyle(fontSize: 15, color: Colors.white),
              child: new IconButton(
                icon: new Icon(Icons.sort, color: Colors.white),
                onPressed: () {
                  setState(() {
                    complaints = complaints.reversed.toList();
                  });
                },
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(

                // physics: const AlwaysScrollableScrollPhysics(),
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  return (InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComplaintDetails(
                              data: complaints[index],
                            ),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7, 10, 7, 7),
                      child: Container(
                        width: double.infinity,
                        decoration: new BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Material(
                          elevation: 20,
                          borderRadius: BorderRadius.circular(0),
                          shadowColor: Colors.blue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      ' ' + complaints[index]['date'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 25),
                                    ),
                                    Text(
                                      complaints[index]['time'] + ' ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 25),
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    ' Complaint number:' +
                                        ' ${complaints[index]['complaint_number']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*  child: Card(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              border: Border.all(
                                width: 0.9,
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        ' ' + complaints[index]['date'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        complaints[index]['time'] + ' ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                            fontSize: 25),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      ' Complaint number:' +
                                          ' ${complaints[index]['complaint_number']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                          fontSize: 25),
                                    ),
                                    /*  Text(
                                  complaints[index]['type'] + '     ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 25),
                                ), */
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ), */
                  ));
                }),

        /* FutureBuilder(
            future: comlist(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return (InkWell(
                  onTap: () {
                    /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StatusDetails(),
                    )); */
                  },
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        //color: Colors.blue[100],
                        border: Border.all(
                          width: 0.9,
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          /* Text(
                            ' ${snapshot.data[0]['type']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 25),
                          ),  */
                          Text(
                            snapshot.data['type'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
              } else {
                Center(
                    child: Column(children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Awaiting result...',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25.0,
                      ),
                    ),
                  )
                ]));
              }
            }), */
      ),
    );
  }
}
