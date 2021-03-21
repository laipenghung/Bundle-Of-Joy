import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

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