import "package:flutter/material.dart";
import "appointmentMother_build.dart";

class AppointmentMotherAdd1 extends StatefulWidget {
  final String name;

  AppointmentMotherAdd1({this.name});

  @override
  _AppointmentMotherAdd1State createState() => _AppointmentMotherAdd1State(name);
}

class _AppointmentMotherAdd1State extends State<AppointmentMotherAdd1> {
  final String name;

  _AppointmentMotherAdd1State(this.name);

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
      body: Column(
        children: <Widget>[
          Container(
              //color: Colors.lightBlue,
              height: MediaQuery.of(context).size.height * 0.7,
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HospitalRow("KPJ Kuching Specialist Hospital"),
                    HospitalRow("Long many words debugging long long material page example this is"),
                    HospitalRow("Hospital 3"),
                    HospitalRow("Hospital 4"),
                    HospitalRow("Hospital 5"),
                    HospitalRow("Hospital 6"),
                    HospitalRow("Hospital 7"),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
