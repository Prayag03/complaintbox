import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaintbox/pages_a/screen_a/statusdetailsA.dart';
import 'package:flutter/material.dart';

class AStatus extends StatefulWidget {
  final String category;

  const AStatus({Key key, this.category}) : super(key: key);
  @override
  _AStatusState createState() => _AStatusState(category);
}

class _AStatusState extends State<AStatus> {
  QuerySnapshot result;
  final db = Firestore.instance;
  bool isLoading = false;

  List<Map<String, dynamic>> complaints;
  final String category;
  _AStatusState(this.category);

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
          tmp['description'] = ele.data['complaints'][i]['description'];
          tmp['location'] = ele.data['complaints'][i]['location'];
          tmp['landmark'] = ele.data['complaints'][i]['landmark'];
          tmp['imageUrl1'] = ele.data['complaints'][i]['imageUrl1'];
          tmp['imageUrl2'] = ele.data['complaints'][i]['imageUrl2'];
          tmp['time'] = ele.data['complaints'][i]['time'];
          tmp['due_date'] = ele.data['complaints'][i]['due_date'];
          tmp['category'] = ele.data['complaints'][i]['category'];
          tmp['status'] = ele.data['complaints'][i]['status'];
          tmp['employee_name'] = ele.data['complaints'][i]['employee_name'];
          tmp['employee_cno'] = ele.data['complaints'][i]['employee_cno'];
          tmp['employee_designation'] =
              ele.data['complaints'][i]['employee_designation'];
          tmp['uid'] = ele.data['complaints'][i]['uid'];
          tmp['user_id'] = ele.documentID;
          tmp['index'] = ele.data['complaints'][i]['index'];
          complaints.add(tmp);
        }
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    comlist();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return comlist();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("status",
              style: TextStyle(
                color: Colors.white,
              )),
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
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatusDetailsA(
                                data: complaints[index], index: index),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7, 10, 7, 7),
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
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '           ' +
                                        '${complaints[index]['complaint_number']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    complaints[index]['date'] + '      ',
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
                                  complaints[index]["status"] == ""
                                      ? Text(
                                          'not updoaded',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.0,
                                          ),
                                        )
                                      : Text(
                                          complaints[index]['status'],
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
