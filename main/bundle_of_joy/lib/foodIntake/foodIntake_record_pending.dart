import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "foodIntake_main.dart";
import "foodIntake_add_2_food.dart";

class FoodIntakeRecordPending extends StatefulWidget {
  final String foodIntakeRecordID;
  FoodIntakeRecordPending({Key key, @required this.foodIntakeRecordID}) : super(key: key);

  @override
  _FoodIntakeRecordPendingState createState() => _FoodIntakeRecordPendingState();
}

class _FoodIntakeRecordPendingState extends State<FoodIntakeRecordPending> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("foodIntake_Pending");
  String bSugarUpdate = "";
  var test;

  void initState() {
    super.initState();
    test = StreamBuilder<DocumentSnapshot>(
      stream: collectionReference.doc(widget.foodIntakeRecordID).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
                  //color: Colors.lightBlue,
                  height: MediaQuery.of(context).size.height * 0.52,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            snapshot.data.data()["selectedDate"],
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            snapshot.data.data()["selectedTime"],
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        //implement function to display foodMap data

                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            snapshot.data.data()["bsBefore"],
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => bSugarUpdate = val);
                            },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              //labelText: "Blood sugar reading",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                            onSaved: (String value) {},
                            validator: (String value) {
                              return null;
                            },
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: RaisedButton(
                            onPressed: () {
                              updateFoodRecord(
                                snapshot.data.data()["motherID"],
                                snapshot.data.data()["selectedDate"],
                                snapshot.data.data()["selectedTime"],
                                snapshot.data.data()["bsBefore"],
                                bSugarUpdate,
                                snapshot.data.data()["foodMap"],
                                snapshot.data.data()["recordID"]
                              );
                            },
                            child: Text(
                              "update",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        } else if (snapshot.hasError) {
          print("error");
        }
        return CircularProgressIndicator();
      },
    );
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

      // BODY
      body: test,
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0) //<--- border radius here
          ),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0) //<--- border radius here
          ),
    );
  }

  Future<void> updateFoodRecord(motherID, selectedDate, selectedTime, bsBefore, bsAfter, foodMap, recordID) {
    //final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference foodIntakeRecord = _db.collection("foodIntake_Done");
    return foodIntakeRecord.add({
      "motherID": motherID,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bsBefore": bsBefore,
      "bsAfter": bsAfter,
      "foodMap": foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      _db.collection("foodIntake_Pending").doc(recordID).delete();
      print("Data Deleted");
    }).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeMain()));
    }).catchError((error) => print("wrong"));
  }
}