import "package:flutter/material.dart";
import 'appointmentBaby_add_1.dart';
import 'appointmentBaby_add_3.dart';

import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class AppointmentBabyAdd2 extends StatefulWidget {
  final String name;
  final String babyID;

  AppointmentBabyAdd2({this.name, this.babyID});

  @override
  _AppointmentBabyAdd2State createState() => _AppointmentBabyAdd2State(name, babyID);
}

class _AppointmentBabyAdd2State extends State<AppointmentBabyAdd2> {
  // VARIABLES
  final String hospitalName;
  final String babyID;
  DateTime pickedDate;
  String d, m, y, dateToPass;

  // MAKE THE DEFAULT DATE TODAY
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    if (pickedDate.day < 10)
      d = "0${pickedDate.day}";
    else
      d = "${pickedDate.day}";

    if (pickedDate.month < 10)
      m = "0${pickedDate.month}";
    else
      m = "${pickedDate.month}";

    y = "${pickedDate.year}";

    dateToPass = y + "-" + m + "-" + d;
  }

  _AppointmentBabyAdd2State(this.hospitalName, this.babyID);

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
      body: Column(
        children: <Widget>[
          Container(
              // color: Colors.lightBlue,
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Hospital Selected",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.07,
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                        decoration: myBoxDecoration(),
                        child: Center(
                          child: Text(
                            hospitalName,
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07, left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Select a date",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.height * 0.07,
                                decoration: myBoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      dateToPass,
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
                              onTap: () {
                                _pickDate();
                              }),
                        ],
                      ),
                    ),
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
                    MaterialPageRoute(builder: (context) => AppointmentBabyAdd1(babyID: babyID)),
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
                      "Next",
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
                  _checkAppointment();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _checkAppointment() async{
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var x = await _db.collection('baby_appointment').where("m_id", isEqualTo: user.uid)
      .where("b_id", isEqualTo: widget.babyID).where("a_date", isEqualTo: dateToPass).get();

    if(x.docs.isEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppointmentBabyAdd3(name: hospitalName, 
          date: dateToPass, babyID: babyID,)),);
    }else{
      return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Opps!"),
          content: Text("You already have an appointment on $dateToPass. Please select another day to book an appointment or delete the current appointment."),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
    }
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(primarySwatch: Colors.pink, splashColor: Colors.green),
          child: child,
        );
      },
    );

    if (date != null) {
      setState(() {
        pickedDate = date;

        if (pickedDate.day < 10)
          d = "0${pickedDate.day}";
        else
          d = "${pickedDate.day}";

        if (pickedDate.month < 10)
          m = "0${pickedDate.month}";
        else
          m = "${pickedDate.month}";

        y = "${pickedDate.year}";

        dateToPass = y + "-" + m + "-" + d;
      });
    }
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
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }
}
