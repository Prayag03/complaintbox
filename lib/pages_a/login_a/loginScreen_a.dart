import 'package:complaintbox/controllers/authentication.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../main.dart';
import 'forgotpassword_a.dart';

// ignore: camel_case_types
class LoginScreen_a extends StatefulWidget {
  @override
  _LoginScreen_aState createState() => _LoginScreen_aState();
}

// ignore: camel_case_types
class _LoginScreen_aState extends State<LoginScreen_a> {
  String email;
  String password;
  String code;

  final myController = TextEditingController();
  final myController1 = TextEditingController();

  @override

  // ignore: override_on_non_overriding_member
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
      /* appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ], 
      ), */
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
                  "Login Here as admin",
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
                        controller: myController,
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
                          controller: myController1,
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
                      /*  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                          obscureText: true,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontSize: 25),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "admin code"),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Code Is Required"),
                            MinLengthValidator(6,
                                errorText: "Minimum 6 Characters Required"),
                          ]),
                          onChanged: (val) {
                            code = val;
                          },
                        ),
                      ), */
                      GestureDetector(
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot Password?",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 20))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ForgotPasswordScreen_a()));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: RaisedButton(
                      elevation: 10,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.blue[400],
                      textColor: Colors.white,
                      child: Text("Login as user",
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
