import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'healthReport.dart';
import "healthTrackingMother.dart";
import 'healthTrackingMother.dart';

class MotherHealthTracking extends StatefulWidget {
  final HealthReport healthReport;
  MotherHealthTracking({Key key, this.healthReport}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MotherHealthTracking(healthReport);
}

class _MotherHealthTracking extends State<MotherHealthTracking> {
  final HealthReport healthReport;
  _MotherHealthTracking(this.healthReport);

  Widget _listView() {
    double pictureSize = MediaQuery.of(context).size.width * 0.13;
    double paddingLeft = MediaQuery.of(context).size.width * 0.15;
    double paddingTopPic = MediaQuery.of(context).size.height * 0.05;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    double divider = MediaQuery.of(context).size.height * 0.01;
    double sizedBoxHeight = MediaQuery.of(context).size.height * 0.03;

    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                //color: Colors.lightBlue,
                height: MediaQuery.of(context).size.height * 0.64,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, 0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/blood-sugar-level.png",
                                width: pictureSize,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Blood Sugar",
                                  style: (TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                                Divider(
                                  height: divider,
                                ),
                                Text(
                                  healthReport.bloodSugar.toString(),
                                  style: (TextStyle(
                                    fontSize: fontSizeText,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizedBoxHeight),
                    Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, 0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/blood-pressure-level.png",
                                width: pictureSize,
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
                                  style: (TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                                Divider(
                                  height: divider,
                                ),
                                Text(
                                  healthReport.bloodPressure.toString(),
                                  style: (TextStyle(
                                    fontSize: fontSizeText,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizedBoxHeight),
                    Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, 0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/weight.png",
                                width: pictureSize,
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
                                  style: (TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                                Divider(
                                  height: divider,
                                ),
                                Text(
                                  healthReport.weight.toString(),
                                  style: (TextStyle(
                                    fontSize: fontSizeText,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizedBoxHeight),
                    Padding(
                      padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, paddingTopPic),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/icons/height.png",
                                width: pictureSize,
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
                                  style: (TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                                Divider(
                                  height: divider,
                                ),
                                Text(
                                  healthReport.height.toString(),
                                  style: (TextStyle(
                                    fontSize: fontSizeText,
                                    fontFamily: "Comfortaa",
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    InkWell(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: myBoxDecoration(),
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HealthTrackingMother()),
                        );
                      }, //ADD TO DATABASE
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

  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    String day = healthReport.dayOfPregnancy.toString();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Day $day",
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
      body: _listView(),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0) //<--- border radius here
          ),
    );
  }
}
