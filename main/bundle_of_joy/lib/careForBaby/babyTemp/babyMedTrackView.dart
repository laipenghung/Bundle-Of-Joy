import 'package:bundle_of_joy/widgets/recordBodyTempWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BabyMedTrackView extends StatefulWidget {
  final String babyTempRecordID, selectedBabyID;
  BabyMedTrackView({Key key, this.babyTempRecordID, this.selectedBabyID}) : super(key: key);

  @override
  _BabyMedTrackViewState createState() => _BabyMedTrackViewState();
}

class _BabyMedTrackViewState extends State<BabyMedTrackView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Done");

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "View Medicine Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot>(
          future: collectionReference.doc(widget.babyTempRecordID).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
              String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
              DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
              String formattedTime = DateFormat('h:mm a').format(parsedTime);
              Map medicine = snapshot.data.data()["medsMap"];
              double tempBeforeMeds = double.parse(snapshot.data.data()["bTempBefore"]);
              double tempAfterMeds = double.parse(snapshot.data.data()["bTempAfter"]);

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
                      dateDesc: babyMedsDateDesc,
                      time: formattedTime,
                      timeDesc: babyMedsTimeDesc,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Conusmed Medicine",
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
                      svgSrc: "assets/icons/drugs.svg",
                      title: babyMedsRecordListTitle,
                      titleDesc: babyMedsRecordListTitleDesc,
                      foodName: medicine.keys.toList(),
                      foodQty: medicine.values.toList(),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Body Temperature",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //Body Temperature section
                    RecordBodyTempWidget(
                      svgSrc: "assets/icons/thermometer.svg",
                      tempBeforeMeds: tempBeforeMeds,
                      tempAferMeds: tempAfterMeds,
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
