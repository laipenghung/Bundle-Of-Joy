import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:fl_chart/fl_chart.dart";

class Growth extends StatefulWidget {
  final String selectedBabyID;
  Growth({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _Growth createState() => _Growth(selectedBabyID);
}

class _Growth extends State<Growth> {
  final String selectedBabyID;
  _Growth(this.selectedBabyID);

  LineChartData weightChart(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
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
      minX: double.parse(collection.data.docs.first.data()["bg_month"].toString()),
      maxX: double.parse(collection.data.docs.last.data()["bg_month"].toString()),
      maxY: double.parse(collection.data.docs.last.data()["bg_weight"].toString()),
      minY: double.parse(collection.data.docs.first.data()["bg_weight"].toString()),
      lineBarsData: weightData(collection),
    );
  }

  List<LineChartBarData> weightData(AsyncSnapshot<QuerySnapshot> collection) {
    List<FlSpot> data = List<FlSpot>();
    collection.data.docs.forEach((doc) {
      data.add(FlSpot(double.parse(doc.data()["bg_month"].toString()), double.parse(doc.data()["bg_weight"].toString())));
    });

    final LineChartBarData chartData = LineChartBarData(
      spots: data,
      isCurved: false,
      colors: [
        Colors.black,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [Color(0xFFFCFFD5)],
      ),
    );

    return [chartData];
  }

  Widget hasData(AsyncSnapshot collection) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    if (collection.data.docs.isNotEmpty) {
      return AspectRatio(
        aspectRatio: 1,
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06, bottom: MediaQuery.of(context).size.height * 0.08),
                    child: Text(
                      "Baby Growth - Weight",
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.03),
                    child: Text(
                      "Weight (Kg)",
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    //color: Colors.lightBlue,
                    child: Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.1),
                      child: LineChart(
                        weightChart(collection),
                      ),
                    )),
                  ),
                  Text(
                    "Age (months)",
                    style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
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

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query growth =
        FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("baby_growth").orderBy("bg_month", descending: false);
    return StreamBuilder(
        stream: growth.snapshots(),
        builder: (context, collection) {
          return hasData(collection);
        });
  }
}
