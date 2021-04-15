//import 'dart:collection';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusDetailsA extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  const StatusDetailsA({Key key, this.data, this.index}) : super(key: key);
  @override
  _StatusDetailsAState createState() => _StatusDetailsAState(data, index);
}

class _StatusDetailsAState extends State<StatusDetailsA> {
  final Map<String, dynamic> data;
  final int index;
  _StatusDetailsAState(this.data, this.index);

  bool _status = true;
  bool isUpdate = false;
  QuerySnapshot result;
  DocumentSnapshot result2;
  final db = Firestore.instance;
  var t1, t2;
  String value = "";

  final FocusNode myFocusNode = FocusNode();
  TextEditingController enc = TextEditingController();
  TextEditingController emc = TextEditingController();
  TextEditingController csc = TextEditingController();
  TextEditingController edc = TextEditingController();
  TextEditingController cdc = TextEditingController();

  //TextEditingController ac = TextEditingController();

  Future<void> getdata() async {
    setState(() {
      enc.text = data["employee_name"];
      emc.text = data["employee_cno"];
      edc.text = data['employee_designation'];
      csc.text = data["status"];
      cdc.text = data["due_date"];

      //ac.text = data["Add_comment"];
    });

    return;
  }

  void initState() {
    super.initState();
    getdata();
    isUpdate = false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return getdata();
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Complaint Status",
                style: TextStyle(
                  color: Colors.white,
                )),
            centerTitle: true,
            backgroundColor: Colors.blue,
            //automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 25.0, top: 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Complaint Assignment Details',
                              style: TextStyle(
                                  fontSize: 23.0,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _status ? _getEditIcon() : new Container(),
                          ],
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Container(
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      //color: Colors.blue[100],
                      border: Border.all(
                        width: 0.5,
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(10),
                      shadowColor: Colors.blue,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("  Employee Details ",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  //color: Colors.blue[100],
                                  border: Border.all(
                                    width: 0.3,
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(0),
                                  shadowColor: Colors.blue,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    ' Name',
                                                    style: TextStyle(
                                                      fontSize: 23.0,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                  child: new TextField(
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: null,
                                                    controller: enc,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Employee Name",
                                                    ),
                                                    style: GoogleFonts.raleway(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          // ignore: deprecated_member_use
                                                          .display2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //fontStyle: FontStyle.italic,
                                                      color: Colors.grey[800],
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    ' Designation',
                                                    style: TextStyle(
                                                      fontSize: 23.0,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                  child: new TextField(
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: null,
                                                    controller: edc,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Employee Designation",
                                                    ),
                                                    style: GoogleFonts.raleway(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          // ignore: deprecated_member_use
                                                          .display2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //fontStyle: FontStyle.italic,
                                                      color: Colors.grey[800],
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    ' Contect Number',
                                                    style: TextStyle(
                                                      fontSize: 23.0,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                              top: 2.0,
                                              bottom: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                  child: new TextField(
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    maxLines: null,
                                                    controller: emc,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Employee Contect No.",
                                                    ),
                                                    style: GoogleFonts.raleway(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          // ignore: deprecated_member_use
                                                          .display2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //fontStyle: FontStyle.italic,
                                                      color: Colors.grey[800],
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Text("  Complaint Status ",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                  //color: Colors.blue[100],
                                  border: Border.all(
                                    width: 0.3,
                                    color: Colors.blue,
                                  ),
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(0),
                                  shadowColor: Colors.blue,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 5.0, top: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  DropdownButton(
                                                      items: [
                                                        DropdownMenuItem(
                                                            value: "Pending",
                                                            child: Center(
                                                              child: Text(
                                                                "Pending",
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      // ignore: deprecated_member_use
                                                                      .display2,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  //fontStyle: FontStyle.italic,
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                ),
                                                              ),
                                                            )),
                                                        DropdownMenuItem(
                                                            value:
                                                                "Work in Progress",
                                                            child: Center(
                                                              child: Text(
                                                                "Work in Progress",
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      // ignore: deprecated_member_use
                                                                      .display2,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  //fontStyle: FontStyle.italic,
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                ),
                                                              ),
                                                            )),
                                                        DropdownMenuItem(
                                                            value: "completed",
                                                            child: Center(
                                                              child: Text(
                                                                "completed",
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      // ignore: deprecated_member_use
                                                                      .display2,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  //fontStyle: FontStyle.italic,
                                                                  color: Colors
                                                                          .grey[
                                                                      600],
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                      onChanged: (_value) {
                                                        setState(() {
                                                          csc.text = _value;
                                                        });
                                                      },
                                                      hint: Text(
                                                        "Select Complaint Status   ",
                                                        style:
                                                            GoogleFonts.raleway(
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              // ignore: deprecated_member_use
                                                              .display2,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          //fontStyle: FontStyle.italic,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                      )),
                                                  // enabled: !_status,
                                                  // autofocus: !_status,
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                  child: new TextField(
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: null,
                                                    controller: csc,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Complaint Status",
                                                    ),
                                                    style: GoogleFonts.raleway(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          // ignore: deprecated_member_use
                                                          .display2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //fontStyle: FontStyle.italic,
                                                      color: Colors.grey[800],
                                                    ),
                                                    enabled: false,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  new Text(
                                                    ' Due Date',
                                                    style: TextStyle(
                                                      fontSize: 23.0,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                              top: 2.0,
                                              bottom: 5.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                  child: new TextField(
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    maxLines: null,
                                                    controller: cdc,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          "Enter Due Date",
                                                    ),
                                                    style: GoogleFonts.raleway(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          // ignore: deprecated_member_use
                                                          .display2,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      //fontStyle: FontStyle.italic,
                                                      color: Colors.grey[800],
                                                    ),
                                                    enabled: !_status,
                                                    autofocus: !_status,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5.0, top: 2.0),
                                          child: new Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              new Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  height: 40,
                  child: new RaisedButton(
                    child: new Text(
                      "Save",
                      style: TextStyle(fontSize: 20),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue[500],
                    onPressed: () async {
                      setState(() {
                        _status = true;
                      });

                      data['employee_designation'] = edc.text;
                      data['employee_name'] = enc.text;
                      data['employee_cno'] = emc.text;
                      data['status'] = csc.text;
                      data['due_date'] = cdc.text;

                      List<Map<String, dynamic>> complaints;

                      result = await db.collection('users').getDocuments();
                      result.documents.forEach((ele) {
                        if (ele.data['uid'] == data['uid']) {
                          complaints = new List<HashMap<String, dynamic>>();

                          for (int i = 0;
                              i < ele.data['complaints'].length;
                              i++) {
                            Map<String, dynamic> tmp =
                                HashMap<String, dynamic>();

                            tmp['complaint_number'] =
                                ele.data['complaints'][i]['complaint_number'];
                            tmp['date'] = ele.data['complaints'][i]['date'];
                            tmp['time'] = ele.data['complaints'][i]['time'];
                            tmp['landmark'] =
                                ele.data['complaints'][i]['landmark'];
                            tmp['gps_location'] =
                                ele.data['complaints'][i]['gps_location'];
                            tmp['due_date'] =
                                ele.data['complaints'][i]['due_date'];

                            tmp['description'] =
                                ele.data['complaints'][i]['description'];
                            tmp['location'] =
                                ele.data['complaints'][i]['location'];
                            tmp['imageUrl1'] =
                                ele.data['complaints'][i]['imageUrl1'];
                            tmp['imageUrl2'] =
                                ele.data['complaints'][i]['imageUrl2'];

                            tmp['category'] =
                                ele.data['complaints'][i]['category'];
                            tmp['status'] = ele.data['complaints'][i]['status'];
                            tmp['employee_name'] =
                                ele.data['complaints'][i]['employee_name'];
                            tmp['employee_cno'] =
                                ele.data['complaints'][i]['employee_cno'];
                            tmp['employee_designation'] = ele.data['complaints']
                                [i]['employee_designation'];
                            tmp['uid'] = ele.data['complaints'][i]['uid'];
                            tmp['user_id'] = ele.documentID;
                            //tmp['complaint_index'] = i;
                            tmp['index'] = ele.data['complaints'][i]['index'];
                            if (i == data['index']) {
                              tmp['employee_designation'] = edc.text;
                              tmp['employee_name'] = enc.text;
                              tmp['employee_cno'] = emc.text;
                              tmp['status'] = csc.text;
                              tmp['due_date'] = cdc.text;
                            }
                            complaints.add(tmp);
                          }
                        }
                      });

                      db
                          .collection('users')
                          .document(data["user_id"])
                          .updateData({
                        'complaints': complaints,
                      });

                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return Tooltip(
      message: 'edit details',
      textStyle: TextStyle(fontSize: 15, color: Colors.white),
      child: new GestureDetector(
          child: new CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 14.0,
            child: new Icon(
              Icons.edit,
              color: Colors.white,
              size: 16.0,
            ),
          ),
          onTap: () {
            setState(() {
              _status = false;
            });
          }),
    );
  }
}
