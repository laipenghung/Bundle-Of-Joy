import 'package:bundle_of_joy/foodIntake/foodIntakeBloodSugarTips.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/flutter_svg.dart';

class HealthRecordBloodPressureAnalyzer extends StatelessWidget {
  final String svgSrc;
  final int bPressureSystolic, bPressureDiastolic;
  
  const HealthRecordBloodPressureAnalyzer({
    Key key, @required this.svgSrc, @required  this.bPressureSystolic, @required this.bPressureDiastolic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle linkTextStyle = TextStyle(color: Colors.blue, fontSize: MediaQuery.of(context).size.width * 0.035,);
    String bpCondSystolic, bpCondDiastolic, bpCondFeedSys, bpCondFeedDia;
    Color bpCondColorSystolic, bpCondColorDiastolic;
    
    if(bPressureSystolic < 120){
      bpCondColorSystolic = Colors.green;
      bpCondSystolic = "Normal";
    }else if(bPressureSystolic < 130){
      bpCondColorSystolic = Colors.lime.shade700;
      bpCondSystolic = "Elevated";
    }else if(bPressureSystolic < 140){
      bpCondColorSystolic = Colors.yellow.shade800;
      bpCondSystolic = "Hypertension Stage 1";
    }else if(bPressureSystolic < 180){
      bpCondColorSystolic = Colors.yellow.shade900;
      bpCondSystolic = "Hypertension Stage 2";
    }else{
      bpCondColorSystolic = Colors.red;
      bpCondSystolic = "Hypertensive Crisis";
    }

    if(bPressureDiastolic < 80){
      bpCondColorDiastolic = Colors.lime.shade800;
      bpCondDiastolic = "Normal Or Elevated";
    }else if(bPressureDiastolic < 90){
      bpCondColorDiastolic = Colors.yellow.shade800;
      bpCondDiastolic = "Hypertension Stage 1";
    }else if(bPressureDiastolic < 120){
      bpCondColorDiastolic = Colors.yellow.shade900;
      bpCondDiastolic = "Hypertension Stage 2";
    }else{
      bpCondColorDiastolic = Colors.red;
      bpCondDiastolic = "Hypertensive Crisis";
    }

    List<HealthRecordBloodPressureChartData> chartData = [
      HealthRecordBloodPressureChartData(
        category: "Systolic", 
        bpReading: bPressureSystolic, 
        barColour: charts.ColorUtil.fromDartColor(bpCondColorSystolic),
      ),
      HealthRecordBloodPressureChartData(
        category: "Diastolic", 
        bpReading: bPressureDiastolic, 
        barColour: charts.ColorUtil.fromDartColor(bpCondColorDiastolic),
      ),
    ];

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(svgSrc, height: 23, width: 23,),
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
          margin: EdgeInsets.only(top: 5.0, ),
          child: Text(
            "BoJ Analyzer™ will provide you feedback on condition of your Blood Pressure based on the your " + 
                "Blood Pressure reading saved on our database.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        HealthRecordBloodPressureChart(chartData: chartData,),
        Container(
          child: Column(
            children: <Widget>[
              //Blood Pressure Systolic
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  "Blood Pressure Reading (Systolic)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5,),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        bPressureSystolic.toString() + " mm/Hg",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(left: 10,),
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: bpCondColorSystolic,
                      ),
                      child: Text(
                        bpCondSystolic,
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
                  border: Border.all(color: bpCondColorSystolic.withOpacity(0.65)),
                ),
                child: Text(
                  "test test test test test test test test test test test test test test test test test test test test test test ",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
              //Blood Sugar after meal
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Blood Pressure Reading (Diastolic)",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 5,),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        bPressureDiastolic.toString() + " mm/Hg",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    
                    Container(
                      margin: EdgeInsets.only(left: 10,),
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: bpCondColorDiastolic,
                      ),
                      child: Text(
                        bpCondDiastolic,
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
                  border: Border.all(color: bpCondColorDiastolic.withOpacity(0.65)),
                ),
                child: Text(
                  "test test test test test test test test test test test test test test test test test test test test test test ",
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
          ),
        ),
      ],
    );
  }
}

class HealthRecordBloodPressureChart extends StatelessWidget {
  final List<HealthRecordBloodPressureChartData> chartData;
  HealthRecordBloodPressureChart({this.chartData});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<HealthRecordBloodPressureChartData, String>> series = [
      charts.Series(
        id: "bloodPressure",
        data: chartData,
        domainFn: (HealthRecordBloodPressureChartData series, _) => series.category,
        measureFn: (HealthRecordBloodPressureChartData series, _) => series.bpReading,
        colorFn: (HealthRecordBloodPressureChartData series, _) => series.barColour,
        labelAccessorFn: (HealthRecordBloodPressureChartData series, _) => "${series.category}: ${series.bpReading.toString()}mm/Hg",
        insideLabelStyleAccessorFn: (HealthRecordBloodPressureChartData series, _) => charts.TextStyleSpec(
          color: charts.MaterialPalette.white,
          fontSize: 15, 
        )
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 10.0,),
      height: 150,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(child:charts.BarChart(
              series,
              animate: true,
              vertical: false,
              // primaryMeasureAxis: charts.NumericAxisSpec(
                // tickProviderSpec: charts.StaticNumericTickProviderSpec(
                  // <charts.TickSpec<num>>[
                    // charts.TickSpec<num>(0), charts.TickSpec<num>(3), charts.TickSpec<num>(6),
                      // charts.TickSpec<num>(9), charts.TickSpec<num>(12), charts.TickSpec<num>(15),
                  // ]
                // )
              // ),
              behaviors: [
                charts.ChartTitle(
                  "Blood Pressure Reading (mm/Hg)",
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
              ],
              barRendererDecorator: charts.BarLabelDecorator<String>(),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.NoneRenderSpec(),
              ),
            )
          ,)
        ],
      )
    );
  }
}


class HealthRecordBloodPressureChartData{
  final String category;
  final int bpReading;
  final charts.Color barColour;

  HealthRecordBloodPressureChartData({
    @required this.category, @required this.bpReading, @required  this.barColour,}
  );
}