import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'foodIntake_Track_Main.dart';

class FoodIntakeTrackFunction {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadFoodRecordDone(selectedDate, selectedTime, bSugarBefore, bSugarAfter, foodMap, addFoodSummaryBuildContext, addFoodScreenBuildContext) {
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("foodIntake_Done");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bsBefore": bSugarBefore,
      "bsAfter": bSugarAfter,
      "foodMap": foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.of(addFoodScreenBuildContext).pop();
      Navigator.of(addFoodSummaryBuildContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeTrackMain()));
    }).catchError((error) => print("wrong"));
  }

  Future<void> uploadFoodRecordPending(selectedDate, selectedTime, bSugarBefore, bSugarAfter, foodMap, addFoodSummaryBuildContext, addFoodScreenBuildContext) {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("foodIntake_Pending");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bsBefore": bSugarBefore,
      "bsAfter": bSugarAfter,
      "foodMap": foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.of(addFoodScreenBuildContext).pop();
      Navigator.of(addFoodSummaryBuildContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeTrackMain()));
    }).catchError((error) => print("wrong"));
  }

  Future<void> updateFoodRecordPending(selectedDate, selectedTime, bSugarBefore, bSugarAfter, foodMap, updateFoodBuildContext, recordID, pendingRecordsListScreenBuildContext) {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("foodIntake_Done");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bsBefore": bSugarBefore,
      "bsAfter": bSugarAfter,
      "foodMap": foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      _db.collection("mother").doc(user.uid).collection("foodIntake_Pending").doc(recordID).delete();
      print("Data uploaded & deleted");
      Navigator.of(pendingRecordsListScreenBuildContext).pop();
      Navigator.of(updateFoodBuildContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeTrackMain()));
    }).catchError((error) => print("wrong"));
  }
}
