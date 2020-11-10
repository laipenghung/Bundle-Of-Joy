import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "foodIntake_main.dart";
import "foodIntake_add_2_food.dart";
import 'package:bundle_of_joy/foodIntake/foodIntake_recordList_pending.dart';

import 'package:quiver/iterables.dart';

class FoodIntakeRecordPending extends StatefulWidget {
  final String foodIntakeRecordID;
  FoodIntakeRecordPending({Key key, @required this.foodIntakeRecordID}) : super(key: key);

  @override
  _FoodIntakeRecordPendingState createState() => _FoodIntakeRecordPendingState();
}

class _FoodIntakeRecordPendingState extends State<FoodIntakeRecordPending> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Pending");
  String bSugarUpdate = "";
  TextEditingController controllerBP = TextEditingController();
  var test;

  void initState() {
    super.initState();
    test = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Pending").doc(widget.foodIntakeRecordID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map food = snapshot.data.data()["foodMap"];
          List<dynamic> foodName = List<dynamic>();
          List<dynamic> foodQty = List<dynamic>();
          foodName = food.keys.toList();
          foodQty = food.values.toList();
          var bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);
          //print(foodName);
          //print(foodQty);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
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
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          height: MediaQuery.of(context).size.height * 0.04,
                                          child: TextFormField(
                                            controller: controllerBP,
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
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
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
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: myBoxDecoration(),
                            child: Center(
                              child: Text(
                                "Done",
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
                            if (controllerBP.text.isEmpty) {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Opps!"),
                                      content: Text("Please enter your Blood Sugar reading after 2 hours."),
                                      actions: <Widget>[
                                        RaisedButton(
                                          child: Text("Ok"),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              updateFoodRecord(snapshot.data.data()["motherID"], snapshot.data.data()["selectedDate"], snapshot.data.data()["selectedTime"],
                                  snapshot.data.data()["bsBefore"], bSugarUpdate, snapshot.data.data()["foodMap"], snapshot.data.data()["recordID"]);
                            }
                          }, //ADD TO DATABASE
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

  validateInput(String text) {
    if (text.isEmpty) {
    } else {}
  }

  Future<void> updateFoodRecord(motherID, selectedDate, selectedTime, bsBefore, bsAfter, foodMap, recordID) {
    //final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("foodIntake_Done");
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
      _db.collection("mother").doc(user.uid).collection("foodIntake_Pending").doc(recordID).delete();
      print("Data Deleted");
    }).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeMain()));
    }).catchError((error) => print("wrong"));
  }
}
