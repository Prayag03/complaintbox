import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaintbox/controllers/authentication.dart';
import 'package:complaintbox/pages/login/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  final FirebaseUser user;

  const Profile({Key key, this.user}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState(user);
}

class _ProfileState extends State<Profile> {
  final FirebaseUser user;
  String uid;
  _ProfileState(this.user);
  bool _status = true;
  final db = Firestore.instance;
  Map<String, dynamic> data2;
  Future<DocumentSnapshot> document;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();
  TextEditingController fnc = TextEditingController();
  TextEditingController lnc = TextEditingController();
  TextEditingController ec = TextEditingController();
  TextEditingController mc = TextEditingController();
  TextEditingController wc = TextEditingController();
  TextEditingController ac = TextEditingController();

  Future<void> getdata() async {
    document = Firestore.instance.collection('users').document(user.uid).get();
    document.then<dynamic>((DocumentSnapshot snapshot) async {
      if (mounted) {
        setState(() {
          fnc.text = snapshot.data["first_name"];
          lnc.text = snapshot.data["last_name"];
          ec.text = user.email;
          mc.text = snapshot.data["mobile_no"];
          wc.text = snapshot.data["ward_no"];
          ac.text = snapshot.data["address"];
        });
      }
    });
    return;
  }

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
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Profile",
                style: TextStyle(
                  color: Colors.white,
                )),
            centerTitle: true,
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false,
            leading: Tooltip(
              message: 'log out',
              textStyle: TextStyle(fontSize: 15, color: Colors.white),
              child: new IconButton(
                icon: new Icon(Icons.exit_to_app, color: Colors.white),
                onPressed: () {
                  signOutUser();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 25.0, top: 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Text(
                              'Parsonal Information',
                              style: TextStyle(
                                  fontSize: 27.0,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formkey,
                    autovalidate: true,
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
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'First Name',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          controller: fnc,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your First Name",
                                          ),
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.raleway(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                // ignore: deprecated_member_use
                                                .display2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            // fontStyle: FontStyle.italic,
                                            color: Colors.grey[800],
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Last Name',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          controller: lnc,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Last Name",
                                          ),
                                          keyboardType: TextInputType.name,
                                          style: GoogleFonts.raleway(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                // ignore: deprecated_member_use
                                                .display2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            //fontStyle: FontStyle.italic,
                                            color: Colors.grey[800],
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ID',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          controller: ec,
                                          decoration: const InputDecoration(
                                            hintText: "Email Id",
                                          ),
                                          style: GoogleFonts.raleway(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                // ignore: deprecated_member_use
                                                .display2,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey[800],
                                          ),
                                          enabled: false,
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Mobile Number',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 0.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: mc,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your mobile number",
                                        ),
                                        keyboardType: TextInputType.phone,
                                        style: GoogleFonts.raleway(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .display2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          //fontStyle: FontStyle.italic,
                                          color: Colors.grey[800],
                                        ),
                                        enabled: !_status,
                                        autofocus: !_status,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  " This Field Is Required"),
                                          MinLengthValidator(10,
                                              errorText: ' 10 Digits Required'),
                                          MaxLengthValidator(10,
                                              errorText: ' Only 10 Digits')
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Ward no.',
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.blue[500],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 0.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextFormField(
                                        controller: wc,
                                        decoration: const InputDecoration(
                                          hintText: "Enter Your ward number",
                                        ),
                                        keyboardType: TextInputType.number,
                                        style: GoogleFonts.raleway(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              // ignore: deprecated_member_use
                                              .display2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          // fontStyle: FontStyle.italic,
                                          color: Colors.grey[800],
                                        ),
                                        enabled: !_status,
                                        autofocus: !_status,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  " This Field Is Required"),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 10.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Address',
                                            style: TextStyle(
                                                fontSize: 25.0,
                                                color: Colors.blue[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0, right: 20.0, top: 0.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: new TextFormField(
                                          maxLines: null,
                                          controller: ac,
                                          decoration: const InputDecoration(
                                            hintText: "Enter Your Address",
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          style: GoogleFonts.raleway(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                // ignore: deprecated_member_use
                                                .display2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            //fontStyle: FontStyle.italic,
                                            color: Colors.grey[800],
                                          ),
                                          enabled: !_status,
                                          autofocus: !_status,
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText:
                                                    " This Field Is Required"),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
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
                    elevation: 15,
                    //splashColor: Colors.blue,
                    child: new Text(
                      "Save",
                      style: TextStyle(fontSize: 20),
                    ),
                    textColor: Colors.white,
                    color: Colors.blue[500],
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        setState(() {
                          _status = true;
                        });
                        db.collection('users').document(user.uid).updateData({
                          'first_name': fnc.text,
                          'last_name': lnc.text,
                          'ward_no': wc.text,
                          'mobile_no': mc.text,
                          'address': ac.text,
                        });
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
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
