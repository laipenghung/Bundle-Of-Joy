import 'package:flutter/material.dart';

import 'babyFoodIntake/babyFoodIntakeMain.dart';
import 'babyTemp/babyTemptMain.dart';

class CareForBabyTab extends StatelessWidget {
  final String selectedBabyID;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Food'),
    Tab(text: 'Medicine'),
  ];

  CareForBabyTab({Key key, this.selectedBabyID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text(
            "Care for Baby",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.05,
              color: Colors.black,
            ),
          ),

          bottom: TabBar(
            tabs: myTabs,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),

          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),

          //automaticallyImplyLeading: false, // CENTER THE TEXT
          backgroundColor: Color(0xFFFCFFD5),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            BabyFoodIntakeMain(selectedBabyID: selectedBabyID),
            BabyTempMain(selectedBabyID: selectedBabyID),
          ],
        ),
      ),
    );
  }
}
