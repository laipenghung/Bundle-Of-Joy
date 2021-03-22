import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordDateTimeWidget extends StatelessWidget {
  final String svgSrcDate;
  final String svgSrcTime;
  final String date;
  final String time;
  const RecordDateTimeWidget({
    Key key,
    this.svgSrcDate,
    this.svgSrcTime,
    this.date,
    this.time,
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
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                date,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.056,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                "The date you record this intake.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            SizedBox(height: 25.0,),
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
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                time,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.055,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Text(
                "The time you record this intake.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
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