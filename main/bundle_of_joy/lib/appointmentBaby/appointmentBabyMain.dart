import 'package:bundle_of_joy/appointmentMother/appointmentMother_recordList.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:flutter/material.dart';

import 'appointmentBaby_add_1.dart';
import 'appointmentBaby_recordList.dart';

class AppointmentBabyMain extends StatefulWidget {
  final String babyID;
  AppointmentBabyMain({this.babyID});
  
  @override
  _AppointmentBabyMainState createState() => _AppointmentBabyMainState();
}

class _AppointmentBabyMainState extends State<AppointmentBabyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: true,
            pinned: true,
            stretch: true,
            stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                  "Appointment Management",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
              background: Image.network(
                "https://static.vecteezy.com/system/resources/previews/000/171/284/original/free-hand-drawn-vector-nightscape-illustration.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  HorizontalCardWidget(
                    title: "View Appointments",
                    description: "View and manage all of your appointments.",
                    svgSrc: "assets/icons/Hamburger.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentBabyRecordList(babyID: widget.babyID)),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Create New Appoinment",
                    description: "Book an appointment with the doctor.",
                    svgSrc: "assets/icons/Hamburger.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentBabyAdd1(babyID: widget.babyID)),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}