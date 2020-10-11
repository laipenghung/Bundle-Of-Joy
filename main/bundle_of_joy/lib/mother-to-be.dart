import "package:flutter/material.dart";
import "appointmentMother/appointmentMother_main.dart";
import "foodIntake/foodIntake_main.dart";
import "emergencyContact/emergencyContactTab.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "MotherHealthTracking/healthTrackingTab.dart";

class MotherToBeTab extends StatefulWidget {
  @override
  _MotherToBeTabState createState() => _MotherToBeTabState();
}

class _MotherToBeTabState extends State<MotherToBeTab> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool contact;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkCont();
  }

  checkCont() async {
    var data;
    var result = await _db.collection("mother").doc(user.uid).get();
    setState(() {
      data = result.data()["m_emergencyContact"];
      if (data != null) {
        return contact = true;
      } else {
        return contact = false;
      }
    });
  }

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
