import "package:flutter/material.dart";
import "foodIntake_main.dart";
import "foodIntake_add_2_food.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:bundle_of_joy/foodIntake/foodIntake_recordList_done.dart';
import "package:cloud_firestore/cloud_firestore.dart";

import 'package:quiver/iterables.dart';

class FoodIntakeRecordDone extends StatefulWidget {
  final String foodIntakeRecordID;
  FoodIntakeRecordDone({Key key, @required this.foodIntakeRecordID}) : super(key: key);

  @override
  _FoodIntakeRecordDoneState createState() => _FoodIntakeRecordDoneState();
}

class _FoodIntakeRecordDoneState extends State<FoodIntakeRecordDone> {
  //final User user = FirebaseAuth.instance.currentUser;
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Done");

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
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
      body: FutureBuilder<DocumentSnapshot>(
        future: collectionReference.doc(widget.foodIntakeRecordID).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map food = snapshot.data.data()["foodMap"];
            List<dynamic> foodName = List<dynamic>();
            List<dynamic> foodQty = List<dynamic>();
            foodName = food.keys.toList();
            foodQty = food.values.toList();
            var bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);
            var bSugarAfter = double.parse(snapshot.data.data()["bsAfter"]);
            //print(foodName);
            //print(foodQty);

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
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/calendar.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Container(
                                //color: Colors.red,
                                width: MediaQuery.of(context).size.width * 0.6,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                child: Text(
                                  snapshot.data.data()["selectedDate"],
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/time.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Container(
                                //color: Colors.red,
                                width: MediaQuery.of(context).size.width * 0.6,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                child: Text(
                                  snapshot.data.data()["selectedTime"],
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                                child: Image.asset(
                                  "assets/icons/food-intake.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    //color: Colors.red,
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Table(
                                      children: [
                                        for (var x in zip([foodName, foodQty]))
                                          TableRow(children: [
                                            TableCell(
                                                child: Row(
                                              children: <Widget>[
                                                Container(
                                                  //color: Colors.green,
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015),
                                                    child: new Text(
                                                      x[0].toString(),
                                                      style: TextStyle(
                                                        fontFamily: 'Comfortaa',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: MediaQuery.of(context).size.height * 0.025,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.05,
                                                ),
                                                Container(
                                                  //color: Colors.white,
                                                  width: MediaQuery.of(context).size.width * 0.1,
                                                  child: new Text(
                                                    "x" + x[1].toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Comfortaa',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ))
                                          ])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/blood-sugar-level.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Before: ",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.data()["bsBefore"] + " mmol/L",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Row(
                                      children: [
                                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                          if (bSugarBefore < 5.1) {
                                            return Text(
                                              "Too Low",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.red,
                                              ),
                                            );
                                          } else if (bSugarBefore < 6.1) {
                                            return Text(
                                              "Excellent",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.green,
                                              ),
                                            );
                                          } else if (bSugarBefore < 8.1) {
                                            return Text(
                                              "Good",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.lime,
                                              ),
                                            );
                                          } else if (bSugarBefore < 10.1) {
                                            return Text(
                                              "Acceptable",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.orange,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              "Poor",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.red,
                                              ),
                                            );
                                          }
                                        })
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Row(
                                      children: [
                                        Text(
                                          "After: ",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.data()["bsAfter"] + " mmol/L",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Row(
                                      children: [
                                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                          if (bSugarAfter < 5.1) {
                                            return Text(
                                              "Too Low",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.red,
                                              ),
                                            );
                                          } else if (bSugarAfter < 7.1) {
                                            return Text(
                                              "Excellent",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.green,
                                              ),
                                            );
                                          } else if (bSugarAfter < 10.1) {
                                            return Text(
                                              "Good",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.lime,
                                              ),
                                            );
                                          } else if (bSugarAfter < 13.1) {
                                            return Text(
                                              "Acceptable",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.orange,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              "Poor",
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                                color: Colors.red,
                                              ),
                                            );
                                          }
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: myBoxDecoration(),
                            child: Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }, //ADD TO DATABASE
                        ),
                      ],
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
      ),
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
}
