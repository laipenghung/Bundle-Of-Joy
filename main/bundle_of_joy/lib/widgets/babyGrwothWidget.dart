import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/chartWidgets/growthChartWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class BabyGrowthWidget extends StatefulWidget {
  final String graphTitle, graphDesc, svgSrcGraph, tableTitle, tableDesc, svgSrcTable, listFirstElement,
    xAxisLabel, yAxisLabel, measurement, tableMeasurement;
  final List<GrowthChartData> chartData;
  final List<int> ageListInt;
  final List growthValueList;
  final bool growthTrack;
  BabyGrowthWidget({Key key, @required this.graphTitle, @required this.graphDesc, @required this.tableTitle,
    @required this.tableDesc, @required this.svgSrcGraph, @required this.svgSrcTable, @required this.chartData,
    @required this.listFirstElement, @required this.ageListInt, @required this.growthValueList, 
    @required this.xAxisLabel, @required this.yAxisLabel, @required this.measurement, @required this.tableMeasurement,
    @required this.growthTrack}) : super(key: key);

  @override
  _BabyGrowthWidgetState createState() => _BabyGrowthWidgetState();
}

class _BabyGrowthWidgetState extends State<BabyGrowthWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(15, 15),
              blurRadius: 20,
              spreadRadius: 15,
              color: Color(0xFFE6E6E6),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(widget.svgSrcGraph, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    widget.graphTitle,
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
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                widget.graphDesc,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: GrowthChartWidget(
                chartData: widget.chartData, 
                firstList: widget.listFirstElement,
                measurement: widget.measurement,
                xAxisLabel: widget.xAxisLabel,
                yAxisLabel: widget.yAxisLabel,
              )
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset(widget.svgSrcTable, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    widget.tableTitle,
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
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                widget.tableDesc,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
              child: Table(
                columnWidths: {0: FlexColumnWidth(4), 1: FlexColumnWidth(4),},
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
                            "Age",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
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
                              left: BorderSide(
                                width: 0.25, 
                                color: Colors.white,
                              ),
                            )
                          ),
                          width: double.infinity,
                          child: Text(
                            widget.tableMeasurement,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  for (var x in zip([widget.ageListInt, widget.growthValueList]))
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
                            (x[0] < 12)
                              ? "${x[0]} month(s)" 
                              : (x[0].remainder(12) == 0)
                                ? "${x[0]~/12} year(s)" 
                                : "${x[0]~/12} year(s) ${x[0].remainder(12)} month(s)",
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
                            x[1].toString(),
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 5),
              child: (widget.growthTrack == true)? BabyGrowthWeightText() : BabyGrowthHeightText(),
            )
          ],
        ), 
      ),
    );
  }
}