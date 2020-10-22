import 'package:flutter/material.dart';

import 'babyFoodIntake/babyFoodIntakeMain.dart';
import 'babyTemp/babtTemptMain.dart';

class CareForBabyTab extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'TAB 1'),
    Tab(text: 'TAB 2'),
  ];

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
              BabyFoodIntakeMain(),
              BabyTempMain(),
            ],
          ),
      ),
      
    );
  }
}