import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/tipsScreens/foodIntake_Bs_Tips.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/svg.dart';

class HealthRecordBloodSugarAnalyzer extends StatelessWidget {
  final String svgSrc;
  final double bSugarReading;

  const HealthRecordBloodSugarAnalyzer({
    Key key,
    @required this.svgSrc,
    @required this.bSugarReading,
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
    String bsCond, bsCondFeed;
    Color bsCondColor;

    if (bSugarReading < 4) {
      bsCondColor = Colors.red;
      bsCond = "Too Low";
      bsCondFeed = lowBloodSugar;
    } else if (bSugarReading < 6.1) {
      bsCondColor = Colors.green;
      bsCond = "Excellent";
      bsCondFeed = excellentBloodSugar;
    } else if (bSugarReading < 8.1) {
      bsCondColor = Colors.lime.shade800;
      bsCond = "Good";
      bsCondFeed = goodBloodSugar;
    } else if (bSugarReading < 10.1) {
      bsCondColor = Colors.yellow.shade900;
      bsCond = "Acceptable";
      bsCondFeed = acceptableBloodSugar;
    } else {
      bsCondColor = Colors.red;
      bsCond = "Poor";
      bsCondFeed = poorBloodSugar;
    }

    List<HealthRecordBloodSugarChartData> chartData = [
      HealthRecordBloodSugarChartData(
        period: "BloodGlucose",
        bsReading: bSugarReading,
        barColour: charts.ColorUtil.fromDartColor(bsCondColor),
      ),
    ];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                svgSrc,
                height: 23,
                width: 23,
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 5.0),
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
            //margin: EdgeInsets.only(top: 2.0, ),
            child: Text(
              "BoJ Analyzer™ will provide you feedback on condition of your Blood Glucose based on the your " + "Blood Glucose reading saved on our database.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: Colors.black.withOpacity(0.65),
              ),
            ),
          ),
          HealthRecordBloodSugarChart(
            chartData: chartData,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Blood Glucose Reading",
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
                          bSugarReading.toString() + " mmol/L",
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
                        padding: EdgeInsets.fromLTRB(8, 1, 8, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: bsCondColor,
                        ),
                        child: Text(
                          bsCond,
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
                    border: Border.all(color: bsCondColor.withOpacity(0.65)),
                  ),
                  child: Text(
                    bsCondFeed,
                    textAlign: TextAlign.justify,
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
                          text: "If you wish to learn more on how BoJ Analyzer™ use your blood glucose reading saved on the database " + "to analyze your blood glucose condition. You can ",
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
      ),
    );
  }
}

class HealthRecordBloodSugarChart extends StatelessWidget {
  final List<HealthRecordBloodSugarChartData> chartData;
  HealthRecordBloodSugarChart({this.chartData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HealthRecordBloodSugarChartData, String>> series = [
      charts.Series(
          id: "bloodSugar",
          data: chartData,
          domainFn: (HealthRecordBloodSugarChartData series, _) => series.period,
          measureFn: (HealthRecordBloodSugarChartData series, _) => series.bsReading,
          colorFn: (HealthRecordBloodSugarChartData series, _) => series.barColour,
          labelAccessorFn: (HealthRecordBloodSugarChartData series, _) => "${series.bsReading.toString()}" + " mmol/L",
          insideLabelStyleAccessorFn: (HealthRecordBloodSugarChartData series, _) => charts.TextStyleSpec(
                color: charts.MaterialPalette.white,
                fontSize: 15,
              ))
    ];

    return Container(
        margin: EdgeInsets.only(
          bottom: 10.0,
        ),
        height: 110,
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

class HealthRecordBloodSugarChartData {
  final String period;
  final double bsReading;
  final charts.Color barColour;

  HealthRecordBloodSugarChartData({
    @required this.period,
    @required this.bsReading,
    @required this.barColour,
  });
}
