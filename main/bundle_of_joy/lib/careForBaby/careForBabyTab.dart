import 'package:flutter/material.dart';

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
          bottom: TabBar(
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
      ),
      
    );
  }
}