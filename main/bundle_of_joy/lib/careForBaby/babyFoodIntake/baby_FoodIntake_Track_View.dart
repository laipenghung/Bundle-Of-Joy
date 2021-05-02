import 'package:bundle_of_joy/widgets/recordBabyAfterMealWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BabyFoodIntakeTrackView extends StatefulWidget {
  final String recordID, selectedBabyID;
  BabyFoodIntakeTrackView({Key key, this.recordID, this.selectedBabyID}) : super(key: key);

  @override
  _BabyFoodIntakeTrackViewState createState() => _BabyFoodIntakeTrackViewState();
}

class _BabyFoodIntakeTrackViewState extends State<BabyFoodIntakeTrackView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Done");

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
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot>(
          future: collectionReference.doc(widget.recordID).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
              String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
              DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
              String formattedTime = DateFormat('h:mm a').format(parsedTime);
              Map food = snapshot.data.data()["foodMap"];
              String babySymptoms = snapshot.data.data()["babysymptoms"];
              bool sympAndAlle = snapshot.data.data()["symptomsAndAllergies"];

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
                        svgSrcDate: "assets/icons/testAM.svg", svgSrcTime: "assets/icons/clock.svg", date: formattedDate, dateDesc: babyFoodDateDesc, time: formattedTime, timeDesc: babyFoodTimeDesc),
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
                      title: babyFoodRecordListTitle,
                      titleDesc: babyFoodRecordListTitleDesc,
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
                        "After Meal Behavior",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //Blood Sugar section
                    RecordBabyAfterMealWidget(
                      svgSrc: "assets/icons/face-swelling.svg",
                      symptomsAndAllergies: sympAndAlle,
                      symptomsAndAllergiesDesc: babySymptoms,
                      selectedBabyID: widget.selectedBabyID,
                    ),
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
