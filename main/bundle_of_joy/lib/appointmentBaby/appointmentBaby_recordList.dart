import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import 'package:bundle_of_joy/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

import 'package:flutter_svg/svg.dart';

class AppointmentBabyRecordList extends StatefulWidget {
  final String babyID;

  AppointmentBabyRecordList({this.babyID});

  @override
  _AppointmentBabyRecordListState createState() => _AppointmentBabyRecordListState(babyID);
}

class _AppointmentBabyRecordListState extends State<AppointmentBabyRecordList> {
  final String babyID;
  _AppointmentBabyRecordListState(this.babyID);

  MyApp main = MyApp();
  final User user = FirebaseAuth.instance.currentUser;
  DateTime today = DateTime.now();
  String d, m, y, completeDate;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    if (today.day < 10)
      d = "0${today.day}";
    else
      d = "${today.day}";

    if (today.month < 10)
      m = "0${today.month}";
    else
      m = "${today.month}";

    y = "${today.year}";

    completeDate = y + "-" + m + "-" + d;
  }

  Future<void> deleteSelected(appointmentID) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    return _db.collection("baby_appointment").doc(appointmentID).delete();
  }

  Future<void> updateSlotCount(slotID, sessionForThisRecord, dateForThisRecord) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    CollectionReference slotRecord = _db.collection("appointment_slot");

    return slotRecord.doc(slotID).update({
      if (sessionForThisRecord == "Morning") "s_available_Morning": FieldValue.increment(1),
      if (sessionForThisRecord == "Afternoon") "s_available_Afternoon": FieldValue.increment(1),
      if (sessionForThisRecord == "Evening") "s_available_Evening": FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointment Management",
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('baby_appointment')
            .where("b_id", isEqualTo: babyID)
            .where("a_date", isGreaterThanOrEqualTo: completeDate)
            .orderBy("a_date", descending: true)
            .orderBy("a_session", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Colors.black,
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                  ),
                ),
              );
            } else if (snapshot.data.documents.isEmpty) {
              return Center(
                child: Text(
                  'You have no upcoming appointment.',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black.withOpacity(0.65),
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(15, 15),
                              blurRadius: 20,
                              spreadRadius: 15,
                              color: Color(0xFFE6E6E6),
                            ),
                          ],
                        ),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  child: Center(
                                    child: SvgPicture.asset("assets/icons/schedule.svg", height: 40, width: 40),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 7,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                "Hospital",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.036,
                                                  color: Colors.black.withOpacity(0.65),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                snapshot.data.documents[index]["h_name"],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.043,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                                              width: double.infinity,
                                              child: Text(
                                                "Doctor",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.036,
                                                  color: Colors.black.withOpacity(0.65),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                snapshot.data.documents[index]["d_name"],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.043,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                                              width: double.infinity,
                                              child: Text(
                                                "Date",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.036,
                                                  color: Colors.black.withOpacity(0.65),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                snapshot.data.documents[index]["a_date"],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.043,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005),
                                              width: double.infinity,
                                              child: Text(
                                                "Session",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.036,
                                                  color: Colors.black.withOpacity(0.65),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                snapshot.data.documents[index]["a_session"],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context).size.width * 0.043,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                      child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      deleteSelected(snapshot.data.documents[index]["a_id"]);
                                      updateSlotCount(snapshot.data.documents[index]["s_id"], snapshot.data.documents[index]["a_session"], snapshot.data.documents[index]["a_date"]);
                                    },
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } else if (snapshot.hasError) {
            print("error");
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Colors.black,
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showNotification(date) async {
    await notification(date);
  }

  Future<void> notification(date) async {
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
          0,
          'Appointment Management',
          'A booking at ' + date + ' was deleted.',
          notificationDetails,
        );
  }
}
