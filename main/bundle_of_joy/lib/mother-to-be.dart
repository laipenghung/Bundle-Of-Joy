import "package:flutter/material.dart";
import "profile.dart";
import "appointmentMother.dart";
import "./emergencyContact/emergencyContactTab.dart";

class MotherToBeTab extends StatefulWidget {
  @override
  _MotherToBeTabState createState() => _MotherToBeTabState();
}

class _MotherToBeTabState extends State<MotherToBeTab> {
  //int _index = 0;

  @override
  Widget build(BuildContext context) {
    singleCard(iconLoc, title, index) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        color: Color(0xFFFCFFD5),
        child: InkWell(
          onTap: () {
            switch (index) {
              case 0:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentMother()),
                  );
                }
                break;
              case 1:
                {
                  print("2");
                }
                break;
              case 2:
                {
                  print("3");
                }
                break;
              case 3:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergencyContactTab()),
                  );
                }
                break;
            }
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 20.0),
                child: Icon(
                  IconData(iconLoc, fontFamily: "MaterialIcons"),
                  color: Colors.black,
                  size: 85.0,
                ),
              ),

              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: <Widget>[
        singleCard(57744, "Appointment Management", 0),
        singleCard(57744, "Food Intake Tracking", 1),
        singleCard(57744, "Health Tracking", 2),
        singleCard(57744, "Emergency Contact", 3),
      ],
    ));
  }
}
