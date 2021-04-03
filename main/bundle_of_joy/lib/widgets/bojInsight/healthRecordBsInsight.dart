import 'package:bundle_of_joy/foodIntake/foodIntakeBloodSugarTips.dart';
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
  List dayOfPregnancyListString = []; List<int> dayOfPregnancyListInt = []; List bloodSugarList = [];

  Future getAllRecords() async{
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
  }

  void initState(){
    super.initState();
    getAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStyle = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle linkTextStyle = TextStyle(color: Colors.blue, fontSize: MediaQuery.of(context).size.width * 0.035,);
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
            });

            listFirstElement =  dayOfPregnancyListString[0];
            List<HealthRecordBsInsightChartData> chartData = [
              for (var x in zip([dayOfPregnancyListString, bloodSugarList]))
              HealthRecordBsInsightChartData(
                dayOfPregnancy: x[0], 
                measurement: x[1], 
                barColor: charts.ColorUtil.fromDartColor(appbar1),
                /*barColor: (x[1] < 5.1)? charts.ColorUtil.fromDartColor(Colors.red)
                  : (x[1] < 7.1)? charts.ColorUtil.fromDartColor(Colors.green)
                  : (x[1] < 10.1)? charts.ColorUtil.fromDartColor(Colors.lime)
                  : (x[1] < 13.1)? charts.ColorUtil.fromDartColor(Colors.orange)
                  : charts.ColorUtil.fromDartColor(Colors.red),*/
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
                              text: " health records saved on the database. All of the health records will be split into 4 blood glucose condition category.",
                            ),
                          ])),
                      ),
                      HealthRecordInsightTableWidget(
                        excellentRecordsCount: excellentRecordsCount.toString(),
                        goodRecordsCount: goodRecordsCount.toString(),
                        accpetableRecordsCount: acceptableRecordsCount.toString(),
                        poorRecordsCount: poorRecordsCount.toString(),
                      )
                      
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
                        style: normalTextStyle,
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

class HealthRecordInsightTableWidget extends StatelessWidget {
  final String excellentRecordsCount, goodRecordsCount, accpetableRecordsCount, poorRecordsCount;
  HealthRecordInsightTableWidget({
    this.excellentRecordsCount, this.goodRecordsCount, this.accpetableRecordsCount, this.poorRecordsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      child: Table(
        //border: TableBorder.all(color: Colors.black),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8,),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 0.5, 
                        color: Colors.black.withOpacity(0.65),
                      ),
                    )
                  ),
                  child: Column(
                    children: [
                      Text(
                        excellentRecordsCount + " Records",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3,),
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.green,
                        ),
                        child: Text(
                          "Excellent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ] 
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8,),
                  child: Column(
                    children: [
                      Text(
                        goodRecordsCount + " Records",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3,),
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.lime,
                        ),
                        child: Text(
                          "Good",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ] 
                  ),
                ),
              ),
            ]
          ), 
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8,),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 0.5, 
                        color: Colors.black.withOpacity(0.65),
                      ),
                    )
                  ),
                  child: Column(
                    children: [
                      Text(
                        accpetableRecordsCount + " Records",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3,),
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.orange,
                        ),
                        child: Text(
                          "Acceptable",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ] 
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8,),
                  child: Column(
                    children: [
                      Text(
                        poorRecordsCount + " Records",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3,),
                        padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Colors.red,
                        ),
                        child: Text(
                          "Poor",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ] 
                  ),
                ),
              ),
            ]
          ), 
        ],
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