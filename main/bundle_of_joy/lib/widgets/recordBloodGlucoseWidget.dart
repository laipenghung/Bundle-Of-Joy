import 'package:bundle_of_joy/widgets/bojInsight/healthRecord_Bp_Insight.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/motherHealthRecordWidgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordBloodGlucoseWidget extends StatelessWidget {
  final String svgSrc;
  final double bloodSugarReading;
  final bool showAnalyzer;

  const RecordBloodGlucoseWidget({
    Key key,
    this.svgSrc,
    this.bloodSugarReading,
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
                "Your blood glucose reading.",
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
              child: Text(
                bloodSugarReading.toString() + " mmol/L",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            (showAnalyzer == true) ? Column(children: <Widget>[
              HealthRecordBloodSugarWidget(
                svgSrc: "assets/icons/blood-donation.svg",
                bGlucoseReading: bloodSugarReading
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: HealthRecordBloodPressureInsight(
                  svgSrc: "assets/icons/insight.svg",
                ),
              ),
            ]) : BloodGlucoseAddDoneText(),
          ],
        ),
      ),
    );
  }
}
