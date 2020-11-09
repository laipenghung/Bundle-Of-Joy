import 'package:bundle_of_joy/careForBaby/careForBabyTab.dart';
import 'package:bundle_of_joy/mother-for-baby.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:quiver/iterables.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../main.dart';

class BabyFoodIntakeSummary extends StatefulWidget {
  final String selectedBabyID, selectedDate, selectedTime;
  final Map foodMap;
  BabyFoodIntakeSummary({Key key, this.selectedBabyID, this.selectedDate, this.selectedTime, this.foodMap}) : super(key: key);

  @override
  _BabyFoodIntakeSummaryState createState() => _BabyFoodIntakeSummaryState();
}

class _BabyFoodIntakeSummaryState extends State<BabyFoodIntakeSummary> {
  MyApp main = MyApp();
  Map food;
  List<dynamic> foodName = List<dynamic>();
  List<dynamic> foodQty = List<dynamic>();

  void initState() {
    super.initState();
    Map food = widget.foodMap;
    foodName = food.keys.toList();
    foodQty = food.values.toList();
    print(widget.selectedBabyID);
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

  Future<void> addBabyFoodRecord() {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference foodIntakeRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Pending");
    return foodIntakeRecord.add({
      "motherID": user.uid,
      "selectedDate": widget.selectedDate,
      "selectedTime": widget.selectedTime,
      "foodMap": widget.foodMap,
    }).then((value) {
      foodIntakeRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyTab(selectedBabyID: widget.selectedBabyID)));
    }).catchError((error) => print("wrong"));
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
        0, 'Food Intake Tracking', 'It\'s time to update your baby\'s food intake record.', tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)), notificationDetails,
        androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
            //color: Colors.lightBlue,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.02),
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
                  ],
                ),
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
                    addBabyFoodRecord();
                    _showNotification();
                  }, //ADD TO DATABASE
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
