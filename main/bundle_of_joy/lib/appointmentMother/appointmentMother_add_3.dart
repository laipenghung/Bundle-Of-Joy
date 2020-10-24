import "package:flutter/material.dart";
import "appointmentMother_add_2.dart";
import "appointmentMother_main.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class AppointmentMotherAdd3 extends StatefulWidget {
  final String name;
  final DateTime date;

  AppointmentMotherAdd3({this.name, this.date});

  @override
  _AppointmentMotherAdd3State createState() => _AppointmentMotherAdd3State(name, date);
}

class _AppointmentMotherAdd3State extends State<AppointmentMotherAdd3> {
  // VARIABLES
  String nameFrom2;
  DateTime dateFrom2;
  int _amColor, _pmColor;
  String selectedSession;
  bool hasRecord = false;

  _AppointmentMotherAdd3State(this.nameFrom2, this.dateFrom2);

  @override
  void initState() {
    super.initState();
    //if (dateFrom2 == null) {
    //dateFrom2 = DateTime.now();
    //}

    _amColor = 1;
    _pmColor = 2;
    selectedSession = "AM";
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
          stream: FirebaseFirestore.instance
              .collection('appointment_slot')
              .where("date_string", isEqualTo: "${dateFrom2.year.toString()}-${dateFrom2.month.toString()}-${dateFrom2.day.toString()}")
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
                                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),
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
                                            "${dateFrom2.day} - ${dateFrom2.month} - ${dateFrom2.year}",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      decoration: myBoxDecorationAM(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "A.M.",
                                            style: TextStyle(
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.height * 0.025,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                                            child: Image.asset(
                                              "assets/icons/am.png",
                                              height: MediaQuery.of(context).size.height * 0.03,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _amColor = 1;
                                        _pmColor = 2;
                                        selectedSession = "AM";
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.08,
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      decoration: myBoxDecorationPM(),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "P.M.",
                                            style: TextStyle(
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.height * 0.025,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                                            child: Image.asset("assets/icons/pm.png", height: MediaQuery.of(context).size.height * 0.03),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _amColor = 2;
                                        _pmColor = 1;
                                        selectedSession = "PM";
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
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
                                if (_amColor == 1 && _pmColor == 2) {
                                  return Builder(builder: (context) {
                                    if (snapshot.data.documents[0]['s_available_AM'] < 6) {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_AM'].toString(),
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
                                          snapshot.data.documents[0]['s_available_AM'].toString(),
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
                                    if (snapshot.data.documents[0]['s_available_PM'] < 6) {
                                      return Container(
                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.035),
                                        child: Text(
                                          snapshot.data.documents[0]['s_available_PM'].toString(),
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
                                          snapshot.data.documents[0]['s_available_PM'].toString(),
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
                              MaterialPageRoute(builder: (context) => AppointmentMotherAdd2(name: nameFrom2)),
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
                            if (selectedSession == "AM") {
                              if (snapshot.data.documents[0]['s_available_AM'] == 0) {
                                //print("AM No Slot");
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
                              }
                            } else if (selectedSession == "PM") {
                              if (snapshot.data.documents[0]['s_available_PM'] == 0) {
                                //print("PM No Slot");
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
      color: _amColor == 1 ? Color(0xFFFCFFD5) : Colors.white,
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  BoxDecoration myBoxDecorationPM() {
    return BoxDecoration(
      color: _pmColor == 1 ? Color(0xFFFCFFD5) : Colors.white,
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
          if (appointmentSession == "AM") "s_available_AM": FieldValue.increment(-1),
          if (appointmentSession == "PM") "s_available_PM": FieldValue.increment(-1),
        }).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentMotherMain()));
        });
      });
      print("Data uploaded");
    }).catchError((error) => print("Something is wrong here"));
  }
}
