import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class HealthRecordBloodSugarInsight extends StatefulWidget {
  final String svgSrc;
  const HealthRecordBloodSugarInsight({
    Key key, @required this.svgSrc, 
  }) : super(key: key);

  @override
  _HealthRecordBloodSugarInsightState createState() => _HealthRecordBloodSugarInsightState();
}

class _HealthRecordBloodSugarInsightState extends State<HealthRecordBloodSugarInsight> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");
  int totalRecordsCount = 0, excellentRecordsCount = 0, goodRecordsCount = 0, acceptableRecordsCount = 0, poorRecordsCount = 0, leftRecordsCount = 0;
  String listFirstElement;
  List dayOfPregnancyListString = []; List<int> dayOfPregnancyListInt = []; List bloodSugarList = []; List recordCountList = [];

  /*Future getAllRecords() async{
    var u = await collectionReference.where("mh_bloodSugar", isLessThan: 4).get();
    u.docs.forEach((doc) {setState(() => leftRecordsCount++);});
    var v = await collectionReference.where("mh_bloodSugar", isGreaterThan: 3.9).where("mh_bloodSugar", isLessThan: 6.1).get();
    v.docs.forEach((doc) {setState(() => excellentRecordsCount++);});
    var w = await collectionReference.where("mh_bloodSugar", isGreaterThan: 6).where("mh_bloodSugar", isLessThan: 8.1).get();
    w.docs.forEach((doc) {setState(() => goodRecordsCount++);});
    var x = await collectionReference.where("mh_bloodSugar", isGreaterThan: 8).where("mh_bloodSugar", isLessThan: 10.1).get();
    x.docs.forEach((doc) {setState(() => acceptableRecordsCount++);});
    var y = await collectionReference.where("mh_bloodSugar", isGreaterThan: 10).get();
    y.docs.forEach((doc) {setState(() => poorRecordsCount++);});
    var z = await collectionReference.get();
    z.docs.forEach((doc) {setState(() => totalRecordsCount++);});

    recordCountList.add(leftRecordsCount);
    recordCountList.add(excellentRecordsCount);
    recordCountList.add(goodRecordsCount);
    recordCountList.add(acceptableRecordsCount);
    recordCountList.add(poorRecordsCount);
  }

  void initState(){
    super.initState();
    //getAllRecords();
  }*/

  @override
  Widget build(BuildContext context) {
    TextStyle normalWidgetTextStyle = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle boldWidgetTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.035,);
    
    return SizedBox(
      child: FutureBuilder<QuerySnapshot>(
        future: collectionReference.orderBy("mh_day_of_pregnancy", descending: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((doc) {
              dayOfPregnancyListInt.add(int.parse(doc.data()["mh_day_of_pregnancy"].toString()));
              dayOfPregnancyListString.add(doc.data()["mh_day_of_pregnancy"].toString());
              bloodSugarList.add(double.parse(doc.data()["mh_bloodSugar"].toString()));
              totalRecordsCount++;

              if(doc.data()["mh_bloodSugar"] < 4){leftRecordsCount++;}
              else if(doc.data()["mh_bloodSugar"] > 3.9 && doc.data()["mh_bloodSugar"] < 6.1){excellentRecordsCount++;}
              else if(doc.data()["mh_bloodSugar"] > 6 && doc.data()["mh_bloodSugar"] < 8.1){goodRecordsCount++;}
              else if(doc.data()["mh_bloodSugar"] > 8 && doc.data()["mh_bloodSugar"] < 10.1){acceptableRecordsCount++;}
              else if(doc.data()["mh_bloodSugar"] > 10){poorRecordsCount++;}
            });

            recordCountList.add(leftRecordsCount);
            recordCountList.add(excellentRecordsCount);
            recordCountList.add(goodRecordsCount);
            recordCountList.add(acceptableRecordsCount);
            recordCountList.add(poorRecordsCount);

            listFirstElement =  dayOfPregnancyListString[0];
            List<HealthRecordBsInsightChartData> chartData = [
              for (var x in zip([dayOfPregnancyListString, bloodSugarList]))
              HealthRecordBsInsightChartData(
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
                                  HealthRecordBsInsightChart(
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
                        child: HealthRecordInsightTableWidget(
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

class HealthRecordInsightTableWidget extends StatelessWidget {
  final List recordCountList;
  HealthRecordInsightTableWidget({
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

class HealthRecordBsInsightChart extends StatelessWidget {
  final List<HealthRecordBsInsightChartData> chartData;
  final String firstList;
  HealthRecordBsInsightChart({this.chartData, this.firstList});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HealthRecordBsInsightChartData, String>> series = [
      charts.Series(
        id: "bloodSugarInsightChart",
        data: chartData,
        domainFn: (HealthRecordBsInsightChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBsInsightChartData series, _) => series.measurement,
        colorFn: (HealthRecordBsInsightChartData series, _) => series.barColor,
        labelAccessorFn: (HealthRecordBsInsightChartData series, _) => "D-${series.dayOfPregnancy}\n" + series.measurement.toString() + "\nmmol/L",
        insideLabelStyleAccessorFn: (HealthRecordBsInsightChartData series, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 13, 
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

class HealthRecordBsInsightChartData{
  final String dayOfPregnancy;
  final double measurement;
  final charts.Color barColor;
  HealthRecordBsInsightChartData({
    @required this.dayOfPregnancy, @required this.measurement, @required this.barColor,
  });
}