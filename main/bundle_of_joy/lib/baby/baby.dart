import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:bundle_of_joy/mother-for-baby.dart";
import "package:fluttertoast/fluttertoast.dart";

class Baby {
  String b_id, m_id, b_registered_id, b_name, b_place_of_birth, b_gender, b_age, b_bloodType, b_mode_of_delivery;
  double b_weight_at_birth, b_length_at_birth, b_head_circumference;
  int b_order;
  Timestamp b_dob;

  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Baby(
      this.b_id,
      this.m_id,
      this.b_registered_id,
      this.b_name,
      this.b_dob,
      this.b_place_of_birth,
      this.b_gender,
      this.b_age,
      this.b_bloodType,
      this.b_mode_of_delivery,
      this.b_weight_at_birth,
      this.b_length_at_birth,
      this.b_head_circumference,
      this.b_order);

  Baby.empty();

  Future<void> addBaby(String name, String registered_id, String age, String gender, DateTime dob, DateTime tob, String blood, BuildContext context) async{
    CollectionReference baby = _db.collection("mother").doc(user.uid).collection("baby");
    String combinedDate = dob.toString().substring(0, 10) + " " + tob.toString().substring(11, 19);
    Timestamp timestamp = Timestamp.fromDate(DateTime.parse(combinedDate));

    baby.add({
      "b_name": name,
      "b_registered_id": registered_id,
      "b_age": age,
      "b_gender": gender,
      "b_dob": timestamp,
      "b_bloodType": blood,
      "b_place_of_birth": "Add location",
      "b_head_circumference": 0.0,
      "b_length_at_birth": 0.0,
      "b_weight_at_birth": 0.0,
      "b_mode_of_delivery": "Add delivery method",
      "b_order": 0
    }).then((value) {
      baby.doc(value.id).update({
        "b_id": value.id
      });
      print("Baby Added");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context){
            return MotherForBabyTab();
          })
      );
      Fluttertoast.showToast(
        msg: "Baby Added",
        toastLength: Toast.LENGTH_LONG,
      );
    }).catchError((onError){
      print("Baby $onError");
    });
  }

  void updateAge(String age, String id) async{
    DocumentReference baby = _db.collection("mother").doc(user.uid).collection("baby").doc(id);

    baby.update({
      "b_age": age.toString()
    }).then((value){
      print("Baby age updated");
    }).catchError((e) => print("Failed to update baby age: $e"));
  }
}