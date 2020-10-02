import 'package:bundle_of_joy/auth/auth.dart';
import 'sign_up.dart';
import "package:flutter/material.dart";

class ProfileTab extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RaisedButton(
        onPressed: () {
          signOut();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context){
                  return SignUpScreen();
                }
            ),
          );
        },
        child: const Text("Sign Out", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}