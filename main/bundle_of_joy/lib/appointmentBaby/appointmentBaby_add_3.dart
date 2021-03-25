import "package:flutter/material.dart";
import 'appointmentBaby_add_2.dart';
import 'appointmentBaby_main.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import 'package:bundle_of_joy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class AppointmentBabyAdd3 extends StatefulWidget {
  final String name;
  final String date;
  final String babyID;

  AppointmentBabyAdd3({this.name, this.date, this.babyID});

  @override
  _AppointmentBabyAdd3State createState() => _AppointmentBabyAdd3State(name, date, babyID);
}

class _AppointmentBabyAdd3State extends State<AppointmentBabyAdd3> {
  // VARIABLES
  MyApp main = MyApp();

  String nameFrom2;
  String dateFrom2;
  String babyID;
  String _amColor, _pmColor, _eveColor, session;
  String selectedSession;
  bool hasRecord = false;

  _AppointmentBabyAdd3State(this.nameFrom2, this.dateFrom2, this.babyID);

  @override
  void initState() {
    super.initState();
    //if (dateFrom2 == null) {
    //dateFrom2 = DateTime.now();
    //}

    _amColor = "on";
    _pmColor = "off";
    _eveColor = "off";
    session = "Morning Session";
    selectedSession = "Morning";
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Text(
            "Appointment Management",
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
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('appointment_slot').where("date_string", isEqualTo: dateFrom2).snapshots(),
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
                    'There is currently no slot on this date',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: <Widget>[
                    Container(
                        //color: Colors.lightBlue,
                        height: MediaQuery.of(context).size.height * 0.63,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                              Container(
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.85,
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      decoration: myBoxDecoration2(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dateFrom2,
                                            style: TextStyle(
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.height * 0.025,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.width * 0.05),
                                            child: Image.asset(
                                              "assets/icons/calendar.png",
                                              height: MediaQuery.of(context).size.height * 0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.85,
                                      height: MediaQuery.of(context).size.height * 0.07,
                                      decoration: myBoxDecoration2(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            session,
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
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: myBoxDecorationAM(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/icons/am.png",
                                              height: MediaQuery.of(context).size.height * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _amColor = "on";
                                        _pmColor = "off";
                                        _eveColor = "off";
                                        session = "Morning Session";
                                        selectedSession = "Morning";
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.07,
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: myBoxDecorationPM(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/icons/pm.png",
                                              height: MediaQuery.of(context).size.height * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _amColor = "off";
                                        _pmColor = "on";
                                        _eveColor = "off";
                                        session = "Afternoon Session";
                                        selectedSession = "Afternoon";
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.07,
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.2,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: myBoxDecorationEVE(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/icons/night.png",
                                              height: MediaQuery.of(context).size.height * 0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _amColor = "off";
                                        _pmColor = "off";
                                        _eveColor = "on";
                                        session = "Evening Session";
                                        selectedSession = "Evening";
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                                child: Text(
                                  "Remaining Slot(s):",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.028,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Builder(builder: (context) {
                                if (selectedSession == "Morning") {
                                  return Builder(builder: (context) {
                                    if (snapshot.data.documents[0]['s_available_Morning'] < 6) {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Morning'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.15,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Morning'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                } else if (selectedSession == "Afternoon") {
                                  return Builder(builder: (context) {
                                    if (snapshot.data.documents[0]['s_available_Afternoon'] < 6) {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Afternoon'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.15,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Afternoon'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  return Builder(builder: (context) {
                                    if (snapshot.data.documents[0]['s_available_Evening'] < 6) {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Evening'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.15,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Evening'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                }
                              }),
                            ],
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: myBoxDecoration2(),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppointmentBabyAdd2(name: nameFrom2)),
                            );
                          },
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: myBoxDecoration2(),
                            child: Center(
                              child: Text(
                                "Confirm",
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
                            if (selectedSession == "Morning") {
                              if (snapshot.data.documents[0]['s_available_Morning'] == 0) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Slot Empty"),
                                        content: Text("Hi, there is currently no more slot for this session at this day, please try another session or another date :D"),
                                        actions: <Widget>[
                                          RaisedButton(
                                            child: Text("Ok"),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                uploadAppointment(snapshot.data.documents[0]['date_string'], selectedSession, snapshot.data.documents[0]['d_id'],
                                    snapshot.data.documents[0]['s_id'], babyID);
                                _showNotification();
                              }
                            } else if (selectedSession == "Afternoon") {
                              if (snapshot.data.documents[0]['s_available_Afternoon'] == 0) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Slot Empty"),
                                        content: Text("Hi, there is currently no slot for this session at this day, please try another session or another date :D"),
                                        actions: <Widget>[
                                          RaisedButton(
                                            child: Text("Ok"),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                uploadAppointment(snapshot.data.documents[0]['date_string'], selectedSession, snapshot.data.documents[0]['d_id'],
                                    snapshot.data.documents[0]['s_id'], babyID);
                                _showNotification();
                              }
                            } else if (selectedSession == "Evening") {
                              if (snapshot.data.documents[0]['s_available_Evening'] == 0) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Slot Empty"),
                                        content: Text("Hi, there is currently no slot for this session at this day, please try another session or another date :D"),
                                        actions: <Widget>[
                                          RaisedButton(
                                            child: Text("Ok"),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                uploadAppointment(snapshot.data.documents[0]['date_string'], selectedSession, snapshot.data.documents[0]['d_id'],
                                    snapshot.data.documents[0]['s_id'], babyID);
                                _showNotification();
                              }
                            } else {
                              print("THIS IS BROKEN");
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              print("Snapshot has error");
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
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

  BoxDecoration myBoxDecorationAM() {
    return BoxDecoration(
      color: _amColor == "on" ? Color(0xFFFCFFD5) : Colors.white,
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  BoxDecoration myBoxDecorationPM() {
    return BoxDecoration(
      color: _pmColor == "on" ? Color(0xFFFCFFD5) : Colors.white,
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  BoxDecoration myBoxDecorationEVE() {
    return BoxDecoration(
      color: _eveColor == "on" ? Color(0xFFFCFFD5) : Colors.white,
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  Future<void> uploadAppointment(appointmentDate, appointmentSession, doctorID, slotID, babyID) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;

    CollectionReference appointmentRecord = _db.collection("baby_appointment");
    CollectionReference slotRecord = _db.collection("appointment_slot");

    return appointmentRecord.add({
      "a_date": appointmentDate,
      "a_session": appointmentSession,
      "b_id": babyID,
      "d_id": doctorID,
      "s_id": slotID,
      "m_id": user.uid,
    }).then((value) {
      appointmentRecord.doc(value.id).update({
        "a_id": value.id,
      }).then((value) {
        slotRecord.doc(slotID).update({
          if (appointmentSession == "Morning") "s_available_Morning": FieldValue.increment(-1),
          if (appointmentSession == "Afternoon") "s_available_Afternoon": FieldValue.increment(-1),
          if (appointmentSession == "Evening") "s_available_Evening": FieldValue.increment(-1),
        }).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentBabyMain(babyID: babyID)));
        });
      });
      print("Data uploaded");
    }).catchError((error) => print("Something is wrong here"));
  }

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
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
          'Appointment Management - Baby',
          'You have succesfully booked a slot for ' + dateFrom2 + ".",
          notificationDetails,
        );
  }
}
