import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/tipsScreens/foodIntake_Bs_Tips.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BloodSugarAnalyzerWidget extends StatelessWidget {
  final String svgSrc;
  final double bSugarBefore, bSugarAfter;

  const BloodSugarAnalyzerWidget({
    Key key,
    this.svgSrc,
    this.bSugarBefore,
    this.bSugarAfter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.035,
    );
    TextStyle linkTextStyle = TextStyle(
      color: Colors.blue,
      fontSize: MediaQuery.of(context).size.width * 0.035,
    );
    String bsCondBefore, bsCondAfter, bsCondFeedBefore, bsCondFeedAfter;
    Color bsCondColorBefore, bsCondColorAfter;

    if (bSugarBefore < 4) {
      bsCondColorBefore = Colors.red;
      bsCondBefore = "Too Low";
      bsCondFeedBefore = lowBloodSugar;
    } else if (bSugarBefore < 6.1) {
      bsCondColorBefore = Colors.green;
      bsCondBefore = "Excellent";
      bsCondFeedBefore = excellentBloodSugar;
    } else if (bSugarBefore < 8.1) {
      bsCondColorBefore = Colors.lime.shade800;
      bsCondBefore = "Good";
      bsCondFeedBefore = goodBloodSugar;
    } else if (bSugarBefore < 10.1) {
      bsCondColorBefore = Colors.yellow.shade900;
      bsCondBefore = "Acceptable";
      bsCondFeedBefore = acceptableBloodSugar;
    } else {
      bsCondColorBefore = Colors.red;
      bsCondBefore = "Poor";
      bsCondFeedBefore = poorBloodSugar;
    }

    if (bSugarAfter < 5) {
      bsCondColorAfter = Colors.red;
      bsCondAfter = "Too Low";
      bsCondFeedAfter = lowBloodSugar;
    } else if (bSugarAfter < 7.1) {
      bsCondColorAfter = Colors.green;
      bsCondAfter = "Excellent";
      bsCondFeedAfter = excellentBloodSugar;
    } else if (bSugarAfter < 10.1) {
      bsCondColorAfter = Colors.lime.shade800;
      bsCondAfter = "Good";
      bsCondFeedAfter = goodBloodSugar;
    } else if (bSugarAfter < 13.1) {
      bsCondColorAfter = Colors.yellow.shade900;
      bsCondAfter = "Acceptable";
      bsCondFeedAfter = acceptableBloodSugar;
    } else {
      bsCondColorAfter = Colors.red;
      bsCondAfter = "Poor";
      bsCondFeedAfter = poorBloodSugar;
    }

    List<RecordChartData> chartData = [
      RecordChartData(
        period: "Before",
        bsReading: bSugarBefore,
        barColour: charts.ColorUtil.fromDartColor(bsCondColorBefore),
      ),
      RecordChartData(
        period: "After",
        bsReading: bSugarAfter,
        barColour: charts.ColorUtil.fromDartColor(bsCondColorAfter),
      ),
    ];

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(
              svgSrc,
              height: 23,
              width: 23,
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
              child: Text(
                "BoJ Analyzer™",
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
          margin: EdgeInsets.only(
            top: 5.0,
          ),
          child: Text(
            "BoJ Analyzer™ will provide you feedback on the condition of your Blood Glucose based on the Blood Glucose reading you provided.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        RecordChartWidget(
          chartData: chartData,
        ),
        Container(
          child: Column(
            children: <Widget>[
              //Blood Glucose before meal
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  "Blood Glucose Reading (Before meal)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        bSugarBefore.toString() + " mmol/L",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: bsCondColorBefore,
                      ),
                      child: Text(
                        bsCondBefore,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color(0xFFf5f5f5),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: bsCondColorBefore.withOpacity(0.65)),
                ),
                child: Text(
                  bsCondFeedBefore,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
              //Blood Glucose after meal
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Blood Glucose Reading (2 hours after meal)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        bSugarAfter.toString() + " mmol/L",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: bsCondColorAfter,
                      ),
                      child: Text(
                        bsCondAfter,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color(0xFFf5f5f5),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: bsCondColorAfter.withOpacity(0.65)),
                ),
                child: Text(
                  bsCondFeedAfter,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
              //Learn more
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(style: normalTextStye, children: <TextSpan>[
                      TextSpan(
                        text: "If you wish to learn more on how BoJ Analyzer™ use the blood glucose reading you provided to analyze your blood glucose condition." + " You can ",
                      ),
                      TextSpan(
                          text: "tap here",
                          style: linkTextStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                  ),
                                  isScrollControlled: true,
                                  builder: (context) => Container(
                                        height: MediaQuery.of(context).size.height * 0.8,
                                        child: SingleChildScrollView(
                                          physics: ClampingScrollPhysics(),
                                          child: FoodIntakeBloodSugarTips(),
                                        ),
                                      ));
                            }),
                      TextSpan(
                        text: " for more info.",
                      ),
                    ])),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RecordChartWidget extends StatelessWidget {
  final List<RecordChartData> chartData;
  RecordChartWidget({this.chartData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<RecordChartData, String>> series = [
      charts.Series(
          id: "Blood Sugar",
          data: chartData,
          domainFn: (RecordChartData series, _) => series.period,
          measureFn: (RecordChartData series, _) => series.bsReading,
          colorFn: (RecordChartData series, _) => series.barColour,
          labelAccessorFn: (RecordChartData series, _) => "${series.period}: ${series.bsReading.toString()}" + " mmol/L",
          insideLabelStyleAccessorFn: (RecordChartData series, _) => charts.TextStyleSpec(
                color: charts.MaterialPalette.white,
                fontSize: 12,
              ))
    ];

    return Container(
        margin: EdgeInsets.only(
          bottom: 10.0,
        ),
        height: 150,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,
                vertical: false,
                primaryMeasureAxis: charts.NumericAxisSpec(
                    tickProviderSpec: charts.StaticNumericTickProviderSpec(<charts.TickSpec<num>>[
                  charts.TickSpec<num>(0),
                  charts.TickSpec<num>(3),
                  charts.TickSpec<num>(6),
                  charts.TickSpec<num>(9),
                  charts.TickSpec<num>(12),
                  charts.TickSpec<num>(15),
                ])),
                behaviors: [
                  charts.ChartTitle(
                    "Blood Glucose Reading (mmol/L)",
                    behaviorPosition: charts.BehaviorPosition.bottom,
                    titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                    titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                  ),
                ],
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.NoneRenderSpec(),
                ),
              ),
            )
          ],
        ));
  }
}

class RecordChartData {
  final String period;
  final double bsReading;
  final charts.Color barColour;

  RecordChartData({
    @required this.period,
    @required this.bsReading,
    @required this.barColour,
  });
}
