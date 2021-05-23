import 'package:bundle_of_joy/widgets/bojInsight/healthRecord_Bp_Insight.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/motherHealthRecordWidgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordBodyPhysiqueWidget extends StatelessWidget {
  final String svgSrc;
  final double weightReading, heightReading;
  final bool showAnalyzer;

  const RecordBodyPhysiqueWidget({
    Key key,
    this.svgSrc,
    this.weightReading,
    this.heightReading,
    this.showAnalyzer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
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
                SvgPicture.asset(
                  svgSrc,
                  height: 23,
                  width: 23,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "Weight & Height Reading",
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
                top: 8.0,
              ),
              child: Text(
                "Your weight & height reading.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: Table(
                //border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 0.5,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            )),
                        child: Column(children: [
                          Text(
                            weightReading.toString() + " kg",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              "Weight (kg)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.033,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        child: Column(children: [
                          Text(
                            heightReading.toString() + " cm",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              "Height (cm)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.033,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            (showAnalyzer == true) ? Column(children: <Widget>[
              HealthRecordBodyPhysiqueWidget(
                svgSrc: "assets/icons/blood-pressure.svg",
                weightReading: weightReading,
                heightReading: heightReading,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: HealthRecordBloodPressureInsight(
                  svgSrc: "assets/icons/insight.svg",
                ),
              ),
            ]) : BodyPhysiqueAddDoneText(),
          ],
        ),
      ),
    );
  }
}
