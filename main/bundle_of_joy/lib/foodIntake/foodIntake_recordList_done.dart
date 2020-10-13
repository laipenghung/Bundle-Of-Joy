import 'package:bundle_of_joy/foodIntake/foodIntake_record_done.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class FoodIntakeListDone extends StatefulWidget {
  @override
  _FoodIntakeListDoneState createState() => _FoodIntakeListDoneState();
}

class _FoodIntakeListDoneState extends State<FoodIntakeListDone> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> _getFoodRecord() async {
    QuerySnapshot x = await _db.collection('foodIntake_Done').where("motherID", isEqualTo: user.uid).get();
    return x.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getFoodRecord(),
        builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return InkWell(//can wrap the Inkwell in a container //Keep inkwell & onTap onTap other can change
                    onTap: () {
                      print(snapshot.data[index].data()["recordID"]);
                      //pass the record id to the screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeRecordDone(foodIntakeRecordID: snapshot.data[index].data()["recordID"])),
                      );
                    },
                    child: Text(snapshot.data[index].data()["selectedDate"]));
                },
              );
            }
          } else if (snapshot.hasError) {
            print("error");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
