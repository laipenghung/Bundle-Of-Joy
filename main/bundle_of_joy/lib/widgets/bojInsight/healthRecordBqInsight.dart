import 'dart:developer';

import 'package:bundle_of_joy/foodIntake/foodIntakeBloodSugarTips.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:quiver/iterables.dart';

class HealthRecordBodyPhysiqueInsight extends StatefulWidget {
  final String svgSrc;
  
  const HealthRecordBodyPhysiqueInsight({
    Key key, @required this.svgSrc, 
  }) : super(key: key);

  @override
  _HealthRecordBodyPhysiqueInsightState createState() => _HealthRecordBodyPhysiqueInsightState();
}

class _HealthRecordBodyPhysiqueInsightState extends State<HealthRecordBodyPhysiqueInsight> {
  int tabCurrentSelection = 0, recordsCount = 0;

  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");
  String listFirstElement;
  List dayOfPregnancyListString = []; List<int> dayOfPregnancyListInt = []; List weightList = []; List heightList = [];
  String graphTitle, graphDesc, tableTitle, tableDesc, yAxisLabel, measurement, tableMeasurement, databaseField;

  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle linkTextStyle = TextStyle(color: Colors.blue, fontSize: MediaQuery.of(context).size.width * 0.035,);
    
    return SizedBox(
      child: FutureBuilder<QuerySnapshot>(
        future: collectionReference.orderBy("mh_day_of_pregnancy", descending: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((doc) {
              dayOfPregnancyListInt.add(int.parse(doc.data()["mh_day_of_pregnancy"].toString()));
              dayOfPregnancyListString.add(doc.data()["mh_day_of_pregnancy"].toString());
              weightList.add(double.parse(doc.data()["mh_weight"].toString()));
              heightList.add(double.parse(doc.data()["mh_height"].toString()));
              recordsCount++;
            });

            listFirstElement =  dayOfPregnancyListString[0];
            List<HealthRecordBodyPhysiqueChartData> weightChartData = [
              for (var x in zip([dayOfPregnancyListString, weightList]))
              HealthRecordBodyPhysiqueChartData(
                dayOfPregnancy: x[0], 
                measurement: x[1], 
                barColor: charts.ColorUtil.fromDartColor(appbar2),
              ),
            ];
            List<HealthRecordBodyPhysiqueChartData> heightChartData = [
              for (var x in zip([dayOfPregnancyListString, heightList]))
              HealthRecordBodyPhysiqueChartData(
                dayOfPregnancy: x[0], 
                measurement: x[1], 
                barColor: charts.ColorUtil.fromDartColor(appbar2),
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
                      "BoJ Insight™ will use your records that stored on the database and structures the data into useful information" + 
                          " hence providing you insights in what BoJ Insight™ has derived out of the entire data.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.black.withOpacity(0.65),
                      ),
                    ),
                  ),
                  (recordsCount > 1)
                  ?Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              child: InsightWidgetsTitle(
                                svgSrc: "assets/icons/graph.svg",
                                title: "Body Physique Graph",
                                desc: "This section display your weight & height records throughout the pregnancy. The records are presented to you in bar" +
                                  " chart to help you visualize your body physique record in a compact and precise format.",
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 10.0,),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "Weight Graph",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  HealthRecordWeightChart(
                                    chartData: weightChartData, 
                                    firstList: listFirstElement,
                                  )
                                ],
                              )
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      "Height Graph",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.045,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  HealthRecordHeightChart(
                                    chartData: heightChartData, 
                                    firstList: listFirstElement,
                                  )
                                ],
                              )
                            ),
                            InsightWidgetsTitle(
                              svgSrc: "assets/icons/table.svg",
                              title: "Body Physique Table",
                              desc: "This section display your weight & height records throughout the pregnancy and all of your records " + 
                                "are being presented to you in table form.",
                            ),
                            Container(
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 10.0),
                                child: Table(
                                  columnWidths: {0: FlexColumnWidth(3), 1: FlexColumnWidth(2), 2: FlexColumnWidth(2),},
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            decoration: BoxDecoration(
                                              color: appbar2,
                                              border: Border(
                                                right: BorderSide(
                                                  width: 0.25, 
                                                  color: Colors.white,
                                                ),
                                              )
                                            ),
                                            width: double.infinity,
                                            child: Text(
                                              "Day Of Pregnancy",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.03,
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
                                              color: appbar2,
                                              border: Border(
                                                left: BorderSide(width: 0.25, color: Colors.white,),
                                                right: BorderSide(width: 0.25, color: Colors.white,),
                                              )
                                            ),
                                            width: double.infinity,
                                            child: Text(
                                              "Weight (Kg)",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.03,
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
                                              color: appbar2,
                                              border: Border(
                                                left: BorderSide(
                                                  width: 0.25, 
                                                  color: Colors.white,
                                                ),
                                              )
                                            ),
                                            width: double.infinity,
                                            child: Text(
                                              "Height (Cm)",
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.03,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                    ),
                                    for (var x in zip([dayOfPregnancyListInt, weightList, heightList]))
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
                                              "Day " + x[0].toString(),
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
                                              x[1].toString(),
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
                                              x[2].toString(),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : InsightNotEnoughRecord(),



                  
                  
                  //Learn more
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: normalTextStye,
                        children: <TextSpan>[
                          TextSpan(
                            text: "If you wish to learn more on how BoJ Analyzer™ use your blood pressure reading saved on the database " +
                                "to analyze your blood pressure condition. You can ",
                          ),
                          TextSpan(
                            text: "tap here",
                            style: linkTextStyle,
                            recognizer: TapGestureRecognizer() ..onTap = () {
                              showModalBottomSheet(
                                context: context, 
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                ),
                                isScrollControlled: true,
                                builder: (context) => FoodIntakeBloodSugarTips(),
                              );
                            }
                          ),
                          TextSpan(text: " for more info.",),
                        ]
                      )
                    ), 
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
    );
  }
}

class HealthRecordHeightChart extends StatelessWidget {
  final List<HealthRecordBodyPhysiqueChartData> chartData;
  final String firstList;
  HealthRecordHeightChart({this.chartData, this.firstList});

  // @override
  // _HealthRecordHeightChartState createState() => _HealthRecordHeightChartState();
// }

// class _HealthRecordHeightChartState extends State<HealthRecordHeightChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<HealthRecordBodyPhysiqueChartData, String>> series = [
      charts.Series(
        id: "WeightChart",
        data: chartData,
        domainFn: (HealthRecordBodyPhysiqueChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBodyPhysiqueChartData series, _) => series.measurement,
        colorFn: (HealthRecordBodyPhysiqueChartData series, _) => series.barColor,
        labelAccessorFn: (HealthRecordBodyPhysiqueChartData series, _) => "D ${series.dayOfPregnancy}\n" + series.measurement.toString() + " Cm",
        insideLabelStyleAccessorFn: (HealthRecordBodyPhysiqueChartData series, _) => charts.TextStyleSpec(
          //color: charts.MaterialPalette.gray.shade800,
          color: charts.MaterialPalette.white,
          fontSize: 11, 
        )
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 5.0,),
      height: 250,
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
                  "Height (Cm)",
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
                charts.ChartTitle(
                  "Day Of Pregnancy (D)",
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
              ],
              barRendererDecorator: charts.BarLabelDecorator(
                labelPosition: charts.BarLabelPosition.inside,
              ),
              
              domainAxis: charts.OrdinalAxisSpec(
                viewport: charts.OrdinalViewport(firstList, 4),
                renderSpec: charts.NoneRenderSpec(),
              ),
            )
          ,)
        ],
      )
    );
  }
}

class HealthRecordWeightChart extends StatelessWidget {
  final List<HealthRecordBodyPhysiqueChartData> chartData;
  final String firstList;
  HealthRecordWeightChart({this.chartData, this.firstList});

  // @override
  // _HealthRecordWeightChartState createState() => _HealthRecordWeightChartState();
// }

// class _HealthRecordWeightChartState extends State<HealthRecordWeightChart> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<HealthRecordBodyPhysiqueChartData, String>> series = [
      charts.Series(
        id: "WeightChart",
        data: chartData,
        domainFn: (HealthRecordBodyPhysiqueChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBodyPhysiqueChartData series, _) => series.measurement,
        colorFn: (HealthRecordBodyPhysiqueChartData series, _) => series.barColor,
        labelAccessorFn: (HealthRecordBodyPhysiqueChartData series, _) => "D ${series.dayOfPregnancy}\n" + series.measurement.toString() + " Kg",
        insideLabelStyleAccessorFn: (HealthRecordBodyPhysiqueChartData series, _) => charts.TextStyleSpec(
          //color: charts.MaterialPalette.gray.shade800,
          color: charts.MaterialPalette.white,
          fontSize: 11, 
        )
      )
    ];

    return Container(
      //margin: EdgeInsets.only(bottom: 5.0,),
      height: 250,
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
                  "Weight (Kg)",
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
                charts.ChartTitle(
                  "Day Of Pregnancy (D)",
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
              ],
              barRendererDecorator: charts.BarLabelDecorator(
                labelPosition: charts.BarLabelPosition.inside,
              ),
              
              domainAxis: charts.OrdinalAxisSpec(
                viewport: charts.OrdinalViewport(firstList, 4),
                renderSpec: charts.NoneRenderSpec(),
              ),
            )
          ,)
        ],
      )
    );
  }
}

class HealthRecordBodyPhysiqueChartData{
  final String dayOfPregnancy;
  final double measurement;
  final charts.Color barColor;
  HealthRecordBodyPhysiqueChartData({
    @required this.dayOfPregnancy, @required this.measurement, @required this.barColor,
  });
}