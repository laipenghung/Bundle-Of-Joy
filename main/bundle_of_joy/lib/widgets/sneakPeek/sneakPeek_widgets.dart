import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class SneakPeakDateTimeWidget extends StatelessWidget {
  final String svgSrcDate, svgSrcTime, date, time;
  const SneakPeakDateTimeWidget({
    Key key, @required this.svgSrcDate, @required this.svgSrcTime, @required this.date, @required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
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
                SvgPicture.asset(svgSrcDate, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    "Date",
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
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                date,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.056,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              children: <Widget>[
                SvgPicture.asset(svgSrcTime, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    "Time",
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
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                time,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ), 
      ),
    );
  }
}

class SneakPeakFoodMedsWidget extends StatelessWidget {
  final String svgSrc;
  final List foodMedName, foodMedQty;
  final bool food;

  const SneakPeakFoodMedsWidget({
    Key key, @required this.svgSrc, @required this.foodMedName, @required this.foodMedQty, @required this.food,
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
              offset: Offset(15, 15),
              blurRadius: 20,
              spreadRadius: 15,
              color: Color(0xFFE6E6E6),
            ),
          ],),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(svgSrc, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 8.0,),
                  child: Text(
                    (food == true)? "Consumed Food" : "Consumed Medicine",
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
              margin: EdgeInsets.only(top: 10.0),
              child: Table(
                children: [
                  for (var x in zip([foodMedName, foodMedQty]))
                  TableRow(
                    children: [
                      TableCell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                x[0].toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "x " + x[1].toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black.withOpacity(0.65),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SneakPeakBloodSugarWidget extends StatelessWidget {
  final String svgSrc;
  final double bSugarBefore, bSugarAfter;

  const SneakPeakBloodSugarWidget({
    Key key, @required this.svgSrc, @required this.bSugarBefore, @required this.bSugarAfter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                top: 15.0,
                bottom: 15.0,
              ),
              child: Table(
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
          ],
        ),
      ),
    );
  }
}

class SneakPeakBodyTemperatureWidget extends StatelessWidget {
  final String svgSrc;
  final double bTempBefore, bTempAfter;

  const SneakPeakBodyTemperatureWidget({
    Key key, @required this.svgSrc, @required this.bTempBefore, @required this.bTempAfter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                    "Body Temperature Reading",
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
                top: 15.0,
                bottom: 15.0,
              ),
              child: Table(
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
                            bTempBefore.toString() + "°C",
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
                            (bTempAfter == null) ? "-" : bTempAfter.toString() + "°C",
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
          ],
        ),
      ),
    );
  }
}

class SneakPeakAfterMealBehaviorWidget extends StatelessWidget {
  final String svgSrc;
  final bool symptomsAndAllergies, completeRecords;
  const SneakPeakAfterMealBehaviorWidget({Key key, @required this.svgSrc, @required this.symptomsAndAllergies, @required this.completeRecords}) : super(key: key);

  Widget completeRecord(BuildContext context, symptomsAndAllergies){
    Color conditionColor;
    String conditionText;

    if (symptomsAndAllergies == true) {
      conditionColor = Colors.red;
      conditionText = "Were found";
    } else {
      conditionColor = Colors.green;
      conditionText = "Were not found";
    }

    return Column(
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
                left: 8.0,
              ),
              child: Text(
                "Symptoms and Allergies",
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
              top: 15.0,
              bottom: 8.0,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 3),
                  child: Text(
                    "Signs of symptoms and allergies",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.043,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  //padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          right: 5,
                        ),
                        padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: conditionColor,
                        ),
                        child: Text(
                          conditionText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "2 hours after the meal.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            //color: Colors.black.withOpacity(0.65),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Widget pendingRecord(BuildContext context){
    return Column(
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
                left: 8.0,
              ),
              child: Text(
                "Symptoms and Allergies",
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
          margin: EdgeInsets.only(top: 10),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color(0xFFf5f5f5),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.red.withOpacity(0.4)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 8),
                    child: SvgPicture.asset(
                      "assets/icons/warning.svg",
                      height: 25,
                      width: 25,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "This food record is still in pending state. To update it, tap on the update food record button located at the bottom to update your baby's food record.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
        child: (completeRecords == true)? completeRecord(context, symptomsAndAllergies) : pendingRecord(context), 
      ),
    );
  }
}