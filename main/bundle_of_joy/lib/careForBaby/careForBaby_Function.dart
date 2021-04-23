import 'package:bundle_of_joy/careForBaby/careForBaby_Main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CareForBabyFunction {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadBabyMedsRecordDone(selectedBabyID, selectedDate, selectedTime, bTempBefore, bTempAfter, medsMap, babyAddMedSummaryContext, babyAddMedBuildContext) {
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
      Navigator.of(babyAddMedBuildContext).pop();
      Navigator.of(babyAddMedSummaryContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print(error));
  }

  Future<void> uploadBabyMedsRecordPending(selectedBabyID, selectedDate, selectedTime, bTempBefore, bTempAfter, medsMap, babyAddMedSummaryContext, babyAddMedBuildContext) {
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
      Navigator.of(babyAddMedBuildContext).pop();
      Navigator.of(babyAddMedSummaryContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print(error));
  }

  Future<void> updateBabyMedsRecordPending(selectedBabyID, selectedDate, selectedTime, bTempBefore, bTempAfter, medsMap, recordID, babyUpdateMedContext, babyMedRecordListContext) {
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
      _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("tempRecord_Pending").doc(recordID).delete();
      print("Data uploaded & deleted");
      Navigator.of(babyMedRecordListContext).pop();
      Navigator.of(babyUpdateMedContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print(error));
  }

  Future<void> uploadBabyFoodRecordDone(selectedBabyID, selectedDate, selectedTime, foodMap, symptomsAndAllergies, symptomsAndAllergiesDesc, babyAddFoodSummaryContext, babyAddFoodBuildContext) {
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("babyFoodIntake_Done");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "foodMap": foodMap,
      "symptomsAndAllergies": symptomsAndAllergies,
      "babysymptoms": symptomsAndAllergiesDesc,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.of(babyAddFoodBuildContext).pop();
      Navigator.of(babyAddFoodSummaryContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print("wrong"));
  }

  Future<void> uploadBabyFoodRecordPending(selectedBabyID, selectedDate, selectedTime, foodMap, babyAddFoodSummaryContext, babyAddFoodBuildContext) {
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("babyFoodIntake_Pending");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "foodMap": foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.of(babyAddFoodBuildContext).pop();
      Navigator.of(babyAddFoodSummaryContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print("wrong"));
  }

  Future<void> updateBabyFoodRecordPending(selectedBabyID, selectedDate, selectedTime, foodMap, symptomsAndAllergies, symptomsAndAllergiesDesc, recordID, babyUpdateFoodContext, babyFoodRecordListContext) {
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("babyFoodIntake_Done");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "foodMap": foodMap,
      "symptomsAndAllergies": symptomsAndAllergies,
      "babysymptoms": symptomsAndAllergiesDesc,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      _db.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("babyFoodIntake_Pending").doc(recordID).delete();
      print("Data uploaded & deleted");
      Navigator.of(babyFoodRecordListContext).pop();
      Navigator.of(babyUpdateFoodContext).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)));
    }).catchError((error) => print("wrong"));
  }
}
