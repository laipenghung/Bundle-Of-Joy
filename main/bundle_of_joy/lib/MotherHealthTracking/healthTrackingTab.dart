import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "healthReport.dart";

class MotherHealthTracking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotherHealthTracking();
}

class _MotherHealthTracking extends State<MotherHealthTracking>{

  SingleChildScrollView _listView(AsyncSnapshot<QuerySnapshot> collection) {
    double picture_scale = 8.0;
    double paddingLeft = MediaQuery.of(context).size.width * 0.1;
    double paddingTopPic = MediaQuery.of(context).size.height * 0.05;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    double width = MediaQuery.of(context).size.width * 0.6;
    int selected_index = 0;
    final _listField = ["mh_id", "mh_date", "mh_time", "mh_bloodPressure", "mh_bloodSugar", "mh_height", "mh_weight", "mh_day_of_pregnancy"];
    List<HealthReport> _listInfo = List<HealthReport>();
    collection.data.docs.forEach((doc) {
      _listInfo.add(
          HealthReport(
              doc.data()[_listField[0]],
              doc.data()[_listField[1]],
              doc.data()[_listField[2]],
              doc.data()[_listField[3]].toDouble(),
              doc.data()[_listField[4]].toDouble(),
              doc.data()[_listField[5]].toDouble(),
              doc.data()[_listField[6]].toDouble(),
              doc.data()[_listField[7]])
      );
    });

    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Container(
                  width: width,
                  decoration: myBoxDecoration(),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        hint: Text("Select a date"),
                        dropdownColor: Color(0xFFFCFFD5),
                        value: selected_index == null ? null : _listInfo[selected_index],
                        items: _listInfo.map((HealthReport report) {
                          String day = report.dayOfPregnancy.toString();
                          String date = report.date.toString();
                          return DropdownMenuItem<HealthReport>(
                            value: report,
                            child: Row(
                                children: [
                                  Text("Day: $day ($date)"),
                                ]
                            ),
                          );
                        }).toList(),
                        onChanged: (index){
                          setState(() {
                            selected_index = _listInfo.indexOf(index);
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/icons/blood-sugar-level.png",
                            scale: picture_scale,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Blood Sugar Level",
                              style: (
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                  )
                              ),
                            ),
                            Text(
                              _listInfo[selected_index].bloodSugar.toString(),
                              style: (
                                  TextStyle(
                                    fontSize: fontSizeText,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/icons/blood-pressure-level.png",
                            scale: picture_scale,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Blood Pressure",
                              style: (
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                  )
                              ),
                            ),
                            Text(
                              _listInfo[selected_index].bloodPressure.toString(),
                              style: (
                                  TextStyle(
                                    fontSize: fontSizeText,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/icons/weight.png",
                            scale: picture_scale,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Weight (kg)",
                              style: (
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                  )
                              ),
                            ),
                            Text(
                              _listInfo[selected_index].weight.toString(),
                              style: (
                                  TextStyle(
                                    fontSize: fontSizeText,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            "assets/icons/height.png",
                            scale: picture_scale,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Height (cm)",
                              style: (
                                  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                  )
                              ),
                            ),
                            Text(
                              _listInfo[selected_index].height.toString(),
                              style: (
                                  TextStyle(
                                    fontSize: fontSizeText,
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
        },
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(10.0) //<--- border radius here
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference health = FirebaseFirestore.instance.collection("mother_health").doc(user.uid).collection("health_report");
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
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
          builder: (context, collection){
            return _listView(collection);
          }
      ),
    );
  }
}

