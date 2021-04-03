import 'package:bundle_of_joy/widgets/bojAnalyzer/healthRecordBpAnalyzer.dart';
import 'package:bundle_of_joy/widgets/bojAnalyzer/healthRecordBsAnalyzer.dart';
import 'package:bundle_of_joy/widgets/bojInsight/healthRecordBpInsight.dart';
import 'package:bundle_of_joy/widgets/bojInsight/healthRecordBqInsight.dart';
import 'package:bundle_of_joy/widgets/bojInsight/healthRecordbsInsight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HealthRecordPregnancyWidget extends StatelessWidget {
  final String svgSrcDate;
  final int dayOfPregnancy;
  final DateTime recordDate;
  //final String svgSrcEstimatedDate;
  const HealthRecordPregnancyWidget({
    Key key,
    @required this.svgSrcDate, @required this.dayOfPregnancy, @required this.recordDate,
    //this.svgSrcEstimatedDate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime firstPregnancyDay, recordTakenDate, estimatedBabyDueDate;
    String formattedEstimatedBabyDueDate;
    var test;

    recordTakenDate = recordDate;
    firstPregnancyDay = recordTakenDate.subtract(Duration(days: dayOfPregnancy));
    estimatedBabyDueDate = firstPregnancyDay.add(Duration(days: 280));
    formattedEstimatedBabyDueDate = DateFormat('dd MMM yyyy').format(estimatedBabyDueDate);
    test = estimatedBabyDueDate.difference(recordTakenDate).inDays;
    
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
                SvgPicture.asset(svgSrcDate, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 8.0,),
                  child: Text(
                    "Day of Pregnancy",
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
                "This section display the day of your pregnancy during the record is created.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                "Day " + dayOfPregnancy.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(svgSrcDate, height: 23, width: 23,),
                  Container(
                    padding: EdgeInsets.only(left: 8.0,),
                    child: Text(
                      "Estimated Baby Due Date",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                "This section display the estimated due date of your baby.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                formattedEstimatedBabyDueDate,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 1.0),
              child: Text(
                test.toString() + " days away from the estimated due date.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthRecordBloodPressureWidget extends StatelessWidget {
  final String svgSrc;
  final int bPressureSystolic, bPressureDiastolic;
  const HealthRecordBloodPressureWidget({
    Key key, @required this.svgSrc, @required this.bPressureSystolic, @required this.bPressureDiastolic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
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
                SvgPicture.asset(svgSrc, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    "Blood Pressure Reading",
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
                "Your blood pressure reading in both systolic and diastolic categoty during the record is created.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0,),
              child: Table(
                //border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8,),
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
                              Text(
                                bPressureSystolic.toString() + " mm/Hg",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Systolic Category",
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
                          padding: EdgeInsets.only(top: 8, bottom: 8,),
                          child: Column(
                            children: [
                              Text(
                                bPressureDiastolic.toString() + " mm/Hg",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),  
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Diastolic Category",
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
            HealthRecordBloodPressureAnalyzer(
              svgSrc: "assets/icons/testAM.svg",
              bPressureSystolic: bPressureSystolic,
              bPressureDiastolic: bPressureDiastolic,
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: HealthRecordBloodPressureInsight(
                svgSrc: "assets/icons/testAM.svg",
              ),
            )
          ],
        ), 
      ),
    );
  }
}

class HealthRecordBloodSugarWidget extends StatelessWidget {
  final String svgSrc;
  final double bGlucoseReading;
  const HealthRecordBloodSugarWidget({
    Key key, @required this.svgSrc, @required this.bGlucoseReading,
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
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                "This section display your blood glucose reading during the record is created.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                bGlucoseReading.toString() + " mmol/L",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            HealthRecordBloodSugarAnalyzer(
              svgSrc: "assets/icons/testAM.svg",
              bSugarReading: bGlucoseReading,
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              child: HealthRecordBloodSugarInsight(
                svgSrc: "assets/icons/testAM.svg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthRecordBodyPhysiqueWidget extends StatefulWidget {
  final String svgSrc;
  final int heightReading, weightReading;
  const HealthRecordBodyPhysiqueWidget({
    Key key, @required this.svgSrc, @required this.heightReading, @required this.weightReading,
  }) : super(key: key);

  @override
  _HealthRecordBodyPhysiqueWidgetState createState() => _HealthRecordBodyPhysiqueWidgetState();
}

class _HealthRecordBodyPhysiqueWidgetState extends State<HealthRecordBodyPhysiqueWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
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
                SvgPicture.asset(widget.svgSrc, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
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
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                "Your weight and height reading during the record is created.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0,),
              child: Table(
                //border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8,),
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
                              Text(
                                widget.weightReading.toString() + " kg",
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
                            ] 
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8,),
                          child: Column(
                            children: [
                              Text(
                                widget.heightReading.toString() + " cm",
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
                            ] 
                          ),
                        ),
                      ),
                    ]
                  ), 
                ],
              ),
            ),
            HealthRecordBodyPhysiqueInsight(
              svgSrc: "assets/icons/testAM.svg",
            )
          ],
        ), 
      ),
    );
  }
}