import 'package:bundle_of_joy/foodIntake/foodIntake_record_pending.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class FoodIntakeListPending extends StatefulWidget {
  @override
  _FoodIntakeListPendingState createState() => _FoodIntakeListPendingState();
}

class _FoodIntakeListPendingState extends State<FoodIntakeListPending> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> _getFoodRecord() async {
    QuerySnapshot x = await _db.collection('foodIntake_Pending').where("motherID", isEqualTo: user.uid).get();
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
                  return InkWell(
                    onTap: () {
                      print(snapshot.data[index].data()['recordID']);
                      //go to record_pending
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeRecordPending(foodIntakeRecordID: snapshot.data[index].data()["recordID"])),
                      );
                    },
                    child: Text(snapshot.data[index].data()['selectedDate']));
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
