import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'appointmentMother/appointmentMother_verify.dart';
import 'foodIntake/foodIntakeTrackMain.dart';
import 'widgets/cardWidget.dart';
import "package:bundle_of_joy/appointmentMother/appointmentMother_verify.dart";
import "emergencyContact/emergencyContactTab.dart";
import "MotherHealthTracking/healthTrackingMother.dart";

class MotherToBeHome extends StatefulWidget {
  @override
  _MotherToBeHomeState createState() => _MotherToBeHomeState();
}

class _MotherToBeHomeState extends State<MotherToBeHome> {
  final kShadowColor = Color(0xFFE6E6E6);

  //Card view Widget
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: MediaQuery.of(context).size.height * .40,
            decoration: BoxDecoration(
              color: appbar1,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: appbar1.withOpacity(0.5), // Background Circle Colour
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    "Mother to Be",
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                      ],
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CardWidget(
                          title: "Appointment Management",
                          svgSrc: "assets/icons/testAM.svg",
                          press: () {
                            //Navigator.push( //For Old verification UI
                            //context,
                            //MaterialPageRoute(builder: (context) => AppointmentMotherVerify()),
                            //);
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                ),
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(
                                      physics: ClampingScrollPhysics(),
                                      child: AppointmentMotherVerification(),
                                    ));
                          },
                        ),
                        CardWidget(
                          title: "Food Intake Tracking",
                          svgSrc: "assets/icons/Hamburger.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FoodIntakeTrackMain()), //Updated UI
                              //MaterialPageRoute(builder: (context) => FoodIntakeMain()), //Old UI
                            );
                          },
                        ),
                        CardWidget(
                          title: "Health Tracking",
                          svgSrc: "assets/icons/testHT.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HealthTrackingMother()),
                            );
                          },
                        ),
                        CardWidget(
                          title: "Emergency Contact",
                          svgSrc: "assets/icons/testEC.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EmergencyContactTab()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
