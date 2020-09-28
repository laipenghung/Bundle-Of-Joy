import "package:flare_splash_screen/flare_splash_screen.dart";
import "package:flutter/material.dart";
import "sign_up.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(int.parse("0xFFFCFFD5")),
      ),
      home: SplashScreen.navigate(
        name: "assets/images/logo_animation.flr",
        next: (context) => SignUpScreen(),
        until: () => Future.delayed(Duration(seconds: 5)),
        startAnimation: "logo_animation",
        backgroundColor: Color(0xFFFCFFD5),
      ),
    );
  }
}