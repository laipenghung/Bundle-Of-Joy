import 'package:bundle_of_joy/widgets/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordBodyTempWidget extends StatelessWidget {
  final String svgSrc;
  final double tempBeforeMeds, tempAferMeds;
  
  const RecordBodyTempWidget({
    Key key,
    this.svgSrc,
    this.tempBeforeMeds,
    this.tempAferMeds,
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
          ],),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(svgSrc, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 8.0,),
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
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                "This section display your baby's body temperature before and 2 hours after taking the medicine.",
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
                                tempBeforeMeds.toString() + " °C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Before taking meds",
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
                                (tempAferMeds == null)? "-" : tempAferMeds.toString() + " °C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),  
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "After 2 hours",
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
            (tempAferMeds == null) ? BabyTempRecordAddText() : BabyTempRecordViewText(),
          ],
        ),
      ),
    );
  }
}