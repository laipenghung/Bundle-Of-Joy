import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/motherHealthRecordWidgets.dart';
import 'package:bundle_of_joy/widgets/record_DateTime_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HealthTrackRecordView extends StatefulWidget {
  final String healthRecordID;
  HealthTrackRecordView({Key key, @required this.healthRecordID}) : super(key: key);

  @override
  _HealthTrackRecordViewState createState() => _HealthTrackRecordViewState();
}

class _HealthTrackRecordViewState extends State<HealthTrackRecordView> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Health Record",
          style: TextStyle(
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot>(
          future: collectionReference.doc(widget.healthRecordID).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DateTime parsedDate = DateTime.parse(snapshot.data.data()["mh_date"]);
              String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
              int bPressureSystolic = int.parse(snapshot.data.data()["mh_bloodPressure_sys"].toString());
              int bPressureDiastolic = int.parse(snapshot.data.data()["mh_bloodPressure_dia"].toString());
              double bloodSugarReading = snapshot.data.data()["mh_bloodSugar"].toDouble();
              double weightReading = snapshot.data.data()["mh_weight"].toDouble();
              double heightReading = snapshot.data.data()["mh_height"].toDouble();

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
                      time: snapshot.data.data()["mh_time"],
                      timeDesc: motherRecordTimeDesc,
                    ),

                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Pregnancy Info",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    HealthRecordPregnancyWidget(
                      svgSrcDate: "assets/icons/calendarPreg.svg",
                      svgSrcDatePreg: "assets/icons/babyDate.svg",
                      dayOfPregnancy: int.parse(snapshot.data.data()["mh_day_of_pregnancy"].toString()),
                      recordDate: parsedDate,
                    ),

                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
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
                    HealthRecordBloodPressureWidget(
                      svgSrc: "assets/icons/blood-pressure.svg",
                      bPressureSystolic: bPressureSystolic,
                      bPressureDiastolic: bPressureDiastolic,
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
                    HealthRecordBloodSugarWidget(
                      svgSrc: "assets/icons/blood-donation.svg",
                      bGlucoseReading: bloodSugarReading,
                    ),

                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 13.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Body Physique",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    HealthRecordBodyPhysiqueWidget(
                      svgSrc: "assets/icons/body-mass-index.svg",
                      weightReading: weightReading,
                      heightReading: heightReading,
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
