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
      // APP BAR
      appBar: AppBar(
        title: Text(
          "Food Intake Tracking",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      body: FutureBuilder(
        future: _getFoodRecord(),
        builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                child: ListView.builder(
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
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.015,
                                bottom: MediaQuery.of(context).size.height * 0.015,
                                left: MediaQuery.of(context).size.width * 0.07),
                            //color: Colors.lightBlue,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                  child: Image.asset(
                                    "assets/icons/meal.png",
                                    height: MediaQuery.of(context).size.height * 0.06,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index].data()['selectedDate'],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      snapshot.data[index].data()['selectedTime'],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      'View Record >>>',
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontSize: MediaQuery.of(context).size.width * 0.035,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            indent: MediaQuery.of(context).size.width * 0.03,
                            endIndent: MediaQuery.of(context).size.width * 0.03,
                            color: Colors.black,
                            thickness: MediaQuery.of(context).size.height * 0.001,
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
