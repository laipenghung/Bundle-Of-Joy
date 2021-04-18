import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
              primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.StaticNumericTickProviderSpec(
                  <charts.TickSpec<num>>[
                    charts.TickSpec<num>(0), charts.TickSpec<num>(3), charts.TickSpec<num>(6),
                      charts.TickSpec<num>(9), charts.TickSpec<num>(12), charts.TickSpec<num>(15),
                  ]
                )
              ),
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
            )
          ,)
        ],
      )
    );
  }
}

class RecordChartData{
  final String period;
  final double bsReading;
  final charts.Color barColour;

  RecordChartData(
    {@required this.period,
    @required this.bsReading,
    @required  this.barColour,}
  );
}


