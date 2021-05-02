import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "auth/auth.dart";
import "home.dart";
import "sign_in.dart";

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double fontSize = MediaQuery.of(context).size.width * 0.045;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFFCFFD5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(70),
              alignment: Alignment.center,
              child: new Image.asset(
                "assets/icons/small.png",
                height: 150,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15.0, left: 25.0, right: 25.0),
              child: SignInButtonBuilder(
                innerPadding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                width: width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                icon: FontAwesomeIcons.facebookF,
                text: "Sign up with Facebook",
                fontSize: fontSize,
                backgroundColor: Color(0xFF4267B2),
                onPressed: () {
                  signInWithFacebook().then((result){
                    if(result!=null){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context){
                              return HomeScreen();
                            }
                        ),
                      );
                    }
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15.0, left: 25.0, right: 25.0),
              child: SignInButtonBuilder(
                innerPadding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                width: width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                icon: FontAwesomeIcons.google,
                text: "Sign up with Google",
                fontSize: fontSize,
                backgroundColor: Color(0xFFdb3236),
                onPressed: () {
                  signInWithGoogle().then((result){
                    if(result!=null){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context){
                              return HomeScreen();
                            }
                        ),
                      );
                    }
                  });
                },
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: new Container(
                      margin: EdgeInsets.only(left: 40.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                ),
                Text("OR"),
                Expanded(
                  child: new Container(
                    margin: EdgeInsets.only(left: 20.0, right: 40.0),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
              child: SignInButtonBuilder(
                innerPadding: EdgeInsets.fromLTRB(20, 13, 20, 13),
                width: width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                icon: FontAwesomeIcons.phoneAlt,
                text: "Register with Phone Number",
                fontSize: fontSize,
                backgroundColor: Color(0xB38702AE),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context){
                          return SignInScreen(user: "new");
                        }
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "Already have an account? ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize-3,
                    ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context){
                            return SignInScreen(user: "old");
                          }
                      ),
                    );
                  },
                  child: Text(
                    "Login here",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue,
                      fontSize: fontSize-3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}