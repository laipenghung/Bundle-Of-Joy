import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmerContact {
  String mEmerContact;

  EmerContact();

  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  test() {
    
  }

  Future<void> addEmerContact(mEmerContactNo) {
    CollectionReference users = _db.collection("mother");
    return users
        .doc(user.uid)
        .update({"m_emergencyContact": mEmerContactNo,})
        .then((value) => print("User Updated"),)
        .catchError((error) => print("Failed to update user: $error"));
  }
}
