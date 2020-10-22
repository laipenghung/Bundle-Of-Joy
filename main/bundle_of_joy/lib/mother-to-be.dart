import "package:flutter/material.dart";
import "appointmentMother/appointmentMother_main.dart";
import "foodIntake/foodIntake_main.dart";
import "emergencyContact/emergencyContactTab.dart";
import "MotherHealthTracking/healthTrackingTab.dart";

class MotherToBeTab extends StatefulWidget {
  @override
  _MotherToBeTabState createState() => _MotherToBeTabState();
}

class _MotherToBeTabState extends State<MotherToBeTab> {
  @override
  Widget build(BuildContext context) {
    singleCard(iconLoc, title, index) {
      double height = MediaQuery.of(context).size.height * 0.1;
      double fontSize = MediaQuery.of(context).size.width * 0.045;

      return Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        color: Color(0xFFFCFFD5),
        child: InkWell(
          onTap: () {
            switch (index) {
              case 0:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentMotherMain()),
                  );
                }
                break;
              case 1:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FoodIntakeMain()),
                  );
                }
                break;
              case 2:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MotherHealthTracking()),
                  );
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                child: Image.asset(
                  iconLoc,
                  height: height,
                ),
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1, //APP BAR HEIGHT

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.height * 0.09,
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/icons/small.png"),
                ),
              ),
            ),
            Text(
              "Mother-to-be",
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Colors.black,
              ),
            ),
          ],
        ),

        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 100.0, left: 15, right: 15),
        children: <Widget>[
          singleCard("assets/icons/appointment.png", "Appointment\nManagement", 0),
          singleCard("assets/icons/food-intake.png", "Food Intake\nTracking", 1),
          singleCard("assets/icons/health-tracking.png", "Health\nTracking", 2),
          singleCard("assets/icons/emergency-call.png", "Emergency\nContact", 3),
        ],
      ),
    );
  }
}
