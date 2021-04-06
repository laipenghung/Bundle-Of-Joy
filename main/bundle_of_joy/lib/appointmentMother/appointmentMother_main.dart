import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:flutter/material.dart';
import 'appointmentMother_add.dart';
import 'appointmentMother_recordList.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';

class AppointmentMotherMain extends StatefulWidget {
  @override
  _AppointmentMotherMainState createState() => _AppointmentMotherMainState();
}

class _AppointmentMotherMainState extends State<AppointmentMotherMain> {
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
        backgroundColor: appbar1,
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
                  description: "View and manage all of your appointments.",
                  svgSrc: "assets/icons/schedule.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentMotherRecordList()),
                    );
                  }),
              HorizontalCardWidget(
                  title: "Book An Appointment",
                  description: "Book an appointment with the doctor.",
                  svgSrc: "assets/icons/appointment.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentMotherAdd()),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
