import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmerContact {
  String mEmerContact;
  
  EmerContact();

  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void checkEmerContact() {}

  void addEmerContact(mEmerContactNo, mEmerContactName) async {
    CollectionReference users = _db.collection("mother");

    users
        .doc(user.uid)
        .update({
          "m_emergencyContact" : mEmerContactNo,
        })
        .then((value) => print("Emergency Contact Added"))
        .catchError((e) => print("Failed to add Emergency Contact"));
  }
}
