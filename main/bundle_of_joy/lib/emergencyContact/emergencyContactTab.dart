import 'dart:developer';

import 'eContactAddSecondary.dart';
import 'emergencyContactCall.dart';
import 'package:flutter/material.dart';
import 'emergencyContactAddScreen.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class EmergencyContactTab extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String patientID, message, title;
  bool contactPrimary, contactSecondary;

  Future _getContact() async {
    var x = await _db.collection('patient').where('m_id', isEqualTo: user.uid).get();
    //print(x.data()['m_emergencyContact']);
    //if (x.docs()['m_emergencyContact'] == null || x.data()['m_emergencyContact'] == "" || x.data().isEmpty) {   x.docs[4] == null || x.docs[4] == ''
    if (x.docs[0].data()["m_emergencyContactNoPrimary"] == "" || x.docs[0].data()["m_emergencyContactNoPrimary"] == null) {
      patientID = x.docs[0].data()["patient_id"];
      return false;
    } else {
      patientID = x.docs[0].data()["patient_id"];
      return true;
    }
  }

  Future _checkContactExist(context) async{
    var x = await _db.collection('patient').where('m_id', isEqualTo: user.uid).get();
    if (x.docs[0].data()["m_emergencyContactNoSecondary"] == null) {
      patientID = x.docs[0].data()["patient_id"];
      contactSecondary = false;
    } else {
      contactSecondary = true;
    }

    if(contactPrimary == true && contactSecondary == true){
      message = "You already save both emergency contact in your account. You can always modify it in Profile.";
      title = "Opps!";
      _showDialogBox(context, message, title);
    }else if(contactPrimary == true && contactSecondary == false){
      Navigator.push(context, 
        MaterialPageRoute(builder: (context) => EContactAddSecondary(patientID: patientID,))
      );
      //return EContactAddSecondary(patientID: patientID,);
    }else if(contactPrimary == false && contactSecondary == false){
      message = "You must add your primary emergency contact before adding the second one.";
      title = "Opps!";
      _showDialogBox(context, message, title);
    }
  }

  _showDialogBox(BuildContext context, message, title){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Emergency Contact",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add, //Icon image
              color: Colors.black,
            ), 
            onPressed: () async{
              _checkContactExist(context);
            })
        ],

        //automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getContact(), 
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == true) {
              contactPrimary = true;
              return EmerContactCall(patientID: patientID,);
            } else {
              contactPrimary = false;
              return AddEmerContactScreen(patientID: patientID,);
            }
          } else if (snapshot.hasError) {
            print("error");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
