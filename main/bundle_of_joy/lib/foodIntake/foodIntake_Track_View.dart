import 'package:bundle_of_joy/widgets/record_BloodSugar_Widget.dart';
import 'package:bundle_of_joy/widgets/record_DateTime_Widget.dart';
import 'package:bundle_of_joy/widgets/record_FoodMeds_Widget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
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
      appBar: AppBar(
        title: Text(
          "View Food Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
          ),
        ),
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot>(
          future: collectionReference.doc(widget.foodIntakeRecordID).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
              String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
              DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
              String formattedTime = DateFormat('h:mm a').format(parsedTime);
              Map food = snapshot.data.data()["foodMap"];
              // double bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);
              // double bSugarAfter = double.parse(snapshot.data.data()["bsAfter"]);

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 18.0,
                        left: 13.0,
                      ),
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
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Consumed Food",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //Widget for display Consumed Food
                    RecordFoodMedsWidget(
                      svgSrc: "assets/icons/healthy-food.svg",
                      title: motherRecordListTitle,
                      titleDesc: motherRecordListTitleDesc,
                      foodName: food.keys.toList(),
                      foodQty: food.values.toList(),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Blood Glucose",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //Blood Glucose section
                    RecordBloodSugarDoneWidget(
                      svgSrc: "assets/icons/blood-donation.svg",
                      bSugarBefore: (snapshot.data.data()["bsBefore"] == null) ? null : double.parse(snapshot.data.data()["bsBefore"]),
                      bSugarAfter: (snapshot.data.data()["bsAfter"] == null) ? null : double.parse(snapshot.data.data()["bsAfter"]),
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
    );
  }
}
