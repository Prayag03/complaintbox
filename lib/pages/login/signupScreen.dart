import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaintbox/controllers/authentication.dart';
import 'package:complaintbox/main.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email;
  String password;
  // ignore: non_constant_identifier_names
  String f_name;
  // ignore: non_constant_identifier_names
  String l_name;

  final db = Firestore.instance;
  List<Map<String, dynamic>> data2 = new List<Map<String, dynamic>>();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((user) async {
        if (user != null) {
          db.collection('users').document(user.uid).setData({
            'complaints': data2,
            'first_name': f_name,
            'last_name': l_name,
            'mobile_no': "",
            'ward_no': "",
            'address': "",
            'uid': user.uid
          });

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(uid: user.uid),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //FlutterLogo(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Signup Here as user",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "First Name"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This Field Is Required."),
                          ]),
                          onChanged: (val) {
                            f_name = val;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "last Name"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This Field Is Required."),
                          ]),
                          onChanged: (val) {
                            l_name = val;
                          },
                        ),
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This Field Is Required."),
                            MinLengthValidator(6,
                                errorText: "Minimum 6 Characters Required.")
                          ]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        onPressed: handleSignup,
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Have an Account?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
