import 'package:bundle_of_joy/main.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "foodIntake_add_3_bs.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import 'dart:async';
import 'package:flutter/services.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'foodIntake_main.dart';
import 'foodIntake_recordList_pending.dart';

import 'package:quiver/iterables.dart';

class FoodIntakeSummaryPending extends StatefulWidget {
  final String selectedDate, selectedTime, bSugarBefore;
  final Map foodMap;
  FoodIntakeSummaryPending({Key key, @required this.selectedDate, this.selectedTime, this.foodMap, this.bSugarBefore}) : super(key: key);
  @override
  _FoodIntakeSummaryPendingState createState() => _FoodIntakeSummaryPendingState();
}

class _FoodIntakeSummaryPendingState extends State<FoodIntakeSummaryPending> {
  MyApp main = MyApp();
  Map food;
  List<dynamic> foodName = List<dynamic>();
  List<dynamic> foodQty = List<dynamic>();
  final User user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    Map food = widget.foodMap;
    foodName = food.keys.toList();
    foodQty = food.values.toList();
    print(foodName);
    print(foodQty);
  }

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Channel Id',
      'Channel title',
      'channel body',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.zonedSchedule(
        0, 'Food Intake Tracking', 'It\'s time to update your blood sugar level.', tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)), notificationDetails,
        androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future notificationSelected(String payLoad) async {
    //await Navigator.push(
    //context,
    //MaterialPageRoute<void>(builder: (context) => FoodIntakeListPending()),
    //);
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
      body: SingleChildScrollView(
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
                            widget.selectedDate,
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
                            widget.selectedTime,
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
                                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015),
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
                                    widget.bSugarBefore + " mmol/L",
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
                    onTap: () async {
                      addFoodRecord(user.uid, widget.selectedDate, widget.selectedTime, widget.bSugarBefore, widget.foodMap);
                      _showNotification();
                    }, //ADD TO DATABASE
                  ),
                ],
              ),
            ),
          ],
        ),
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

  Future<void> addFoodRecord(motherID, selectedDate, selectedTime, bsBefore, foodMap) {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("foodIntake_Pending");
    return foodIntakeRecord.add({
      "motherID": motherID,
      "selectedDate":selectedDate,
      "selectedTime": selectedTime,
      "bsBefore": bsBefore,
      "bsAfter": null,
      "foodMap": foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeMain()));
      //_showNotification();
    }).catchError((error) => print("wrong"));
  }
}
