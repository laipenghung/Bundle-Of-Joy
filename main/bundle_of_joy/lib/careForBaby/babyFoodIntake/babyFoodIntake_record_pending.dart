import 'package:bundle_of_joy/careForBaby/babyFoodIntake/babyFoodIntakeMain.dart';
import 'package:bundle_of_joy/careForBaby/careForBabyTab.dart';
import 'package:bundle_of_joy/mother-for-baby.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiver/iterables.dart';
import '../../main.dart';

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
  MyApp main = MyApp();

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
    //tz.initializeTimeZones();
    //final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    //tz.setLocalLocation(tz.getLocation(currentTimeZone));
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Channel Id',
      'Channel title',
      'channel body',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.show(
        0, 'Medicine Intake Tracking', 'Medicine record successfully created.', notificationDetails);
  }

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
                                                width: MediaQuery.of(context).size.width * 0.45,
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
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
                          child: Divider(
                            indent: MediaQuery.of(context).size.width * 0.05,
                            endIndent: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                            thickness: MediaQuery.of(context).size.height * 0.001,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, left: MediaQuery.of(context).size.width * 0.03),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Text(
                            "Enter the allergy or symptoms",
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
                          child: TextFormField(
                            maxLines: 8,
                            controller: _controller,
                            onChanged: (val) {
                              setState(() => userInput = val);
                            },
                            //textInputAction: TextInputAction.send,
                            decoration: new InputDecoration(
                              hintText: "Enter some description of the \nallergy or symptoms. \n\nIf none, leave this textarea empty",
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
                            updateBabyFoodIntakeRecord(snapshot.data.data()["selectedDate"], snapshot.data.data()["selectedTime"], snapshot.data.data()["foodMap"], noInput,
                                widget.selectedBabyID, snapshot.data.data()["recordID"], false);
                            _showNotification();
                          } else {
                            updateBabyFoodIntakeRecord(snapshot.data.data()["selectedDate"], snapshot.data.data()["selectedTime"], snapshot.data.data()["foodMap"], userInput,
                                widget.selectedBabyID, snapshot.data.data()["recordID"], true);
                            _showNotification();
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

  Future<void> updateBabyFoodIntakeRecord(selectedDate, selectedTime, foodMap, userInput, babyID, recordID, symptomsAndAllergies) {
    //final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference babyFoodIntakeRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Done");
    return babyFoodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "foodMap": foodMap,
      "babysymptoms": userInput,
      "babyID": babyID,
      "symptomsAndAllergies": symptomsAndAllergies,
    }).then((value) {
      babyFoodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Pending").doc(recordID).delete();
      print("Data Deleted");
    }).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyTab(selectedBabyID: babyID)));
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
