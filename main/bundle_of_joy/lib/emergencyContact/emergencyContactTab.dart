import 'emergencyContactCall.dart';
import 'package:flutter/material.dart';
import 'emergencyContactAddScreen.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmergencyContactTab extends StatelessWidget {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String patientID;

  Future _getContact() async {
    var x = await _db.collection('patient').where("m_id", isEqualTo: user.uid).get();
    if (x.docs[0].data()["m_emergencyContact"] == null || x.docs[0].data()["m_emergencyContact"] == "") {
      patientID = x.docs[0].data()["patient_id"];
      return false;
    } else {
      return true;
    }
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
              return EmerContactCall();
            } else {
              return AddEmerContactScreen(patientID: patientID);
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
