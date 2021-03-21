import 'dart:ffi';
import 'package:bundle_of_joy/foodIntake/foodIntakeBloodSugarTips.dart';
import 'package:bundle_of_joy/widgets/recordChart/recordChartData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'recordChart/recordChartWidget.dart';

class RecordBloodSugarWidget extends StatelessWidget {
  final Color chartBeforeColor, chartColorAfter;
  final String svgSrc;
  final double bSugarBefore;
  final double bSugarAfter;
  final List<RecordChartData> chartData;
  
  const RecordBloodSugarWidget({
    Key key,
    this.svgSrc,
    this.bSugarBefore,
    this.bSugarAfter,
    this.chartBeforeColor,
    this.chartColorAfter,
    this.chartData,
  }) : super(key: key);

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
              offset: Offset(30, 17),
              blurRadius: 23,
              spreadRadius: -13,
              color: Color(0xFFE6E6E6),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    "Blood Pressue Reading",
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
              margin: EdgeInsets.only(top: 15.0,),
              child: Table(
                //border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5,),
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
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  color: chartBeforeColor,
                                ),
                                child: Text(
                                  bSugarBefore.toString() + " mmol/L",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Before meal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.033,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ] 
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 5,),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  color: chartColorAfter,
                                ),
                                child: Text(
                                  bSugarAfter.toString() + " mmol/L",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "2 hours after meal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.033,
                                    color: Colors.black.withOpacity(0.65),
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
            ),
            RecordChartWidget(chartData: chartData,),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: FlatButton(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    context: context, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                    ),
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: FoodIntakeBloodSugarTips(),
                    )
                  );
                },
                child: Text(
                  "Cancel •",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ), 
              ),
            ),
          ],
        ), 
      ),
    );
  }
}