import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HealthTrackingFunction {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> uploadHealthRecord(selectedDate, selectedTime, bPressure_dia, bPressure_sys, bSugar, dayOfPregnancy, height, weight, addHealthScreenBuildContext, addHealthSummaryBuildContext) {
    CollectionReference collectionReferenceHealthRecord = _db.collection('mother').doc(user.uid).collection('health_record');
    return collectionReferenceHealthRecord.add({
      "d_id": "",
      "m_id": user.uid,
      "mh_bloodPressure_dia": bPressure_dia.toString(),
      "mh_bloodPressure_sys": bPressure_sys.toString(),
      "mh_bloodSugar": bSugar,
      "mh_date": selectedDate,
      "mh_day_of_pregnancy": dayOfPregnancy,
      "mh_height": height,
      "mh_time": selectedTime,
      "mh_weight": weight,
    }).then((value) {
      collectionReferenceHealthRecord.doc(value.id).update({
        "mh_id": value.id,
      });
      print("Data uploaded");
      Navigator.of(addHealthScreenBuildContext).pop();
      Navigator.of(addHealthSummaryBuildContext).pop();
    }).catchError((error) => print(error));
  }
}
