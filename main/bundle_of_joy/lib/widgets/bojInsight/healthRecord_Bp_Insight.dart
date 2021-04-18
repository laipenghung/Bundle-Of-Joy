import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class HealthRecordBloodPressureInsight extends StatefulWidget {
  final String svgSrc;
  const HealthRecordBloodPressureInsight({
    Key key, @required this.svgSrc, 
  }) : super(key: key);

  @override
  _HealthRecordBloodPressureInsightState createState() => _HealthRecordBloodPressureInsightState();
}

class _HealthRecordBloodPressureInsightState extends State<HealthRecordBloodPressureInsight> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");
  List dayOfPregnancyListString = []; List<int> dayOfPregnancyListInt = []; List bloodPressureSystolicList = []; List bloodPressureDiastolicList = [];
  int totalRecordsCount = 0;
  String listFirstElement;
  
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
              int bloodPressureSys, bloodPressureDia;
              dayOfPregnancyListInt.add(int.parse(doc.data()["mh_day_of_pregnancy"].toString()));
              dayOfPregnancyListString.add(doc.data()["mh_day_of_pregnancy"].toString());
              bloodPressureSys = int.parse(doc.data()["mh_bloodPressure_sys"].toString());
              bloodPressureSystolicList.add(bloodPressureSys);
              bloodPressureDia = int.parse(doc.data()["mh_bloodPressure_dia"].toString());
              bloodPressureDiastolicList.add(bloodPressureDia);
              totalRecordsCount++;
            });

            listFirstElement =  dayOfPregnancyListString[0];
            List<HealthRecordBpInsightChartData> chartData = [
              for (var x in zip([dayOfPregnancyListString, bloodPressureSystolicList, bloodPressureDiastolicList]))
              HealthRecordBpInsightChartData(
                dayOfPregnancy: x[0], 
                systolicReading: x[1], 
                diastolicReading: x[2],
                barSysColor: charts.ColorUtil.fromDartColor(appbar1),
                barDiaColor: charts.ColorUtil.fromDartColor(appbar2),
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
                      "BoJ Insight™ will use your blood pressure records that stored on the database and structures the data into useful information" + 
                          " hence providing you insights in what BoJ Insight™ has derived out of the entire data.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.black.withOpacity(0.65),
                      ),
                    ),
                  ),
                  (totalRecordsCount > 1)
                  ? Column(
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
                                  HealthRecordBpInsightChart(
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
                        margin: EdgeInsets.only(top: 10),
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
                              text: " health records saved on the database. All of the health records will be split into into " +
                                "Systolic and Diastolic and split again into 4 or 5 blood pressure condition category",
                            ),
                          ])),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10.0,),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                "Systolic Categoty",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            HealthRecordInsightSystolicWidget(),
                          ],
                        )
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                "Diastolic Categoty",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            HealthRecordInsightDiastolicWidget(),
                          ],
                        )
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

class HealthRecordInsightDiastolicWidget extends StatefulWidget {
  @override
  _HealthRecordInsightDiastolicWidgetState createState() => _HealthRecordInsightDiastolicWidgetState();
}

class _HealthRecordInsightDiastolicWidgetState extends State<HealthRecordInsightDiastolicWidget> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");
  int normalEleDiaRecordsCount = 0, hyperStage1DiaCount = 0, hyperStage2DiaCount = 0, hyperCrisisDiaCount = 0; 
  List bloodPressureDiastolicList = [];
  /*Future getAllRecords() async{
    var x = await collectionReference.orderBy("mh_day_of_pregnancy", descending: false).get();
    x.docs.forEach((doc) {
      int bloodPressureDia;
      bloodPressureDia = int.parse(doc.data()["mh_bloodPressure_dia"].toString());
      if(bloodPressureDia < 80){setState(() => normalEleDiaRecordsCount++);}
      else if(bloodPressureDia > 79 && bloodPressureDia < 90){setState(() => hyperStage1DiaCount++);}
      else if(bloodPressureDia > 89 &&  bloodPressureDia < 121){setState(() => hyperStage2DiaCount++);}
      else{setState(() => hyperCrisisDiaCount++);}
    });
    bloodPressureDiastolicList.add(normalEleDiaRecordsCount);
    bloodPressureDiastolicList.add(hyperStage1DiaCount);
    bloodPressureDiastolicList.add(hyperStage2DiaCount);
    bloodPressureDiastolicList.add(hyperCrisisDiaCount);
  }

  void initState(){
    super.initState();
    getAllRecords();
  }*/

  @override
  Widget build(BuildContext context) {
    List bloodPressureConditionList = ["Normal or Elevated", "Hypertension Stage 1", "Hypertension Stage 2", "Hypertensive Crisis"];
    int bloodPressureDia;

    return Container(
      child: FutureBuilder(
        future: collectionReference.orderBy("mh_day_of_pregnancy", descending: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((doc) {
              bloodPressureDia = int.parse(doc.data()["mh_bloodPressure_dia"].toString());
              if(bloodPressureDia < 80){normalEleDiaRecordsCount++;}
              else if(bloodPressureDia > 79 && bloodPressureDia < 90){hyperStage1DiaCount++;}
              else if(bloodPressureDia > 89 && bloodPressureDia < 121){hyperStage2DiaCount++;}
              else if(bloodPressureDia > 121 ){hyperCrisisDiaCount++;}
            });

            bloodPressureDiastolicList.add(normalEleDiaRecordsCount);
            bloodPressureDiastolicList.add(hyperStage1DiaCount);
            bloodPressureDiastolicList.add(hyperStage2DiaCount);
            bloodPressureDiastolicList.add(hyperCrisisDiaCount);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 5.0),
                    child: Table(
                      columnWidths: {0: FlexColumnWidth(6), 1: FlexColumnWidth(4),},
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
                                  color: appbar2,
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
                        for (var x in zip([bloodPressureConditionList, bloodPressureDiastolicList]))
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

class HealthRecordInsightSystolicWidget extends StatefulWidget {
   @override
   _HealthRecordInsightSystolicWidgetState createState() => _HealthRecordInsightSystolicWidgetState();
 }

 class _HealthRecordInsightSystolicWidgetState extends State<HealthRecordInsightSystolicWidget> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");
  int normalSysRecordsCount = 0, elevatedSysRecordsCount = 0, hyperStage1SysCount = 0, hyperStage2SysCount = 0, hyperCrisisSysCount = 0;
  List bloodPressureSystolicList = [];
  /*Future getAllRecords() async{
    var x = await collectionReference.orderBy("mh_day_of_pregnancy", descending: false).get();
    x.docs.forEach((doc) {
      int bloodPressureSys;
      bloodPressureSys = int.parse(doc.data()["mh_bloodPressure_sys"].toString());
      if(bloodPressureSys < 120){setState(() => normalSysRecordsCount++);}
      else if(bloodPressureSys > 119 && bloodPressureSys < 130){setState(() => elevatedSysRecordsCount++);}
      else if(bloodPressureSys > 129 &&  bloodPressureSys < 140){setState(() => hyperStage1SysCount++);}
      else if(bloodPressureSys > 139 && bloodPressureSys < 181){setState(() => hyperStage2SysCount++);}
      else{setState(() => hyperCrisisSysCount++);}
    });
    bloodPressureSystolicList.add(normalSysRecordsCount);
    bloodPressureSystolicList.add(elevatedSysRecordsCount);
    bloodPressureSystolicList.add(hyperStage1SysCount);
    bloodPressureSystolicList.add(hyperStage2SysCount);
    bloodPressureSystolicList.add(hyperCrisisSysCount);
  }

  void initState(){
    super.initState();
    getAllRecords();
  }*/

  @override
  Widget build(BuildContext context) {
    List bloodPressureConditionList = ["Normal", "Elevated", "Hypertension Stage 1", "Hypertension Stage 2", "Hypertensive Crisis"];
    int bloodPressureSys;

    return Container(
      child: FutureBuilder(
        future: collectionReference.orderBy("mh_day_of_pregnancy", descending: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((doc) {
              bloodPressureSys = int.parse(doc.data()["mh_bloodPressure_sys"].toString());
              if(bloodPressureSys < 120){normalSysRecordsCount++;}
              else if(bloodPressureSys > 119 && bloodPressureSys < 130){elevatedSysRecordsCount++;}
              else if(bloodPressureSys > 129 && bloodPressureSys < 140){hyperStage1SysCount++;}
              else if(bloodPressureSys > 139 && bloodPressureSys < 181){hyperStage2SysCount++;}
              else if(bloodPressureSys > 180 ){hyperCrisisSysCount++;}
            });

            bloodPressureSystolicList.add(normalSysRecordsCount);
            bloodPressureSystolicList.add(elevatedSysRecordsCount);
            bloodPressureSystolicList.add(hyperStage1SysCount);
            bloodPressureSystolicList.add(hyperStage2SysCount);
            bloodPressureSystolicList.add(hyperCrisisSysCount);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 5.0),
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
                        for (var x in zip([bloodPressureConditionList, bloodPressureSystolicList]))
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

class HealthRecordBpInsightChart extends StatelessWidget {
  final List<HealthRecordBpInsightChartData> chartData;
  final String firstList;
  HealthRecordBpInsightChart({this.chartData, this.firstList});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HealthRecordBpInsightChartData, String>> series = [
      charts.Series(
        id: "Systolic",
        data: chartData,
        domainFn: (HealthRecordBpInsightChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBpInsightChartData series, _) => series.systolicReading,
        colorFn: (HealthRecordBpInsightChartData series, _) => series.barSysColor,
        labelAccessorFn: (HealthRecordBpInsightChartData series, _) => "D-${series.dayOfPregnancy}\n" + series.systolicReading.toString() + "\nmm/Hg",
        insideLabelStyleAccessorFn: (HealthRecordBpInsightChartData series, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 12, 
        )
      ),
      charts.Series(
        id: "Diastolic",
        data: chartData,
        domainFn: (HealthRecordBpInsightChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBpInsightChartData series, _) => series.diastolicReading,
        colorFn: (HealthRecordBpInsightChartData series, _) => series.barDiaColor,
        labelAccessorFn: (HealthRecordBpInsightChartData series, _) => series.diastolicReading.toString() + "\nmm/Hg",
        insideLabelStyleAccessorFn: (HealthRecordBpInsightChartData series, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 12, 
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
              barGroupingType: charts.BarGroupingType.stacked,
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
                charts.SeriesLegend(
                  position: charts.BehaviorPosition.top,
                ),
              ],
              barRendererDecorator: charts.BarLabelDecorator(
                labelPosition: charts.BarLabelPosition.inside,
              ),
              domainAxis: charts.OrdinalAxisSpec(
                viewport: charts.OrdinalViewport(firstList, 3),
                renderSpec: charts.NoneRenderSpec(),
              ),
            )
          ,)
        ],
      )
    );
  }
}

class HealthRecordBpInsightChartData{
  final String dayOfPregnancy;
  final int systolicReading, diastolicReading;
  final charts.Color barSysColor, barDiaColor;
  HealthRecordBpInsightChartData({
    @required this.dayOfPregnancy, @required this.systolicReading, @required this.diastolicReading, 
      @required this.barSysColor, @required this.barDiaColor,
  });
}