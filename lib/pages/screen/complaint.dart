import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:geolocator/geolocator.dart';

class WaterComplaint extends StatefulWidget {
  final String uid;
  final String category;

  const WaterComplaint({Key key, this.uid, this.category}) : super(key: key);
  @override
  _WaterComplaintState createState() => _WaterComplaintState(uid, category);
}

class _WaterComplaintState extends State<WaterComplaint> {
  final String uid;
  final String category;
  _WaterComplaintState(this.uid, this.category);

  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();

  TextEditingController dc = TextEditingController();
  TextEditingController lc = TextEditingController();
  TextEditingController lnc = TextEditingController();
  final List<int> inumbers = [1, 2];

  //FocusNode myFocusNodeD = new FocusNode();
  //FocusNode myFocusNodeL = new FocusNode();

  Map<String, dynamic> details = new HashMap();
  List<Map<String, dynamic>> data2 = new List<Map<String, dynamic>>();
  File _image1;
  File _image2;
  String date, time;
  String url1, url2;
  int idl;
  int complaintnumber = 1;
  bool isLoading = false;
  final db = Firestore.instance;
  QuerySnapshot result;
  int realnum = 0;
  int tap = 0;

  Future<void> getdata() async {
    final Future<DocumentSnapshot> document =
        Firestore.instance.collection('users').document(uid).get();
    document.then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data2 = List.from(snapshot.data['complaints']);
      });
    });
  }

  Future getnum() async {
    result = await db.collection('users').getDocuments();
    result.documents.forEach((ele) {
      for (int i = 0; i < ele.data['complaints'].length; i++) {
        if (ele.data['complaints'][i]['complaint_number'] > realnum) {
          realnum = ele.data['complaints'][i]['complaint_number'];
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
    getnum();
  }

  // function for add photo from camera
  Future getImage1() async {
    // ignore: deprecated_member_use
    final Image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image1 = Image;
      tap++;
    });
  }

  Future getImage2() async {
    // ignore: deprecated_member_use
    final Image2 = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image2 = Image2;

      tap++;
    });
  }

  // Function for upload image to firebase
  Future<String> uploadImage() async {
    if (_image2 == null) {
      final StorageReference postImageRef = FirebaseStorage.instance
          .ref()
          .child('gs://complaint-box-f654a.appspot.com/');

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpg").putFile(_image1);

      // ignore: non_constant_identifier_names
      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url1 = ImageUrl.toString();
      saveDetailsToDatabase();
    } else {
      final StorageReference postImageRef = FirebaseStorage.instance
          .ref()
          .child('gs://complaint-box-f654a.appspot.com/');

      var timeKey = new DateTime.now();

      final StorageUploadTask uploadTask =
          postImageRef.child(timeKey.toString() + ".jpg").putFile(_image1);

      // ignore: non_constant_identifier_names
      var ImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url1 = ImageUrl.toString();

      //////////////// for image2_ uploading ///

      var timeKey2 = new DateTime.now();

      final StorageUploadTask uploadTask2 =
          postImageRef.child(timeKey2.toString() + ".jpg").putFile(_image2);

      // ignore: non_constant_identifier_names
      var ImageUrl2 = await (await uploadTask2.onComplete).ref.getDownloadURL();
      url2 = ImageUrl2.toString();
      saveDetailsToDatabase();
    }

    return url1;
  }

  // Function for upload complaint details to firebase
  uploadComplaint() {
    if (formkey1.currentState.validate() && formkey2.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      if (_image1 == null && _image2 == null) {
        saveDetailsToDatabase();
      } else {
        uploadImage();
      }
    }
  }

  void saveDetailsToDatabase() {
    getdata();

    setState(() {
      var dbtimeKey = new DateTime.now();
      var formatDate = new DateFormat('dd/MM/yyyy'); //yMd
      var formatTime = new DateFormat('hh:mm aaa');

      date = formatDate.format(dbtimeKey);
      time = formatTime.format(dbtimeKey);

      //final uid = Provider.of(context).auth.getCurrentUID();
      if (_image1 == null && _image2 == null) {
        details = {
          'uid': uid,
          'index': data2.length,
          "complaint_number": realnum + 1,
          "category": category.trim(),
          "date": date,
          "time": time,
          "description": dc.text,
          "landmark": lnc.text,
          "location": lc.text,
          "imageUrl1": "",
          "imageUrl2": "",
          "employee_designation": "",
          "gps_location": "null",
          "status": "",
          "due_date": "",
          "employee_cno": "",
          "employee_name": "",
        };
      } else if (_image2 == null) {
        details = {
          'uid': uid,
          'index': data2.length,
          "complaint_number": realnum + 1,
          "category": category.trim(),
          "date": date,
          "time": time,
          "description": dc.text,
          "landmark": lnc.text,
          "location": lc.text,
          "imageUrl1": url1,
          "imageUrl2": "",
          "employee_designation": "",
          "gps_location": "null",
          "status": "",
          "due_date": "",
          "employee_cno": "",
          "employee_name": "",
        };
      } else {
        details = {
          'uid': uid,
          'index': data2.length,
          "complaint_number": realnum + 1,
          "category": category.trim(),
          "date": date,
          "time": time,
          "description": dc.text,
          "landmark": lnc.text,
          "location": lc.text,
          "imageUrl1": url1,
          "imageUrl2": url2,
          "employee_designation": "",
          "gps_location": "null",
          "status": "",
          "due_date": "",
          "employee_cno": "",
          "employee_name": "",
        };
      }

      data2.add(details);

      Firestore.instance
          .collection('users')
          .document(uid)
          .updateData({'complaints': data2});
      complaintnumber += 1;

      /* final uid = Provider.of(context).auth.getCurrentUID();*/
      /* CollectionReference collectionReference =
        Firestore.instance.collection('users').document(uid);
        collectionReference.add(details); */

      /* showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
              "Your Colmplaint has Registered. \nComplaint Number: $complaintnumber"),
        ),
      ); */
    });
    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pop();
  }

  /////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Tooltip(
        message: 'add image',
        textStyle: TextStyle(fontSize: 15, color: Colors.white),
        child: new FloatingActionButton(
          onPressed: () {
            if (tap == 0) {
              getImage1();
            } else if (tap == 1) {
              getImage2();
            } else {
              Fluttertoast.showToast(
                msg: "Maximum 2 images are allowed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            }
          },
          child: const Icon(Icons.image),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: new BottomAppBar(
        color: Colors.white,
      ),
      appBar: AppBar(
        title: Text("Add Complaint Information"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text(
                    "       Do not leave this page\nWe are processing your request",
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ))
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("   Complaint Information ",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left),
                        Tooltip(
                          message: 'clear all complaint information',
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[400],
                                  radius: 12.0,
                                  child: new Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    dc.clear();
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formkey1,
                        autovalidate: true,
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
                                      children: <Widget>[
                                        new Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Text(
                                              ' Decribe complaint',
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
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
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                            ),
                                            child: new TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              controller: dc,
                                              decoration: const InputDecoration(
                                                hintText: "Enter description",
                                              ),
                                              style: GoogleFonts.raleway(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    // ignore: deprecated_member_use
                                                    .display2,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                // fontStyle: FontStyle.italic,
                                                color: Colors.grey[800],
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText:
                                                        " This Field Is Required"),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                  child: _image1 == null
                                      ? Container()
                                      : Column(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                    top: 5.0),
                                                child: new Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: <Widget>[
                                                    new Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        new Text(
                                                          ' Image',
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
                                            // SizedBox(height: 5),
                                            Container(
                                              padding: EdgeInsets.all(8),
                                              height: 350,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                        child: _image2 == null
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child:
                                                                    Image.file(
                                                                  _image1,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.91,
                                                                  height: 350,
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Image.file(
                                                                      _image1,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.91,
                                                                      height:
                                                                          350,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Image.file(
                                                                      _image2,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.91,
                                                                      height:
                                                                          350,
                                                                    ),
                                                                  ],
                                                                )));
                                                  }),
                                            ),
                                            /*   Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.file(
                                                _image,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 350,
                                              ),
                                            ), */
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("   Location Information ",
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left),
                        Tooltip(
                          message: 'clear all location information',
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue[400],
                                  radius: 12.0,
                                  child: new Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    lnc.clear();
                                    lc.clear();
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formkey2,
                        autovalidate: true,
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
                                              ' Landmark',
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
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
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                            ),
                                            child: new TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              controller: lnc,
                                              decoration: const InputDecoration(
                                                hintText: "Enter Landmark",
                                              ),
                                              style: GoogleFonts.raleway(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    // ignore: deprecated_member_use
                                                    .display2,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                //fontStyle: FontStyle.italic,
                                                color: Colors.grey[800],
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText:
                                                        " This Field Is Required"),
                                              ]),
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
                                              ' Complaint Location',
                                              style: TextStyle(
                                                fontSize: 23.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w600,
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
                                            padding: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                            ),
                                            child: new TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              controller: lc,
                                              decoration: const InputDecoration(
                                                hintText:
                                                    "Enter Complaint Location",
                                              ),
                                              style: GoogleFonts.raleway(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    // ignore: deprecated_member_use
                                                    .display2,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                //fontStyle: FontStyle.italic,
                                                color: Colors.grey[800],
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText:
                                                        " This Field Is Required"),
                                              ]),
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
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
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
                          shadowColor: Colors.blue[600],
                          child: RaisedButton(
                            // padding: EdgeInsets.all(10),
                            elevation: 20,

                            textColor: Colors.white,
                            color: Colors.blue[400],
                            //splashColor: Colors.cyan,
                            onPressed: () {
                              uploadComplaint();

                              // uploadImage();
                            },
                            child: Text(
                              " Submit Complaint ",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class HorizList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100.0,
      child: new ListView.builder(
        itemBuilder: (context, index) {
          return new Card(
              child: new Container(
            width: 80.0,
            child: new Text('Hello'),
            alignment: Alignment.center,
          ));
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

/* Container(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: TextFormField(
                          focusNode: myFocusNodeD,
                          controller: dc,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Describe Complaint",
                            labelStyle: TextStyle(
                                color: myFocusNodeD.hasFocus
                                    ? Colors.blue
                                    : Colors.blue),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.lightBlue)),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This Field Is Required"),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                        child: TextFormField(
                          focusNode: myFocusNodeL,
                          //controller: controllerforlocation,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Location",
                            labelStyle: TextStyle(
                                color: myFocusNodeL.hasFocus
                                    ? Colors.blue
                                    : Colors.blue),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This Field Is Required"),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ), */
/*               Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: FlatButton(
                  padding: EdgeInsets.all(10),
                  textColor: Colors.blue,
                  color: Colors.blue[100],
                  splashColor: Colors.cyan,
                  onPressed: () {},
                  child: Text(
                    "verify Location through GPS",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ), */
////////////////////////////////////////////////////////////////////////////////////////

/* Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 5.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        ' ward number',
                                        style: TextStyle(
                                          fontSize: 23.0,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 2.0, bottom: 5.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextFormField(
                                      controller: lc,
                                      decoration: const InputDecoration(
                                        hintText: " Enter word number",
                                      ),
                                      style: GoogleFonts.raleway(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            // ignore: deprecated_member_use
                                            .display2,

                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        // fontStyle: FontStyle.italic,
                                        color: Colors.grey[800],
                                      ),
                                      validator: MultiValidator([
                                        RequiredValidator(
                                            errorText:
                                                " This Field Is Required"),
                                      ]),
                                    ),
                                  ),
                                ],
                              )),
 */
