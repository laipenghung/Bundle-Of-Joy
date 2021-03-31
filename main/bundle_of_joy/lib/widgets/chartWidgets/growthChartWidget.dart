import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GrowthChartWidget extends StatefulWidget {
  final List<GrowthChartData> chartData;
  final String firstList, measurement, xAxisLabel, yAxisLabel;
  GrowthChartWidget({this.chartData, this.firstList, this.xAxisLabel, this.yAxisLabel, this.measurement});

  @override
  _GrowthChartWidgetState createState() => _GrowthChartWidgetState();
}

class _GrowthChartWidgetState extends State<GrowthChartWidget> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<GrowthChartData, String>> series = [
      charts.Series(
        id: "GrowthChart",
        data: widget.chartData,
        domainFn: (GrowthChartData series, _) => series.month,
        measureFn: (GrowthChartData series, _) => series.growthValue,
        colorFn: (GrowthChartData series, _) => series.barColor,
        labelAccessorFn: (GrowthChartData series, _) => "M ${series.month}\n" + series.growthValue.toString() + " ${widget.measurement}",
        insideLabelStyleAccessorFn: (GrowthChartData series, _) => charts.TextStyleSpec(
          //color: charts.MaterialPalette.gray.shade800,
          color: charts.MaterialPalette.white,
          fontSize: 11, 
        )
      )
    ];

    return Container(
      margin: EdgeInsets.only(bottom: 5.0,),
      height: 350,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Expanded(child:charts.BarChart(
              series,
              animate: true,
              vertical: true,
              //primaryMeasureAxis: charts.NumericAxisSpec(
                //tickProviderSpec: charts.StaticNumericTickProviderSpec(
                  //<charts.TickSpec<num>>[
                    //charts.TickSpec<num>(0),
                    //charts.TickSpec<num>(20),
                    //charts.TickSpec<num>(40),
                    //charts.TickSpec<num>(60),
                    //charts.TickSpec<num>(80),
                    //charts.TickSpec<num>(100)
                  //]
                //)
              //),
              behaviors: [
                charts.SlidingViewport(),
                charts.PanAndZoomBehavior(),
                charts.ChartTitle(
                  widget.yAxisLabel,
                  behaviorPosition: charts.BehaviorPosition.start,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
                charts.ChartTitle(
                  widget.xAxisLabel,
                  behaviorPosition: charts.BehaviorPosition.bottom,
                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea,
                  titleStyleSpec: charts.TextStyleSpec(fontSize: 12),
                ),
              ],
              barRendererDecorator: charts.BarLabelDecorator(
                labelPosition: charts.BarLabelPosition.inside,
              ),
              
              domainAxis: charts.OrdinalAxisSpec(
                viewport: charts.OrdinalViewport(widget.firstList, 4),
                renderSpec: charts.NoneRenderSpec(),
              ),
            )
          ,)
        ],
      )
    );
  }
}

class GrowthChartData{
  final String month;
  final double growthValue;
  final charts.Color barColor;
  GrowthChartData({
    @required this.month, @required this.growthValue, @required this.barColor,
  });
}