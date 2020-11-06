import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "home.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'file:///C:/Users/User/Desktop/Code/Bundle-Of-Joy/main/bundle_of_joy/lib/motherProfile/mother.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({this.user});
  final String user;

  @override
  SignInScreenStat createState() => SignInScreenStat();
}

class SignInScreenStat extends State<SignInScreen> {
  String newUser = "Hi new user. Welcome!";
  String oldUser = "Welcome Back! Please Sign in.";
  String phoneNumber, smsCode, verificationID;

  Future<void> verifyPhone() async {
    await Firebase.initializeApp();
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verID) {
      this.verificationID = verID;
    };

    final PhoneCodeSent smsCodeSent = (String verID, int resendToken) {
      this.verificationID = verID;
      smsCodeDialog(context).then((value) {
        print("Signed in");
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (PhoneAuthCredential credential) {
      print("Verified");
    };

    final PhoneVerificationFailed verifiedFailed = (FirebaseAuthException e) {
      print("${e.message}");
      errorDialog(context);
    };

    if (this.phoneNumber != null) {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: this.phoneNumber,
          verificationCompleted: verifiedSuccess,
          verificationFailed: verifiedFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: autoRetrieve);
    } else {
      errorDialog(context);
    }
  }

  Future<bool> errorDialog(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.045;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFCFFD5),
            title: Text(
              "Error!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            content: Text("Phone number is not valid or not found!"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        });
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.045;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFCFFD5),
            title: Text(
              "Enter SMS Code",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            content: TextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }),
                    );
                  } else {
                    Navigator.of(context).pop();
                    signIn();
                  }
                },
              )
            ],
          );
        });
  }

  signIn() {
    final AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      print("Sign in succeeded: $user");
      Mother newMother = new Mother();
      newMother.addUser(user.user);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }),
      );
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double fontSize = MediaQuery.of(context).size.width * 0.045;
    String title = "";
    if (widget.user == "new") {
      title = newUser;
    } else {
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
                "assets/icons/small.png",
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
                decoration: InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.phoneAlt),
                  hintText: "Phone number (+6014 567 8912)",
                ),
                onChanged: (value) {
                  this.phoneNumber = value;
                },
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
                onPressed: verifyPhone,
              ),
            ),
          ],
        ));
  }
}
