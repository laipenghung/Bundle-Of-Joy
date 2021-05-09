import 'package:bundle_of_joy/widgets/bojInsight/mother_FoodRecord_Bs_Insight.dart';
import 'package:bundle_of_joy/widgets/bojAnalyzer/foodRecord_Bs_Analyzer.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordBloodSugarDoneWidget extends StatelessWidget {
  final String svgSrc;
  final double bSugarBefore;
  final double bSugarAfter;
  final bool showAnalyzer;

  const RecordBloodSugarDoneWidget({
    Key key,
    this.svgSrc,
    this.bSugarBefore,
    this.bSugarAfter,
    this.showAnalyzer,
  }) : super(key: key);

  Widget bloodSugarNotNull(BuildContext context){
    return Column(
      children: [
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
                        bSugarBefore.toString() + " mmol/L",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
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
                        //bSugarAfter.toString() + " mmol/L",
                        (bSugarAfter == null) ? "-" : bSugarAfter.toString() + " mmol/L",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
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
                    ]),
                  ),
                ),
              ]),
            ],
          ),
        ),
        (showAnalyzer == true)
        ? Column(children: <Widget>[
            BloodSugarAnalyzerWidget(
              svgSrc: "assets/icons/web-analytics.svg",
              bSugarBefore: bSugarBefore,
              bSugarAfter: bSugarAfter,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: FoodRecordBloodSugarInsight(
                svgSrc: "assets/icons/insight.svg",
              ),
            ),
          ])
        : (bSugarAfter == null)
            ? BloodSugarAddPendingText()
            : BloodSugarAddDoneText()
      ],
    );
  }

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
                    "Blood Glucose Reading",
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
                "Your blood glucose reading before meal and 2 hours after meal.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            (bSugarBefore == null && bSugarAfter == null)? NoBloodSugarWidget() : bloodSugarNotNull(context),
          ],
        ),
      ),
    );
  }
}

class RecordBloodSugarPendingWidget extends StatelessWidget {
  final String svgSrc;
  final double bSugarBefore;

  //final double bSugarAfter;

  const RecordBloodSugarPendingWidget({
    Key key,
    this.svgSrc,
    this.bSugarBefore,

    //this.bSugarAfter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bSugarUpdate;
    TextEditingController textFieldController = TextEditingController();

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
                    "Blood Glucose Reading",
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
                "Your blood glucose reading before meal and 2 hours after meal.",
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
                            bSugarBefore.toString() + " mmol/L",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold,
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
                          TextField(
                            decoration: InputDecoration(hintText: "Blood Glucose Reading"),
                            onChanged: (value) {
                              bSugarUpdate = value;
                            },
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
                        ]),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            BloodSugarAddDoneText(),
          ],
        ),
      ),
    );
  }
}
