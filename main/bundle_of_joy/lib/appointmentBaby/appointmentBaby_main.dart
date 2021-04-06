import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:flutter/material.dart';
import 'appointmentBaby_add.dart';
import 'appointmentBaby_recordList.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';

class AppointmentBabyMain extends StatefulWidget {
  final String babyID;

  AppointmentBabyMain({this.babyID});

  @override
  _AppointmentBabyMainState createState() => _AppointmentBabyMainState(babyID);
}

class _AppointmentBabyMainState extends State<AppointmentBabyMain> {
  final String babyID;

  _AppointmentBabyMainState(this.babyID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
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
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              HorizontalCardWidget(
                  title: "View Appointment",
                  description: "View and manage your baby's appointments.",
                  svgSrc: "assets/icons/schedule.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentBabyRecordList(babyID: babyID)),
                    );
                  }),
              HorizontalCardWidget(
                  title: "Book An Appointment",
                  description: "Book an appointment with the doctor for your baby.",
                  svgSrc: "assets/icons/appointment.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentBabyAdd(babyID: babyID)),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
