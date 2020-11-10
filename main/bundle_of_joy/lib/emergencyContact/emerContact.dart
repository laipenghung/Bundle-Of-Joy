import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmerContact {
  EmerContact();

  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addEmerContact(mEmerContactNo, patientID) {
    CollectionReference users = _db.collection("patient");
    return users
        .doc(patientID)
        .update({"m_emergencyContact": mEmerContactNo,})
        .then((value) => print("User Updated"),)
        .catchError((error) => print("Failed to update user: $error"));
  }
}
