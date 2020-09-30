import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "auth/auth.dart";
import "home.dart";
import 'package:firebase_core/firebase_core.dart';
import "package:firebase_auth/firebase_auth.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({ this.user});
  final String user;

  @override
  SignInScreenStat createState() => SignInScreenStat();
}

class SignInScreenStat extends State<SignInScreen> {
  String newUser = "Hi new user. Welcome!";
  String oldUser = "Welcome Back! Please Sign in.";
  String phoneNumber, smsCode;
  final smsController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneController.dispose();
    smsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double fontSize = MediaQuery.of(context).size.width * 0.045;
    String title = "";
    if(widget.user == "new"){
      title = newUser;
    }else{
      title = oldUser;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFCFFD5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(70),
              alignment: Alignment.center,
              child: new Image.asset(
                "assets/images/logo.png",
                height: 150,
              ),
            ),
            Container(
              width: width,
              child: Row(
                children: <Widget>[
                  Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                        letterSpacing: 1.0,
                      ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 0, right: 0),
              width: width,
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.phoneAlt),
                  hintText: "Phone number",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 0, right: 0),
              width: width,
              child: TextField(
                controller: smsController,
                decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.key),
                  hintText: "OTP",
                ),
              ),
            ),
            Container(
              width: width,
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                textColor: Colors.white,
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
                color: Color(0xB38702AE),
                onPressed: (){
                  phoneNumber = phoneController.text;
                  smsCode = smsController.text;
                },
              ),
            ),
          ],
        )
    );
  }
}