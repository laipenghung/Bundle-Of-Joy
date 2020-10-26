import 'package:flutter/material.dart';

import 'babyFoodIntake/babyFoodIntakeMain.dart';
import 'babyTemp/babyTemptMain.dart';

class CareForBabyTab extends StatelessWidget {
  final String selectedBabyID;

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'TAB 1'),
    Tab(text: 'TAB 2'),
  ];

  CareForBabyTab({Key key, this.selectedBabyID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Care for Baby",
          ),
          bottom: TabBar(
            tabs: myTabs,
          ),
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
