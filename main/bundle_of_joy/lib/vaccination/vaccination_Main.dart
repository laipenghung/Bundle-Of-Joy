import 'package:bundle_of_joy/vaccination/vaccination_Record.dart';
import 'package:bundle_of_joy/vaccination/vaccination_Schedule.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VaccinationScheduleTrackingMain extends StatefulWidget {
  final String selectedBabyID;
  VaccinationScheduleTrackingMain({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _VaccinationScheduleTrackingMainState createState() => _VaccinationScheduleTrackingMainState();
}

class _VaccinationScheduleTrackingMainState extends State<VaccinationScheduleTrackingMain> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Vaccination Schedule & Tracking",
          style: TextStyle(
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              HorizontalCardWidget(
                title: "Baby Vaccination Schedule",
                description: "View all of your baby's upcoming vaccination schedule assigned by doctor.",
                svgSrc: "assets/icons/vaccination.svg",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VaccinationSchedule(selectedBabyID: widget.selectedBabyID)));
                },
              ),
              HorizontalCardWidget(
                title: "Baby Vaccination Records",
                description: "View all vaccines taken by your baby.",
                svgSrc: "assets/icons/records.svg",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Vaccination(selectedBabyID: widget.selectedBabyID)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
