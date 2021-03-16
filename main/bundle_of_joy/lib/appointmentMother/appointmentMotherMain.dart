import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:flutter/material.dart';

import 'appointmentMother_add_full.dart';
import 'appointmentMother_recordList.dart';

class AppointmentMotherMain extends StatefulWidget {
  @override
  _AppointmentMotherMainState createState() => _AppointmentMotherMainState();
}

class _AppointmentMotherMainState extends State<AppointmentMotherMain> {
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
                        MaterialPageRoute(builder: (context) => AppointmentMotherRecordList()),
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
                        MaterialPageRoute(builder: (context) => AppointmentMotherAddFull()),
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