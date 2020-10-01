import 'package:firebase_core/firebase_core.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flare_splash_screen/flare_splash_screen.dart";
import "package:flutter/material.dart";
import "sign_up.dart";
import "home.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<User> checkSignedIn() async {
    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;
    print(user);
    return user;
  }

  Widget next(){
    if(checkSignedIn() == null){
      return SignUpScreen();
    }else{
      return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(int.parse("0xFFFCFFD5")),
      ),
      home: SplashScreen.navigate(
        name: "assets/images/logo_animation.flr",
        next: (context) => next(),
        until: () => checkSignedIn(),
        startAnimation: "logo_animation",
        backgroundColor: Color(0xFFFCFFD5),
      ),
    );
  }
}