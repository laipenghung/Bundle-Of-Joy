import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flare_splash_screen/flare_splash_screen.dart";
import "package:flutter/material.dart";
import "sign_up.dart";
import "home.dart";

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(int.parse("0xFFFCFFD5")),
      ),
      home: WelcomeScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }
}

class WelcomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();

}

class _WelcomeScreenState extends State<WelcomeScreen>{
  @override
  Widget build(BuildContext context) {
    Future<User> checkSignedIn() async {
      await Firebase.initializeApp();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User user = _auth.currentUser;
      print(user);
      return user;
    }

    Future<Widget> next(BuildContext context) async {
      if(await checkSignedIn() == null) {
        print("test 1 $checkSignedIn()");
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => new SignUpScreen())
        );
      }else{
        print("test 2 $checkSignedIn()");
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => new HomeScreen())
        );
      }
    }

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(int.parse("0xFFFCFFD5")),
      ),
      home: SplashScreen.callback(
        name: "assets/images/logo_animation.flr",
        onSuccess: (_) => next(context),
        onError: (e, s) {},
        until: () => checkSignedIn(),
        startAnimation: "logo_animation",
        backgroundColor: Color(0xFFFCFFD5),
      ),
    );
  }
}