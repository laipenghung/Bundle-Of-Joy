import "package:flutter/material.dart";
import "appointmentMother_build.dart";
import "appointmentMother_0.dart";
import "appointmentMother_2.dart";
import "appointmentMother_3.dart";

class AppointmentMother1 extends StatefulWidget {
  final String name;

  AppointmentMother1({this.name});

  @override
  _AppointmentMother1State createState() => _AppointmentMother1State(name);
}

class _AppointmentMother1State extends State<AppointmentMother1> {
  final String name;

  _AppointmentMother1State(this.name);

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
              height: MediaQuery.of(context).size.height * 0.63,
              // decoration: new BoxDecoration(color: Colors.red), // FOR DEBUGGING

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    HospitalRow("KPJ Kuching Specialist Hospital"),
                    HospitalRow(
                        "Long many words debugging long long material page example this is"),
                    HospitalRow("Hospital 3"),
                    HospitalRow("Hospital 4"),
                    HospitalRow("Hospital 5"),
                    HospitalRow("Hospital 6"),
                    HospitalRow("Hospital 7"),
                  ],
                ),
              )),

          // PAGINATION DOTS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1
              Container(
                  width: 15,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.black,
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),

              // 2
              Container(
                  width: 15,
                  margin: EdgeInsets.only(left: 20),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AppointmentMother2(name: "Not Selected")),
                      );
                    },
                    fillColor: Color(0xFFFCFFD5),
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),

              // 3
              Container(
                  width: 15,
                  margin: EdgeInsets.only(left: 20),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentMother3(
                                  name: "Not Selected",
                                )),
                      );
                    },
                    fillColor: Color(0xFFFCFFD5),
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),

              // 4
              Container(
                  width: 15,
                  margin: EdgeInsets.only(left: 20),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentMother0()),
                      );
                    },
                    fillColor: Color(0xFFFCFFD5),
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
