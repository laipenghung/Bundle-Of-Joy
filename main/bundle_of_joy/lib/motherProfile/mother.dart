import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Mother {
  String mID, mName, mDOB, mBloodType, mPhone, mEmergencyContact;
  int mAge, mNoOfChild;

  Mother();

  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void addUser(User user) async {
    CollectionReference users = _db.collection("mother");
    if(user.displayName != null)
      mName = user.displayName;
    else
      mName = user.phoneNumber;

    users.doc(user.uid).get().then((doc){
      if(doc.exists){
        print("User exists in db");
      }else{
        users.doc(user.uid).set({
          "m_id": user.uid,
          "pin_code": null,
          "is_verify": false
        }).then((value) => print("$mName Added"))
            .catchError((e) => print("Failed to add user: $e"));
      }
    });
  }

  void editProfile(String field, String change, String pid) async{
    DocumentReference patient = FirebaseFirestore.instance.collection("patient").doc(pid);

    patient.update({
      field: change.toString()
    }).then((value){
      //print("$field updated");
    }).catchError((e) => print("Failed to update $field: $e"));
  }

  void updateProfilePicture(String photoURL, String pid) async{
    DocumentReference patient = FirebaseFirestore.instance.collection("patient").doc(pid);

    patient.update({
      "photoURL": photoURL.toString()
    }).then((value){
      print("photoURL updated");
    }).catchError((e) => print("Failed to update photoURL: $e"));
  }
}