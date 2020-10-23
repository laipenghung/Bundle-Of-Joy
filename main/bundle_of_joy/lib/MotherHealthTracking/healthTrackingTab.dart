import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "healthReport.dart";

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
    double picture_scale = 8.0;
    double paddingLeft = MediaQuery.of(context).size.width * 0.13;
    double paddingTopPic = MediaQuery.of(context).size.height * 0.05;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    double divider = MediaQuery.of(context).size.height * 0.01;
    double width = MediaQuery.of(context).size.width * 0.6;

    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, 0),
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
              Padding(
                padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, 0),
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
              Padding(
                padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, 0),
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
              Padding(
                padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, 0, paddingTopPic),
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
}
