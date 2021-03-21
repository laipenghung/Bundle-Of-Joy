import 'package:fa_stepper/fa_stepper.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "appointmentMother_add_hospital.dart";
import "appointmentMother_add_doctor.dart";
import "appointmentMother_add_date.dart";

class AppointmentMotherAddFull extends StatefulWidget {
  final String hospital;

  AppointmentMotherAddFull({this.hospital});

  @override
  _AppointmentMotherAddFullState createState() => _AppointmentMotherAddFullState(hospital);
}

class _AppointmentMotherAddFullState extends State<AppointmentMotherAddFull> {
  final User user = FirebaseAuth.instance.currentUser;
  final String hospital;
  int selectedIndex;

  _AppointmentMotherAddFullState(this.hospital);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
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

        //automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SELECT HOSPITAL /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
                        "Select a hospital",
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
                height: MediaQuery.of(context).size.height * 0.3,
                child: AppointmentMotherAddHospital(),
              ),

              // SELECT DOCTOR /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
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
                        "Select a doctor",
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
                height: MediaQuery.of(context).size.height * 0.3,
                child: AppointmentMotherAddDoctor(),
              ),

              // SELECT DATE /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
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
                        "Select a date",
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
              AppointmentMotherAddDate(),
              // SELECT TIME /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
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
                        "Select a time",
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
            ],
          ),
        ),
      ),
    );
  }
}
