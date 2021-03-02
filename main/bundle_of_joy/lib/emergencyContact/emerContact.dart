import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmerContact {
  EmerContact();

  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addEmerContactPrimary(mEmerContactNo, mEmerContactName, patientID) {
    CollectionReference users = _db.collection("patient");
    return users
        .doc(patientID)
        .update({
          "m_emergencyContactNoPrimary": mEmerContactNo,
          "m_emergencyContactNamePrimary": mEmerContactName,
        })
        .then((value) => print("User Updated"),)
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> addEmerContactSecondary(mEmerContactNo, mEmerContactName, patientID) {
    CollectionReference users = _db.collection("patient");
    return users
        .doc(patientID)
        .update({
          "m_emergencyContactNoSecondary": mEmerContactNo,
          "m_emergencyContactNameSecondary": mEmerContactName,
        })
        .then((value) => print("User Updated"),)
        //.catchError((error) => print("Failed to update user: $error"))
        ;
  }
}
