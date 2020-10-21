import "package:flutter/material.dart";
import "appointmentMother_add_2.dart";
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

  _AppointmentMotherAdd3State(this.nameFrom2, this.dateFrom2);

  @override
  void initState() {
    super.initState();
    //if (dateFrom2 == null) {
    //dateFrom2 = DateTime.now();
    //}

    _amColor = 1;
    _pmColor = 2;
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR
        appBar: AppBar(
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
            return Column(
              children: <Widget>[
                Container(
                    //color: Colors.lightBlue,
                    height: MediaQuery.of(context).size.height * 0.58,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                          Container(
                            //color: Colors.lightBlue,
                            height: MediaQuery.of(context).size.height * 0.04,
                            width: MediaQuery.of(context).size.width * 0.8,

                            child: Text(
                              nameFrom2,
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03, bottom: MediaQuery.of(context).size.height * 0.05),
                            child: Text(
                              "${dateFrom2.day} - ${dateFrom2.month} - ${dateFrom2.year}",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.028,
                                color: Colors.black,
                              ),
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
                      onTap: () {},
                    ),
                  ],
                ),
              ],
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
}
