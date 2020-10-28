import "package:flutter/material.dart";
import 'appointmentBaby_build.dart';

class AppointmentBabyAdd1 extends StatefulWidget {
  final String name;
  final String babyID;

  AppointmentBabyAdd1({this.name, this.babyID});

  @override
  _AppointmentBabyAdd1State createState() => _AppointmentBabyAdd1State(name, babyID);
}

class _AppointmentBabyAdd1State extends State<AppointmentBabyAdd1> {
  final String name;
  final String babyID;

  _AppointmentBabyAdd1State(this.name, this.babyID);

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

        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        //automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: Container(
          //color: Colors.lightBlue,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HospitalRow("KPJ Kuching Specialist Hospital", babyID),
              ],
            ),
          )),
    );
  }
}
