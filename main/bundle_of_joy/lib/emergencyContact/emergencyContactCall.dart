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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/icons/alarm.png"),
            )),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Text(
            "Have an emergency? \n Click the button to call now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.black,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Container(
            child: RaisedButton(
                color: Color(0xFFFCFFD5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(width: 1.5, color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "Call Now",
                    style: (TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: "Comfortaa",
                    )),
                  ),
                ),
                onPressed: () async {
                  var data;
                  var result = await _db.collection('mother').doc(user.uid).get();
                  setState(() {
                    data = result.data()['m_emergencyContact'];
                    print(data);
                    FlutterPhoneDirectCaller.callNumber(data);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
