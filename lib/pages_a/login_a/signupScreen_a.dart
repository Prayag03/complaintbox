/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaintbox/controllers/authentication_a.dart';
import 'package:complaintbox/main.dart';
//import 'package:complaintbox/home_a.dart';
import 'package:complaintbox/pages/login/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'loginScreen_a.dart';

class SignUpScreen_a extends StatefulWidget {
  @override
  _SignUpScreen_aState createState() => _SignUpScreen_aState();
}

class _SignUpScreen_aState extends State<SignUpScreen_a> {
  String email;
  String password;
  String name;
  final db = Firestore.instance;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void handleSignup() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signUp(email.trim(), password, context).then((user) async {
        if (user != null) {
          db.collection('admin').document(user.uid).setData({
            'first_name': "",
            'last_name': "",
            'mobile_no': "",
            'ward_no': "",
            'address': "",
            'email': user.email,
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CheckLogin(uid: user.uid),
              ));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /* leading: RaisedButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            color: Colors.grey[700],
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen_a()));
            }), */
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FlutterLogo(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Signup Here as admin",
                  style: TextStyle(fontSize: 30.0, color: Colors.blue),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Nick Name"),
                    onChanged: (val) {
                      name = val;
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.blue, fontSize: 25),
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
                          style: TextStyle(color: Colors.blue, fontSize: 25),
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
                        color: Colors.green,
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
              /* MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () => googleSignIn().whenComplete(() async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Homepage(uid: user.uid)));
                }),
                child: Image(
                  image: AssetImage('assets/signin.png'),
                  width: 200.0,
                ),
              ), */
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  // send to login screen
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen_a()));
                },
                child: Text(
                  "Have an Account?",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
