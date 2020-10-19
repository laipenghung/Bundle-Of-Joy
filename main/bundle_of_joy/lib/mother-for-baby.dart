import "package:flutter/material.dart";

class MotherForBabyTab extends StatefulWidget {
  @override
  _MotherForBabyTabState createState() => _MotherForBabyTabState();
}

class _MotherForBabyTabState extends State<MotherForBabyTab> {
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

                }
                break;
              case 1:
                {

                }
                break;
              case 2:
                {

                }
                break;
              case 3:
                {

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
          singleCard("assets/icons/vaccination.png", "Vaccination\nSchedule", 1),
          singleCard("assets/icons/bar-chart.png", "Vaccination &\nGrowth\nTracking", 2),
          singleCard("assets/icons/baby_color.png", "Care\nfor Baby", 3),
        ],
      ),
    );
  }
}
