import 'package:bundle_of_joy/MotherHealthTracking/healthReport.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import 'healthTrackingMother_detail.dart';

class HealthTrackingMother extends StatefulWidget {
  @override
  _HealthTrackingMotherState createState() => _HealthTrackingMotherState();
}

class _HealthTrackingMotherState extends State<HealthTrackingMother> {
  Widget _listView(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    final _listField = ["mh_id", "mh_date", "mh_time", "mh_bloodPressure", "mh_bloodSugar", "mh_height", "mh_weight", "mh_day_of_pregnancy"];
    List<HealthReport> _listInfo = List<HealthReport>();

    if (collection.hasData) {
      if (collection.connectionState == ConnectionState.waiting) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Colors.black,
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "Loading...",
                style: TextStyle(
                  fontFamily: "Comfortaa",
                  fontSize: fontSizeText,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      } else {
        collection.data.docs.forEach((doc) {
          _listInfo.add(HealthReport(doc.data()[_listField[0]], doc.data()[_listField[1]], doc.data()[_listField[2]], doc.data()[_listField[3]].toDouble(),
              doc.data()[_listField[4]].toDouble(), doc.data()[_listField[5]].toDouble(), doc.data()[_listField[6]].toDouble(), doc.data()[_listField[7]]));
        });

        return Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
          child: ListView.builder(
            itemCount: _listInfo.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MotherHealthTracking(healthReport: _listInfo[index])),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.015,
                          bottom: MediaQuery.of(context).size.height * 0.015,
                          left: MediaQuery.of(context).size.width * 0.07),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                            child: Image.asset(
                              "assets/icons/health-tracking.png",
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Day:",
                                style: TextStyle(
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeText,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Text(
                                "Date:",
                                style: TextStyle(
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeText,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _listInfo[index].dayOfPregnancy.toString(),
                                style: TextStyle(
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeText,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                              Text(
                                _listInfo[index].date.toString(),
                                style: TextStyle(
                                  fontFamily: "Comfortaa",
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSizeText,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      indent: MediaQuery.of(context).size.width * 0.03,
                      endIndent: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.black,
                      thickness: MediaQuery.of(context).size.height * 0.001,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    } else {
      return Center(
        child: Text(
          "There is currently no records",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: fontSizeText,
            color: Colors.black,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query health = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("health_record").orderBy("mh_day_of_pregnancy", descending: true);
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Health Tracking",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: fontSizeTitle,
            color: Colors.black,
          ),
        ),

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: health.snapshots(),
        builder: (context, collection) {
          return _listView(collection);
        },
      ),
    );
  }
}
