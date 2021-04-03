import 'package:bundle_of_joy/foodIntake/foodIntakeBloodSugarTips.dart';
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
              bloodPressureSystolicList.add(int.parse(doc.data()["mh_bloodPressure_sys"].toString()));
              bloodPressureDiastolicList.add(int.parse(doc.data()["mh_bloodPressure_dia"].toString()));
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
                barDiaColor: charts.ColorUtil.fromDartColor(background2),
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
                        margin: EdgeInsets.only(top: 10.0,),
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

class HealthRecordInsightDiastolicWidget extends StatefulWidget {
  @override
  _HealthRecordInsightDiastolicWidgetState createState() => _HealthRecordInsightDiastolicWidgetState();
}

class _HealthRecordInsightDiastolicWidgetState extends State<HealthRecordInsightDiastolicWidget> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("health_record");
  int normalEleDiaRecordsCount = 0, hyperStage1DiaCount = 0, hyperStage2DiaCount = 0, hyperCrisisDiaCount = 0; 
  Future getAllRecords() async{
    //Diastolic Reading
    var a = await collectionReference.where("mh_bloodPressure_dia", isLessThan: 80).get();
    a.docs.forEach((doc) {setState(() => normalEleDiaRecordsCount++);});
    var b = await collectionReference.where("mh_bloodPressure_dia", isGreaterThan: 79).where("mh_bloodPressure_dia", isLessThan: 90).get();
    b.docs.forEach((doc) {setState(() => hyperStage1DiaCount++);});
    var c = await collectionReference.where("mh_bloodPressure_dia", isGreaterThan: 89).where("mh_bloodPressure_dia", isLessThan: 121).get();
    c.docs.forEach((doc) {setState(() => hyperStage2DiaCount++);});
    var d = await collectionReference.where("mh_bloodPressure_dia", isGreaterThan: 120).get();
    d.docs.forEach((doc) {setState(() => hyperCrisisDiaCount++);});
  }

  void initState(){
    super.initState();
    getAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Table(
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8,),
                      child: Column(
                        children: [
                          Text(
                            normalEleDiaRecordsCount.toString() + " Records",
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
                              color: Colors.lime.shade800,
                            ),
                            child: Text(
                              "Normal & Elevated",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
                            hyperStage1DiaCount.toString() + " Records",
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
                              color: Colors.yellow.shade800,
                            ),
                            child: Text(
                              "Hypertension Stage 1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
                      child: Column(
                        children: [
                          Text(
                            hyperStage2DiaCount.toString() + " Records",
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
                              color: Colors.yellow.shade900,
                            ),
                            child: Text(
                              "Hypertension Stage 2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
                            hyperCrisisDiaCount.toString() + " Records",
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
                              "Hypertensive Crisis",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
        ],
      )
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
  Future getAllRecords() async{
    //Systolic Reading
    var u = await collectionReference.where("mh_bloodPressure_sys", isLessThan: 120).get();
    u.docs.forEach((doc) {setState(() => normalSysRecordsCount++);});
    var v = await collectionReference.where("mh_bloodPressure_sys", isGreaterThan: 119).where("mh_bloodPressure_sys", isLessThan: 130).get();
    v.docs.forEach((doc) {setState(() => elevatedSysRecordsCount++);});
    var w = await collectionReference.where("mh_bloodPressure_sys", isGreaterThan: 129).where("mh_bloodPressure_sys", isLessThan: 140).get();
    w.docs.forEach((doc) {setState(() => hyperStage1SysCount++);});
    var x = await collectionReference.where("mh_bloodPressure_sys", isGreaterThan: 139).where("mh_bloodPressure_sys", isLessThan: 181).get();
    x.docs.forEach((doc) {setState(() => hyperStage2SysCount++);});
    var y = await collectionReference.where("mh_bloodPressure_sys", isGreaterThan: 180).get();
    y.docs.forEach((doc) {setState(() => hyperCrisisSysCount++);});
  }

  void initState(){
    super.initState();
    getAllRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          Table(
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8,),
                      child: Column(
                        children: [
                          Text(
                            normalSysRecordsCount.toString() + " Records",
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
                              "Normal",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
                            elevatedSysRecordsCount.toString() + " Records",
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
                              color: Colors.lime.shade700,
                            ),
                            child: Text(
                              "Elevated",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
                      child: Column(
                        children: [
                          Text(
                            hyperStage1SysCount.toString() + " Records",
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
                              color: Colors.yellow.shade800,
                            ),
                            child: Text(
                              "Hypertension Stage 1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
                            hyperStage2SysCount.toString() + " Records",
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
                              color: Colors.yellow.shade900,
                            ),
                            child: Text(
                              "Hypertension Stage 2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
          Table(
            children: [
              TableRow(
                children: [
                  TableCell(
                    child: Container(
                      padding: EdgeInsets.only(top: 8, bottom: 8,),
                      child: Column(
                        children: [
                          Text(
                            hyperCrisisSysCount.toString() + " Records",
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
                              "Hypertensive Crisis",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038,
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
              )
            ],
          )
        ],
      )
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
        id: "Systolic Category",
        data: chartData,
        domainFn: (HealthRecordBpInsightChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBpInsightChartData series, _) => series.systolicReading,
        colorFn: (HealthRecordBpInsightChartData series, _) => series.barSysColor,
        labelAccessorFn: (HealthRecordBpInsightChartData series, _) => "D-${series.dayOfPregnancy}\n" + series.systolicReading.toString() + "\nmm/Hg",
        insideLabelStyleAccessorFn: (HealthRecordBpInsightChartData series, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 13, 
        )
      ),
      charts.Series(
        id: "Diastolic Category",
        data: chartData,
        domainFn: (HealthRecordBpInsightChartData series, _) => series.dayOfPregnancy,
        measureFn: (HealthRecordBpInsightChartData series, _) => series.diastolicReading,
        colorFn: (HealthRecordBpInsightChartData series, _) => series.barDiaColor,
        labelAccessorFn: (HealthRecordBpInsightChartData series, _) => series.diastolicReading.toString() + "\nmm/Hg",
        insideLabelStyleAccessorFn: (HealthRecordBpInsightChartData series, _) => charts.TextStyleSpec(
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