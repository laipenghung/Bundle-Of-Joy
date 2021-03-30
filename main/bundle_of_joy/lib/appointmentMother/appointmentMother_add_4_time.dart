import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import "package:flutter/material.dart";
import 'package:bundle_of_joy/main.dart';
import 'appointmentMother_Main.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class AppointmentMotherAddTime extends StatefulWidget {
  final String hospitalName, doctorName, date;

  AppointmentMotherAddTime({this.hospitalName, this.doctorName, this.date});

  @override
  _AppointmentMotherAddTimeState createState() => _AppointmentMotherAddTimeState(hospitalName, doctorName, date);
}

class _AppointmentMotherAddTimeState extends State<AppointmentMotherAddTime> {
  final String hospitalName, doctorName, date;
  _AppointmentMotherAddTimeState(this.hospitalName, this.doctorName, this.date);

  // VARIABLES
  MyApp main = MyApp();

  String _amColor, _pmColor, _eveColor, session;
  String selectedSession;
  bool hasRecord = false;

  @override
  void initState() {
    super.initState();

    _amColor = "on";
    _pmColor = "off";
    _eveColor = "off";
    session = "Morning Session";
    selectedSession = "Morning";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR
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

        // BODY
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('appointment_slot').where("date_string", isEqualTo: date).snapshots(),
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
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Expanded(
                              child: Divider(
                                indent: MediaQuery.of(context).size.width * 0.0,
                                endIndent: MediaQuery.of(context).size.width * 0.0,
                                color: Colors.black,
                                thickness: MediaQuery.of(context).size.height * 0.0015,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              "Hospital Selected",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: MediaQuery.of(context).size.height * 0.0015,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          hospitalName,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.018,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Expanded(
                              child: Divider(
                                indent: MediaQuery.of(context).size.width * 0.0,
                                endIndent: MediaQuery.of(context).size.width * 0.0,
                                color: Colors.black,
                                thickness: MediaQuery.of(context).size.height * 0.0015,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              "Doctor Selected",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: MediaQuery.of(context).size.height * 0.0015,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          doctorName,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.018,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Expanded(
                              child: Divider(
                                indent: MediaQuery.of(context).size.width * 0.0,
                                endIndent: MediaQuery.of(context).size.width * 0.0,
                                color: Colors.black,
                                thickness: MediaQuery.of(context).size.height * 0.0015,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              "Date selected",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: MediaQuery.of(context).size.height * 0.0015,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          date,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.018,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Expanded(
                              child: Divider(
                                indent: MediaQuery.of(context).size.width * 0.0,
                                endIndent: MediaQuery.of(context).size.width * 0.0,
                                color: Colors.black,
                                thickness: MediaQuery.of(context).size.height * 0.0015,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                            child: Text(
                              "Select a session",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: MediaQuery.of(context).size.height * 0.0015,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                        child: Text(
                          session,
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.018,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: myBoxDecorationAM(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/icons/am.png",
                                              height: MediaQuery.of(context).size.height * 0.035,
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
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: myBoxDecorationPM(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/icons/pm.png",
                                              height: MediaQuery.of(context).size.height * 0.035,
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
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      decoration: myBoxDecorationEVE(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Image.asset(
                                              "assets/icons/night.png",
                                              height: MediaQuery.of(context).size.height * 0.030,
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
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                                child: Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                                  child: Text(
                                    "Remaining Slot(s):",
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.height * 0.018,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Builder(builder: (context) {
                                if (selectedSession == "Morning") {
                                  return Builder(builder: (context) {
                                    if (snapshot.data.documents[0]['s_available_Morning'] < 6) {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Morning'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Morning'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.1,
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
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Afternoon'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Afternoon'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.1,
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
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Evening'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.1,
                                            color: Colors.red,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_Evening'].toString(),
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.1,
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: myBoxDecoration2(),
                              child: Center(
                                child: Text(
                                  "Back",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.02,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          InkWell(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: myBoxDecoration2(),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.02,
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
                                  uploadAppointment(
                                      snapshot.data.documents[0]['date_string'], selectedSession, snapshot.data.documents[0]['d_id'], snapshot.data.documents[0]['s_id']);
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
                                  uploadAppointment(
                                      snapshot.data.documents[0]['date_string'], selectedSession, snapshot.data.documents[0]['d_id'], snapshot.data.documents[0]['s_id']);
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
                                  uploadAppointment(
                                      snapshot.data.documents[0]['date_string'], selectedSession, snapshot.data.documents[0]['d_id'], snapshot.data.documents[0]['s_id']);
                                  _showNotification();
                                }
                              } else {
                                print("THIS IS BROKEN");
                              }
                            },
                          ),
                        ],
                      ),
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
        width: 1.0,
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

  Future<void> uploadAppointment(appointmentDate, appointmentSession, doctorID, slotID) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;

    CollectionReference appointmentRecord = _db.collection("mother_appointment");
    CollectionReference slotRecord = _db.collection("appointment_slot");

    return appointmentRecord.add({
      "a_date": appointmentDate,
      "a_session": appointmentSession,
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentMotherMain()));
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
          'Appointment Management - Mother',
          'You have succesfully booked a slot for ' + date + ".",
          notificationDetails,
        );
  }
}
