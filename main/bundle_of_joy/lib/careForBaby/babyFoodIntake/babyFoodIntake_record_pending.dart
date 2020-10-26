import 'package:bundle_of_joy/mother-for-baby.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:quiver/iterables.dart';

class BabyFoodIntakeRecordPending extends StatefulWidget {
  final String recordID, selectedBabyID;
  BabyFoodIntakeRecordPending({Key key, this.recordID, this.selectedBabyID}) : super(key: key);

  @override
  _BabyFoodIntakeRecordPendingState createState() => _BabyFoodIntakeRecordPendingState();
}

class _BabyFoodIntakeRecordPendingState extends State<BabyFoodIntakeRecordPending> {
  var content;
  TextEditingController _controller = TextEditingController();
  String userInput = "", noInput = "No allergy and symptoms found.";

  void initState() {
    super.initState();

    content = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("mother")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("baby")
          .doc(widget.selectedBabyID)
          .collection("babyFoodIntake_Pending")
          .doc(widget.recordID)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map food = snapshot.data.data()["foodMap"];
          List<dynamic> foodName = List<dynamic>();
          List<dynamic> foodQty = List<dynamic>();
          foodName = food.keys.toList();
          foodQty = food.values.toList();

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
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
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
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
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
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/icons/food-intake.png",
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                  child: Table(
                                    //border: TableBorder.all(width: 1.0, color: Colors.black),
                                    children: [
                                      for (var x in zip([foodName, foodQty]))
                                        TableRow(children: [
                                          TableCell(
                                              child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                //color: Colors.blue,
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: new Text(
                                                  x[0].toString() + "\n x" + x[1].toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context).size.height * 0.023,
                                                    color: Colors.black,
                                                  ),
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
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            "Enter allergy and symptoms",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015),
                          width: MediaQuery.of(context).size.width * 0.85,
                          //height: MediaQuery.of(context).size.height * 0.055,
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                //height: MediaQuery.of(context).size.height * 0.055,
                                child: TextFormField(
                                  maxLines: 8,
                                  controller: _controller,
                                  onChanged: (val) {
                                    setState(() => userInput = val);
                                  },
                                  //textInputAction: TextInputAction.send,
                                  decoration: new InputDecoration(
                                    labelText: "Enter allergy and symptoms. If none, leave this textarea empty",
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
                          print(userInput);
                          if (_controller.text.isEmpty) {
                            updateBabyFoodIntakeRecord(snapshot.data.data()["selectedDate"], snapshot.data.data()["selectedTime"],
                              snapshot.data.data()["foodMap"], noInput, widget.selectedBabyID, snapshot.data.data()["recordID"]);
                          } else {
                            updateBabyFoodIntakeRecord(snapshot.data.data()["selectedDate"], snapshot.data.data()["selectedTime"],
                              snapshot.data.data()["foodMap"], userInput, widget.selectedBabyID, snapshot.data.data()["recordID"]);
                          }
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

  Future<void> updateBabyFoodIntakeRecord(selectedDate, selectedTime, foodMap, userInput, babyID, recordID) {
    //final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference babyFoodIntakeRecord =
        _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Done");
    return babyFoodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "foodMap": foodMap,
      "babysymptoms": userInput,
      "babyID": babyID,
    }).then((value) {
      babyFoodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Pending").doc(recordID).delete();
      print("Data Deleted");
    }).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MotherForBabyTab()));
    }).catchError((error) => print("wrong"));
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
      body: content,
    );
  }
}
