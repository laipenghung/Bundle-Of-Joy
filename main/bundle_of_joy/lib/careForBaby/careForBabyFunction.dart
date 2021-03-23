import 'package:bundle_of_joy/careForBaby/careForBabyMain.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CareForBabyFunction{
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadBabyMedsRecordDone(selectedBabyID, selectedDate, selectedTime, bTempBefore, bTempAfter, medsMap, context) {
    CollectionReference babyTempRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("tempRecord_Done");
    return babyTempRecord.add({
      "motherID": user.uid,
      "babyID": selectedBabyID,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bTempBefore": bTempBefore,
      "bTempAfter": bTempAfter,
      "medsMap": medsMap,
    }).then((value) {
      babyTempRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print(error));
  }

  Future<void> uploadBabyMedsRecordPending(selectedBabyID, selectedDate, selectedTime, bTempBefore, bTempAfter, medsMap, context) {
    CollectionReference babyTempRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("tempRecord_Pending");
    return babyTempRecord.add({
      "motherID": user.uid,
      "babyID": selectedBabyID,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bTempBefore": bTempBefore,
      "bTempAfter": bTempAfter,
      "medsMap": medsMap,
    }).then((value) {
      babyTempRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print(error));
  }

  Future<void> updateBabyMedsRecordPending(selectedBabyID, selectedDate, selectedTime, bTempBefore, bTempAfter, medsMap, recordID, context) {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference babyTempRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("tempRecord_Done");
    return babyTempRecord.add({
      "motherID": user.uid,
      "babyID": selectedBabyID,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bTempBefore": bTempBefore,
      "bTempAfter": bTempAfter,
      "medsMap": medsMap,
    }).then((value) {
      babyTempRecord.doc(value.id).update({"recordID": value.id,});
      _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("tempRecord_Pending").doc(recordID).delete();
      print("Data uploaded & deleted");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print(error));
  }
}