import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:quiver/iterables.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FoodRecordBloodSugarInsight extends StatefulWidget {
  final String svgSrc;
  const FoodRecordBloodSugarInsight({
    Key key, @required this.svgSrc, 
  }) : super(key: key);

  @override
  _FoodRecordBloodSugarInsightState createState() => _FoodRecordBloodSugarInsightState();
}

class _FoodRecordBloodSugarInsightState extends State<FoodRecordBloodSugarInsight> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Done");
  int totalRecordsCount = 0, excellentRecordsCount = 0, goodRecordsCount = 0, acceptableRecordsCount = 0, poorRecordsCount = 0, leftRecordsCount = 0;
  String listFirstElement;
  List recordDateTimeListString = []; List bloodSugarList = []; List recordCountList = [];
  double bloodSugarReading;

  @override
  Widget build(BuildContext context) {
    TextStyle normalWidgetTextStyle = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle boldWidgetTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.035,);

    return SizedBox(
      child: FutureBuilder<QuerySnapshot>(
        future: collectionReference.orderBy('selectedDate', descending: true).orderBy('selectedTime', descending: true).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((doc) {
              if(doc.data()["bsAfter"] != null){
                DateTime parsedDate = DateTime.parse(doc.data()["selectedDate"]);
                String formattedDate = DateFormat('d MMM').format(parsedDate);
                String formattedDateYear = DateFormat('yyyy').format(parsedDate);
                DateTime parsedTime = DateTime.parse(doc.data()["selectedDate"] + " " + doc.data()["selectedTime"]);
                String formattedTime = DateFormat('h:mm a').format(parsedTime);
                recordDateTimeListString.add("$formattedDate\n$formattedDateYear\n$formattedTime");
                bloodSugarList.add(double.parse(doc.data()["bsAfter"].toString()));
                bloodSugarReading = double.parse(doc.data()["bsAfter"].toString());
                totalRecordsCount++;

                if(bloodSugarReading < 5){leftRecordsCount++;}
                else if(bloodSugarReading > 4.9 && bloodSugarReading < 7.1){excellentRecordsCount++;}
                else if(bloodSugarReading > 7 && bloodSugarReading < 10.1){goodRecordsCount++;}
                else if(bloodSugarReading > 10 && bloodSugarReading < 13.1){acceptableRecordsCount++;}
                else if(bloodSugarReading > 13){poorRecordsCount++;}
              }
            });

            recordCountList.add(leftRecordsCount);
            recordCountList.add(excellentRecordsCount);
            recordCountList.add(goodRecordsCount);
            recordCountList.add(acceptableRecordsCount);
            recordCountList.add(poorRecordsCount);

            listFirstElement =  recordDateTimeListString[0];
            List<FoodRecordBsInsightChartData> chartData = [
              for (var x in zip([recordDateTimeListString, bloodSugarList]))
              FoodRecordBsInsightChartData(
                dayOfPregnancy: x[0], 
                measurement: x[1], 
                barColor: charts.ColorUtil.fromDartColor(appbar1),
              ),
            ];      
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(widget.svgSrc, height: 23, width: 23,),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 5.0),
                        child: Text(
                          "BoJ Insight™",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 3.0, ),
                    child: Text(
                      "BoJ Insight™ will use your blood glucose records that stored on the database and structures the data into useful information" + 
                          " hence providing you insights in what BoJ Insight™ has derived out of the entire data.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.black.withOpacity(0.65),
                      ),
                    ),
                  ),
                  (totalRecordsCount > 1)
                  ?Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 10.0,),
                              child: Column(
                                children: <Widget>[
                                  FoodRecordBsInsightChart(
                                    chartData: chartData, 
                                    firstList: listFirstElement,
                                  )
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(style: normalWidgetTextStyle, children: <TextSpan>[
                            TextSpan(text: "BoJ Insight™ found that you have "),
                            TextSpan(
                              text: totalRecordsCount.toString(),
                              style: boldWidgetTextStyle,
                            ),
                            TextSpan(
                              text: " health records saved on the database. All of the health records will be split into 5 blood glucose condition category.",
                            ),
                          ])),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: FoodRecordInsightTableWidget(
                          recordCountList: recordCountList,
                        ),
                      ),
                    ],
                  )
                  : InsightNotEnoughRecord(),
                ],
              );
            }
          } else if (snapshot.hasError) {
            print("error");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class FoodRecordInsightTableWidget extends StatelessWidget {
  final List recordCountList;
  FoodRecordInsightTableWidget({
    this.recordCountList
  });

  @override
  Widget build(BuildContext context) {
    List bloodSugarConditionList = ["Too Low", "Excellent", "Good", "Acceptable", "Poor"];

    return Container(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.0),
        child: Table(
          columnWidths: {0: FlexColumnWidth(6), 1: FlexColumnWidth(4),},
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: appbar1,
                      border: Border(
                        right: BorderSide(
                          width: 0.25, 
                          color: Colors.white,
                        ),
                      )
                    ),
                    width: double.infinity,
                    child: Text(
                      "Blood Glucose Condition",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: appbar1,
                      border: Border(
                        left: BorderSide(width: 0.25, color: Colors.white,),
                        right: BorderSide(width: 0.25, color: Colors.white,),
                      )
                    ),
                    width: double.infinity,
                    child: Text(
                      "Records Count",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ]
            ),
            for (var x in zip([bloodSugarConditionList, recordCountList]))
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                        right: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                      )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4),
                    width: double.infinity,
                    child: Text(
                      x[0],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                        left: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                      )
                    ),
                    width: double.infinity,
                    child: Text(
                      (x[1] != 0)? x[1].toString() + " Record(s)" : "-",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ),
                ),
              ]
            ), 
          ],
        ),
      ),
    );
  }
}

class FoodRecordBsInsightChart extends StatelessWidget {
  final List<FoodRecordBsInsightChartData> chartData;
  final String firstList;
  FoodRecordBsInsightChart({this.chartData, this.firstList});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<FoodRecordBsInsightChartData, String>> series = [
      charts.Series(
        id: "bloodSugarInsightChart",
        data: chartData,
        domainFn: (FoodRecordBsInsightChartData series, _) => series.dayOfPregnancy,
        measureFn: (FoodRecordBsInsightChartData series, _) => series.measurement,
        colorFn: (FoodRecordBsInsightChartData series, _) => series.barColor,
        labelAccessorFn: (FoodRecordBsInsightChartData series, _) => "${series.dayOfPregnancy}\n\n" + series.measurement.toString() + "\nmmol/L",
        insideLabelStyleAccessorFn: (FoodRecordBsInsightChartData series, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 15, 
        )
      )
    ];

    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(child:charts.BarChart(
              series,
              animate: true,
              vertical: true,
              behaviors: [
                charts.SlidingViewport(),
                charts.PanAndZoomBehavior(),
                charts.ChartTitle(
                  "Blood Glucose Reading (mmol/L)",
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
                charts.ChartTitle(
                  "Record Date & Time",
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
              ],
              barRendererDecorator: charts.BarLabelDecorator(
                labelPosition: charts.BarLabelPosition.inside,
              ),
              domainAxis: charts.OrdinalAxisSpec(
                viewport: charts.OrdinalViewport(firstList, 2),
                renderSpec: charts.NoneRenderSpec(),
              ),
            )
          ,)
        ],
      )
    );
  }
}

class FoodRecordBsInsightChartData{
  final String dayOfPregnancy;
  final double measurement;
  final charts.Color barColor;
  FoodRecordBsInsightChartData({
    @required this.dayOfPregnancy, @required this.measurement, @required this.barColor,
  });
}