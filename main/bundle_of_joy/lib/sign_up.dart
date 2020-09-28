import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_signin_button/flutter_signin_button.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "auth/auth.dart";
import "home.dart";

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
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
            margin: EdgeInsets.only(bottom: 15.0, left: 25.0, right: 25.0),
            child: SignInButtonBuilder(
              innerPadding: EdgeInsets.fromLTRB(20, 13, 25, 13),
              width: width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              icon: FontAwesomeIcons.facebookF,
              text: "\tSign up with Facebook",
              fontSize: 20.0,
              backgroundColor: Color(0xFF4267B2),
              onPressed: () {}, //TODO:Facebook login
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.0, left: 25.0, right: 25.0),
            child: SignInButtonBuilder(
              innerPadding: EdgeInsets.fromLTRB(20, 13, 35, 13),
              width: width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              icon: FontAwesomeIcons.google,
              text: "\tSign up with Google",
              fontSize: 20.0,
              backgroundColor: Color(0xFFdb3236),
              onPressed: () {
                signInWithGoogle().then((result){
                  if(result!=null){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context){
                            return HomeScreen();
                          }
                      ),
                    );
                  }
                });
              }, //TODO:Google login
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
              innerPadding: EdgeInsets.fromLTRB(20, 13, 10, 13),
              width: width,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              icon: FontAwesomeIcons.phoneAlt,
              text: "\tRegister with Phone Number",
              fontSize: 20.0,
              backgroundColor: Color(0xB38702AE),
              onPressed: () {}, //TODO:Phone login
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Already have an account? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
              ),
              GestureDetector(
                onTap: (){}, //TODO:Phone login
                child: Text(
                  "Login here",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}