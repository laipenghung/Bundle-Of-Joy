import 'package:bundle_of_joy/widgets/recordBloodSugarWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordListWidget.dart';
import 'package:bundle_of_joy/widgets/textWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class FoodIntakeTrackView extends StatefulWidget {
  final String foodIntakeRecordID;
  FoodIntakeTrackView({Key key, @required this.foodIntakeRecordID}) : super(key: key);

  @override
  _FoodIntakeTrackViewState createState() => _FoodIntakeTrackViewState();
}

class _FoodIntakeTrackViewState extends State<FoodIntakeTrackView> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Done");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            //expandedHeight: MediaQuery.of(context).size.height * 0.15,
            floating: true,
            pinned: true,
            stretch: true,
            //stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Container(
                child: Text(
                  "Food Intake Record",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
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
                  double bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);
                  double bSugarAfter = double.parse(snapshot.data.data()["bsAfter"]);

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
                          svgSrcDate: "assets/icons/testAM.svg",
                          svgSrcTime: "assets/icons/clock.svg",
                          date: formattedDate,
                          dateDesc: motherRecordDateDesc,
                          time: formattedTime,
                          timeDesc: motherRecordTimeDesc,
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
                          svgSrc: "assets/icons/healthy-food.svg",
                          title: motherRecordListTitle,
                          titleDesc: motherRecordListTitleDesc,
                          foodName: food.keys.toList(),
                          foodQty: food.values.toList(),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                          child: Text(
                            "Blood Sugar",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Blood Sugar section
                        RecordBloodSugarDoneWidget(
                          svgSrc: "assets/icons/blood-donation.svg",
                          bSugarBefore: bSugarBefore,
                          bSugarAfter: bSugarAfter,
                          showAnalyzer: true,
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