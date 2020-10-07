import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmerContactCall extends StatefulWidget {
  @override
  _EmerContactCallState createState() => _EmerContactCallState();
}

class _EmerContactCallState extends State<EmerContactCall> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          child: Text("Call Now"),
          onPressed: () async {
            var data;
            var result = await _db.collection('mother').doc(user.uid).get();
            setState(() {
              data = result.data()['m_emergencyContact'];
              print(data);
              FlutterPhoneDirectCaller.callNumber(data);
            });
          }),
    );
  }
}