import 'package:flutter/material.dart';

import 'appointmentBaby/appointmentBaby_verify.dart';
import 'careForBaby/careForBabyTab.dart';
import 'vaccinationAndGrowth/vacAndGrowthTab.dart';
import 'vaccinationSchedule/vaccinationSchedule.dart';
import 'widgets/cardWidget.dart';

class MotherForBabyHome extends StatefulWidget {
  @override
  _MotherForBabyHomeState createState() => _MotherForBabyHomeState();
}

class _MotherForBabyHomeState extends State<MotherForBabyHome> {
  final kShadowColor = Color(0xFFC7B8F5);
  //var press;

  //Card view Widget
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: MediaQuery.of(context).size.height * .40,
            decoration: BoxDecoration(
              color: Color(0xFFC7B8F5),
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
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      //child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    "Mother for Baby",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.65),
                    )
                  ),
                  
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CardWidget(
                          title: "Appointment Management",
                          svgSrc: "assets/icons/Hamburger.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AppointmentBabyVerify()),
                            );
                          },
                        ),
                        CardWidget(
                          title: "Vaccination Schedule",
                          svgSrc: "assets/icons/Hamburger.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VaccinationSchedule()),
                            );
                          },
                        ),
                        CardWidget(
                          title: "Vaccination & Growth Tracking",
                          svgSrc: "assets/icons/Meditation.svg",
                          press: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VacAndGrowthTab()),
                            );
                          },
                        ),
                        CardWidget(
                          title: "Care For Baby",
                          svgSrc: "assets/icons/yoga.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CareForBabyTab()),
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