import 'package:bundle_of_joy/careForBaby/babyTemp/babyTemptMain.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quiver/iterables.dart';

import '../../main.dart';
import '../../mother-for-baby.dart';
import '../careForBabyTab.dart';

class BabyTempSummaryDone extends StatefulWidget {
  final String selectedDate, selectedTime, bTempBefore, bTempAfter, selectedBabyID;
  final Map medsMap;
  BabyTempSummaryDone({Key key, @required this.selectedDate, this.selectedTime, this.bTempBefore, this.bTempAfter, this.selectedBabyID, this.medsMap}) : super(key: key);

  @override
  BabyTempSummaryDoneState createState() => BabyTempSummaryDoneState();
}

class BabyTempSummaryDoneState extends State<BabyTempSummaryDone> {
  MyApp main = MyApp();
  Map meds = Map();
  List<dynamic> medsName = List<dynamic>();

  void initState() {
    super.initState();
    meds = widget.medsMap;
    medsName = meds.values.toList();
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

  Future<void> addTempRecord() {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference babyTempRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Done");
    return babyTempRecord.add({
      "motherID": user.uid,
      "babyID": widget.selectedBabyID,
      "selectedDate": widget.selectedDate,
      "selectedTime": widget.selectedTime,
      "bTempBefore": widget.bTempBefore,
      "bTempAfter": widget.bTempAfter,
      "medsMap": widget.medsMap,
    }).then((value) {
      babyTempRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CareForBabyTab(selectedBabyID: widget.selectedBabyID)));
    }).catchError((error) => print(error));
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Medicine Intake Tracking",
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
                        width: MediaQuery.of(context).size.width * 0.4,
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
                        width: MediaQuery.of(context).size.width * 0.4,
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
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.02,
                        ),
                        child: Image.asset(
                          "assets/icons/medicine.png",
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09),
                            child: Table(
                              //border: TableBorder.all(width: 1.0, color: Colors.black),
                              children: [
                                for (var x in medsName)
                                  TableRow(children: [
                                    TableCell(
                                        child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
                                          //color: Colors.blue,
                                          child: new Text(
                                            "- ",
                                            style: TextStyle(
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.height * 0.023,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
                                          //color: Colors.blue,
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: new Text(
                                            x.toString(),
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icons/temp.png",
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    "Before: ",
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.bTempBefore + " °C",
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: MediaQuery.of(context).size.height * 0.02),
                            child: Row(
                              children: [
                                Container(
                                  //color: Colors.lightBlue,
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    "After: ",
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.bTempAfter + " °C",
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
                    addTempRecord();
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
