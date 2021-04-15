import 'package:complaintbox/controllers/authentication.dart';
import 'package:complaintbox/pages/login/signupScreen.dart';
import 'package:complaintbox/pages_a/login_a/loginScreen_a.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../main.dart';
import 'forgotpassword.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void login() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      signin(email, password, context).then((value) {
        if (value != null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(uid: value.uid),
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
              /*  FlutterLogo(
                size: 50.0,
              ), */
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Login Here as user",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
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
                        style: TextStyle(color: Colors.black, fontSize: 25),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: "Email"),
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "This Field Is Required"),
                          EmailValidator(errorText: "Invalid Email Address"),
                        ]),
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Password Is Required"),
                            MinLengthValidator(6,
                                errorText: "Minimum 6 Characters Required"),
                          ]),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  // fontWeight: FontWeight.w600,
                                ))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ForgotPasswordScreen()));
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(0.0),
                            child: RaisedButton(
                              // passing an additional context parameter to show dialog boxs
                              elevation: 20,
                              onPressed: login,
                              color: Colors.blue[400],
                              textColor: Colors.white,
                              child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: InkWell(
                    onTap: () {
                      // send to login screen

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Haven't an Account?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen_a()));
                      },
                      color: Colors.blue[400],
                      textColor: Colors.white,
                      child: Text("Login as admin",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
