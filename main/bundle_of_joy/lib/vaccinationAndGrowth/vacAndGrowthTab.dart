import "package:bundle_of_joy/vaccinationAndGrowth/growth/growth.dart";
import "package:bundle_of_joy/vaccinationAndGrowth/vaccination/vaccination.dart";
import "package:flutter/material.dart";

class VacAndGrowthTab extends StatelessWidget {
  final String selectedBabyID;

  final List<Tab> myTabs = <Tab>[
    Tab(text: "Vaccination"),
    Tab(text: "Growth"),
  ];

  VacAndGrowthTab({Key key, this.selectedBabyID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Vaccination & Growth",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.bold,
              fontSize: fontSizeTitle,
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xFFFCFFD5),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: TextStyle(
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.bold,
              fontSize: fontSizeText,
            ),
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          children: [
            Vaccination(selectedBabyID: selectedBabyID),
            Growth(selectedBabyID: selectedBabyID),
          ],
        ),
      ),
    );
  }
}
