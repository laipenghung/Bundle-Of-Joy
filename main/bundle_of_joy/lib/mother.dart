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
          "m_name": mName,
          "m_age": null,
          "m_dob": null,
          "m_bloodType": null,
          "m_no_of_child": null,
          "m_phone": null,
          "m_emergencyContact": null
        }).then((value) => print("$mName Added"))
            .catchError((e) => print("Failed to add user: $e"));
      }
    });
  }

  void editProfile(String field, String value) async{
    CollectionReference users = _db.collection("mother");
    users.doc(user.uid).update({
      field: value.toString()
    }).then((value) => print("$field updated"))
    .catchError((e) => print("Failed to update $field: $e"));
  }
}