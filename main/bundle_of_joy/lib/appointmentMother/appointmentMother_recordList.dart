import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:bundle_of_joy/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class AppointmentMotherRecordList extends StatefulWidget {
  @override
  _AppointmentMotherRecordListState createState() => _AppointmentMotherRecordListState();
}

class _AppointmentMotherRecordListState extends State<AppointmentMotherRecordList> {
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

    return _db.collection("mother_appointment").doc(appointmentID).delete();
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
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('mother_appointment')
            .where("m_id", isEqualTo: user.uid)
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
                  'There is currently no records',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.22,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: "Delete",
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                deleteSelected(snapshot.data.documents[index]["a_id"]);
                                updateSlotCount(snapshot.data.documents[index]["s_id"], snapshot.data.documents[index]["a_session"], snapshot.data.documents[index]["a_date"]);
                                _showNotification(snapshot.data.documents[index]["a_date"]);
                              },
                            )
                          ],
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.015,
                                bottom: MediaQuery.of(context).size.height * 0.015,
                                left: MediaQuery.of(context).size.width * 0.07),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                  child: Image.asset(
                                    "assets/icons/appointment.png",
                                    height: MediaQuery.of(context).size.height * 0.06,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date:",
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      "Session:",
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data.documents[index]["a_date"],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      snapshot.data.documents[index]["a_session"],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.03,
                          endIndent: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black,
                          thickness: MediaQuery.of(context).size.height * 0.001,
                        ),
                      ],
                    );
                  },
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
