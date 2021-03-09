import 'package:bundle_of_joy/MotherHealthTracking/healthReport.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/scheduler.dart';
import 'healthTrackingMother_detail.dart';

class HealthTrackingMother extends StatefulWidget {
  @override
  _HealthTrackingMotherState createState() => _HealthTrackingMotherState();
}

class _HealthTrackingMotherState extends State<HealthTrackingMother> {
  int _pageIndex = 0;

  List<LineChartBarData> graphData(List<FlSpot> data) {
    final LineChartBarData chartData = LineChartBarData(
      spots: data,
      isCurved: true,
      colors: [
        Colors.black,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: [Color(0xFFFCFFD5)],
      ),
    );

    return [chartData];
  }

  LineChartData drawChart(List<FlSpot> data, String type) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    double minX, maxX, minY, maxY;
    String text = '';

    if(type == "BLOODSUGAR"){
      text = " (mmol/L)";
      maxY = data.last.y;
      minY = data.first.y;
    } else if (type == "WEIGHT"){
      text = " (kg)";
      maxY = data.first.y;
      minY = data.last.y;
    } else if (type == "HEIGHT"){
      text = " (cm)";
    }

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItems: (List<FlSpot> touchedBarSpots){
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              return LineTooltipItem(
                'Day ${flSpot.x.toInt()} \n${flSpot.y}${text}',
                const TextStyle(color: Colors.white),
              );
            }).toList();
          }
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
              color: Colors.black,
            )),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            fontFamily: "Comfortaa",
            fontSize: fontSizeText,
            color: Colors.black,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 1,
          ),
          left: BorderSide(
            color: Color(0xff4e4965),
            width: 1,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: data.last.x,
      maxX: data.first.x,
      maxY: maxY,
      minY: minY,
      lineBarsData: graphData(data),
    );
  }

  Widget _listView(AsyncSnapshot<QuerySnapshot> collection) {
    List<FlSpot> bloodSugarData = List<FlSpot>(), weightData = List<FlSpot>(), heightData = List<FlSpot>(), bloodPressureData = List<FlSpot>();
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.06;
    double fontSizeSubTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.035;
    double marginLeftRight = MediaQuery.of(context).size.width * 0.1;
    double pictureSize = MediaQuery.of(context).size.width * 0.12;
    String bloodSugar = "No record";
    String bloodPressureDia,  bloodPressureSys= "No record";
    Color colorBS = Colors.black;
    Color colorBPD, colorBPS = Colors.black;
    final _listField = ["mh_id", "mh_date", "mh_time", "mh_bloodPressure_dia", "mh_bloodPressure_sys","mh_bloodSugar", "mh_height", "mh_weight", "mh_day_of_pregnancy"];
    List<HealthReport> _listInfo = List<HealthReport>();

    if (collection.data.docs.isNotEmpty) {
      collection.data.docs.forEach((doc) {
        _listInfo.add(HealthReport(doc.data()[_listField[0]], doc.data()[_listField[1]], doc.data()[_listField[2]], double.parse(doc.data()[_listField[3]]),
            double.parse(doc.data()[_listField[4]]), doc.data()[_listField[5]].toDouble(), doc.data()[_listField[6]].toDouble(), doc.data()[_listField[7]].toDouble(), doc.data()[_listField[8]]));
        bloodSugarData.add(FlSpot(double.parse(doc.data()["mh_day_of_pregnancy"].toString()), double.parse(doc.data()["mh_bloodSugar"].toString())));
        weightData.add(FlSpot(double.parse(doc.data()["mh_day_of_pregnancy"].toString()), double.parse(doc.data()["mh_weight"].toString())));
        heightData.add(FlSpot(double.parse(doc.data()["mh_day_of_pregnancy"].toString()), double.parse(doc.data()["mh_height"].toString())));
        bloodPressureData.add(FlSpot(double.parse(doc.data()["mh_day_of_pregnancy"].toString()), double.parse(doc.data()["mh_bloodPressure_sys"].toString())));
      });

      if (_listInfo[0].bloodSugar.toDouble() > 6) {
        bloodSugar = _listInfo[0].bloodSugar.toString() + "  (mmol/L) \n(Too high)";
        colorBS = Colors.red;
      } else if (_listInfo[0].bloodSugar.toDouble() < 4) {
        bloodSugar = _listInfo[0].bloodSugar.toString() + "  (mmol/L) \n(Too low)";
        colorBS = Colors.orange;
      } else {
        bloodSugar = _listInfo[0].bloodSugar.toString() + "  (mmol/L)";
      }

      if (_listInfo[0].bloodPressure_sys > 120) {
        if (_listInfo[0].bloodPressure_sys > 130) {
          bloodPressureSys = _listInfo[0].bloodPressure_sys.toString() + " (mm/Hg) \n(High)";
          colorBPS = Colors.red;
        } else {
          bloodPressureSys = _listInfo[0].bloodPressure_sys.toString() + " (mm/Hg) \n(Elevated)";
          colorBPS = Colors.orange;
        }
      } else {
        bloodPressureSys = _listInfo[0].bloodPressure_sys.toString() + " (mm/Hg)";
      }

      if (_listInfo[0].bloodPressure_dia > 80) {
        if (_listInfo[0].bloodPressure_dia > 120) {
          bloodPressureDia = _listInfo[0].bloodPressure_dia.toString() + " (mm/Hg) \n(High)";
          colorBPD = Colors.red;
        } else {
          bloodPressureDia = _listInfo[0].bloodPressure_dia.toString() + " (mm/Hg) \n(Elevated)";
          colorBPD = Colors.orange;
        }
      } else {
        bloodPressureDia = _listInfo[0].bloodPressure_dia.toString() + " (mm/Hg)";
      }

      return Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: PageView.builder(
              itemCount: 5,
              controller: PageController(viewportFraction: 0.8),
              onPageChanged: (int index) => setState(()=> _pageIndex = index),
              itemBuilder: (_, i){
                if(i == 0){
                  return Transform.scale(
                    scale: i == _pageIndex ? 1 : 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      color: Color(0xFFFCFFD5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              "Recent Record",
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Text(
                              "Day: " + _listInfo[0].dayOfPregnancy.toString() + " (" + _listInfo[0].date.toString() + ")",
                              style: TextStyle(
                                fontSize: fontSizeSubTitle,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/blood-sugar-level.png",
                                      width: pictureSize,
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Blood Sugar",
                                      style: (TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                      )),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Text(
                                      bloodSugar,
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                        color: colorBS,
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/weight.png",
                                      width: pictureSize+5,
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Weight",
                                      style: (TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                      )),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Text(
                                      _listInfo[0].weight.toString() + " (kg)",
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/blood-pressure-level.png",
                                      width: pictureSize,
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Blood Pressure",
                                      style: (TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                      )),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Text(
                                      "Systolic:",
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                        fontWeight: FontWeight.bold,
                                      )),
                                    ),
                                    Text(
                                      bloodPressureSys,
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                        color: colorBPS,
                                      )),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      "Diastolic :",
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                        fontWeight: FontWeight.bold,
                                      )),
                                    ),
                                    Text(
                                      bloodPressureDia,
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                        color: colorBPD,
                                      )),
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/height.png",
                                      width: pictureSize+5,
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Height",
                                      style: (TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                      )),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    Text(
                                      _listInfo[0].height.toString() + " (cm)",
                                      style: (TextStyle(
                                        fontSize: fontSizeText,
                                        fontFamily: "Comfortaa",
                                      )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (i == 1){
                  return Transform.scale(
                    scale: i == _pageIndex ? 1 : 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      color: Color(0xFFFCFFD5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              "Blood Sugar Chart",
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    "Blood Sugar\n(mmol/L)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fontSizeText,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Comfortaa",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                                child: new LineChart(
                                  drawChart(bloodSugarData, "BLOODSUGAR"),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day of Pregnancy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (i == 2) {
                  return Transform.scale(
                    scale: i == _pageIndex ? 1 : 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      color: Color(0xFFFCFFD5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              "Blood Pressure Systolic Chart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    "Blood Pressure\n(mm/Hg)",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: fontSizeText,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Comfortaa",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                                child: LineChart(
                                  drawChart(bloodPressureData, "BLOODPRESSURE"),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day of Pregnancy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (i == 3) {
                  return Transform.scale(
                    scale: i == _pageIndex ? 1 : 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      color: Color(0xFFFCFFD5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              "Weight Chart",
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    "Weight (kg)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fontSizeText,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Comfortaa",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                                child: LineChart(
                                  drawChart(weightData, "WEIGHT"),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day of Pregnancy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Transform.scale(
                    scale: i == _pageIndex ? 1 : 0.95,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      color: Color(0xFFFCFFD5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Text(
                              "Height Chart",
                              style: TextStyle(
                                fontSize: fontSizeTitle,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
                                  child: Text(
                                    "Height (cm)",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fontSizeText,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Comfortaa",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                                child: LineChart(
                                  drawChart(heightData, "HEIGHT"),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Day of Pregnancy",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: fontSizeText,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Comfortaa",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: marginLeftRight, right: marginLeftRight),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  color: Color(0xFFFCFFD5),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
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
                                    top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.07),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      );
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

  Widget loading(){
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
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
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        //automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: health.snapshots(),
        builder: (context, collection) {
          if(collection.hasData) {
            return _listView(collection);
          } else {
            return loading();
          }
        },
      ),
    );
  }
}
