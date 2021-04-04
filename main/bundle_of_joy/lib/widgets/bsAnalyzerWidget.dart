import 'package:bundle_of_joy/widgets/tipsScreens/foodIntakeBloodSugarTips.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'chartWidgets/recordChartWidget.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BloodSugarAnalyzerWidget extends StatelessWidget {
  final String svgSrc;
  final double bSugarBefore;
  final double bSugarAfter;
  
  const BloodSugarAnalyzerWidget({
    Key key,
    this.svgSrc,
    this.bSugarBefore,
    this.bSugarAfter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle linkTextStyle = TextStyle(color: Colors.blue, fontSize: MediaQuery.of(context).size.width * 0.035,);
    String bsCondBefore, bsCondAfter, bsCondFeedBefore, bsCondFeedAfter;
    Color bsCondColorBefore, bsCondColorAfter;
    
    if(bSugarBefore < 5.1){
      bsCondColorBefore = Colors.red;
      bsCondBefore = "Too Low";
    }else if(bSugarBefore < 7.1){
      bsCondColorBefore = Colors.green;
      bsCondBefore = "Excellent";
    }else if(bSugarBefore < 10.1){
      bsCondColorBefore = Colors.lime;
      bsCondBefore = "Good";
    }else if(bSugarBefore < 13.1){
      bsCondColorBefore = Colors.orange;
      bsCondBefore = "Acceptable";
    }else{
      bsCondColorBefore = Colors.red;
      bsCondBefore = "Poor";
    }

    if(bSugarAfter < 5.1){
      bsCondColorAfter = Colors.red;
      bsCondAfter = "Too Low";
    }else if(bSugarAfter < 6.1){
      bsCondColorAfter = Colors.green;
      bsCondAfter = "Excellent";
    }else if(bSugarAfter < 8.1){
      bsCondColorAfter = Colors.lime;
      bsCondAfter = "Good";
    }else if(bSugarAfter < 10.1){
      bsCondColorAfter = Colors.orange;
      bsCondAfter = "Acceptable";
    }else{
      bsCondColorAfter = Colors.red;
      bsCondAfter = "Poor";
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
            SvgPicture.asset(svgSrc, height: 23, width: 23,),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0),
              child: Text(
                "BoJ Blood Sugar Analyzer™",
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
            "BoJ Blood Sugar Analyzer™ will provide you feedback on the condition of your Blood Sugar based on the Blood Sugar reading you provided.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        RecordChartWidget(chartData: chartData,),
        Container(
          child: Column(
            children: <Widget>[
              //Blood Sugar before meal
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 4.0),
                child: Text(
                  "Blood Sugar Reading (Before meal)",
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
                        bSugarBefore.toString() + " mmol/L",
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  "Blood Sugar Reading (2 hours after meal)",
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
                        bSugarAfter.toString() + " mmol/L",
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
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: normalTextStye,
                    children: <TextSpan>[
                      TextSpan(
                        text: "If you wish to learn more on how BoJ Blood Sugar Analyzer™ use the blood sugar reading to analyze your blood sugar condition." +
                          " You can ",
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
                              builder: (context) => SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: FoodIntakeBloodSugarTips(),
                              )
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