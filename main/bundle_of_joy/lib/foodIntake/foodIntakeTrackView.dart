import 'dart:ffi';

import 'package:bundle_of_joy/widgets/recordBloodSugarWidget.dart';
import 'package:bundle_of_joy/widgets/recordChart/recordChartData.dart';
import 'package:bundle_of_joy/widgets/recordChart/recordChartWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordListWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiver/iterables.dart';
import 'package:intl/intl.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class FoodIntakeTrackView extends StatefulWidget {
  final String foodIntakeRecordID;
  FoodIntakeTrackView({Key key, @required this.foodIntakeRecordID}) : super(key: key);

  @override
  _FoodIntakeTrackViewState createState() => _FoodIntakeTrackViewState();
}

class _FoodIntakeTrackViewState extends State<FoodIntakeTrackView> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Done");
  Color chartBeforeColor, chartColorAfter;

  alertColourBefore(bSugarBefore){
    if(bSugarBefore < 5.1){
      chartBeforeColor = Colors.red;
    }else if(bSugarBefore < 7.1){
      chartBeforeColor = Colors.green;
    }else if(bSugarBefore < 10.1){
      chartBeforeColor = Colors.lime;
    }else if(bSugarBefore < 13.1){
      chartBeforeColor = Colors.orange;
    }else{
      chartBeforeColor = Colors.red;
    }
  }

  alertColourAfter(bSugarAfter){
    if(bSugarAfter < 5.1){
      chartColorAfter = Colors.red;
    }else if(bSugarAfter < 6.1){
      chartColorAfter = Colors.green;
    }else if(bSugarAfter < 8.1){
      chartColorAfter = Colors.lime;
    }else if(bSugarAfter < 10.1){
      chartColorAfter = Colors.orange;
    }else{
      chartColorAfter = Colors.red;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            floating: true,
            pinned: true,
            stretch: true,
            stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                "Food Intake Tracking",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: FutureBuilder<DocumentSnapshot>(
              future: collectionReference.doc(widget.foodIntakeRecordID).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
                  String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
                  DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
                  String formattedTime =  DateFormat('h:mm a').format(parsedTime);
                  Map food = snapshot.data.data()["foodMap"];
                  //List<dynamic> foodName = List<dynamic>();
                  //List<dynamic> foodQty = List<dynamic>();
                  //foodName = food.keys.toList();
                  //foodQty = food.values.toList();
                  double bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);
                  double bSugarAfter = double.parse(snapshot.data.data()["bsAfter"]);
                  alertColourBefore(bSugarBefore);
                  alertColourAfter(bSugarAfter);

                  List<RecordChartData> chartData = [
                    RecordChartData(
                      period: "Before", 
                      bsReading: bSugarBefore, 
                      barColour: charts.ColorUtil.fromDartColor(chartBeforeColor),
                    ),
                    RecordChartData(
                      period: "After", 
                      bsReading: bSugarAfter, 
                      barColour: charts.ColorUtil.fromDartColor(chartColorAfter),
                    ),
                  ];
                  //print(foodName);
                  //print(foodQty);

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 18.0, left: 13.0,),
                          child: Text(
                            "Date and Time",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Widget for display Date and Time
                        RecordDateTimeWidget(
                          svgSrc: "assets/icons/testAM.svg",
                          date: formattedDate,
                          time: formattedTime,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                          child: Text(
                            "Conusmed Food",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Widget for display Consumed Food
                        RecordListWidget(
                          svgSrc: "assets/icons/testAM.svg",
                          foodName: food.keys.toList(),
                          foodQty: food.values.toList(),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                          child: Text(
                            "Blood Pressure",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Blood Pressure section
                        RecordBloodSugarWidget(
                          svgSrc: "assets/icons/testAM.svg",
                          bSugarBefore: bSugarBefore,
                          bSugarAfter: bSugarAfter,
                          chartBeforeColor: chartBeforeColor,
                          chartColorAfter: chartColorAfter,
                          chartData: chartData,
                        )
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  print("error");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}