import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordListViewWidget extends StatelessWidget {
  final String svgSrc, recordPrimaryTitle, recordPrimaryDesc, recordSecondaryTitle, recordSecondaryDesc;
  //final String recordDate, recordTime;
  final bool babyFoodRecord, symptomsAllergies, completeBabyFoodRecord, motherHealthRecord;
  final Function press, delete, longPress;
  const RecordListViewWidget({
    Key key,
    @required this.svgSrc, @required this.recordPrimaryDesc, @required this.recordSecondaryDesc, @required this.press, @required this.longPress,
       @required this.delete, @required this.babyFoodRecord, this.symptomsAllergies, this.completeBabyFoodRecord, @required this.motherHealthRecord,
       @required this.recordPrimaryTitle, @required this.recordSecondaryTitle,
  }) : super(key: key);

  Widget babyFoodRecordTrueWidget(BuildContext context){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 3,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Text(
                    recordSecondaryTitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.036,
                      color: Colors.black.withOpacity(0.65),
                    )
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    recordSecondaryDesc,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.043,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ],
            ),
          ),
          (symptomsAllergies == true) 
          ? Flexible(
            flex: 5,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.red,
                ),
                child: Text(
                  "Symptoms Allergies",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                ),
              ),
            ),
          )
          : Flexible(
            flex: 5,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget babyFoodRecordFalseWidget(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              recordSecondaryTitle,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.036,
                color: Colors.black.withOpacity(0.65),
              )
            ),
          ),
          Container(
            width: double.infinity,
            child: Text(
              recordSecondaryDesc,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.043,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(15, 15),
            blurRadius: 20,
            spreadRadius: 15,
            color: Color(0xFFE6E6E6),
          ),
        ],
      ),
      child: InkWell(
        onTap: press,
        onLongPress: longPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Center(
                  child: SvgPicture.asset(svgSrc, height: 40, width: 40),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 10,
                      child: Container(
                        //padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                recordPrimaryTitle,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.036,
                                  color: Colors.black.withOpacity(0.65),
                                )
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Text(
                                recordPrimaryDesc,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.043,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      child: (babyFoodRecord == true && completeBabyFoodRecord == true)
                        ? babyFoodRecordTrueWidget(context) 
                        : babyFoodRecordFalseWidget(context),
                    ),
                  ],
                ),
              )
            ),
            Flexible(
              flex: 1,
              child: Container(
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,), 
                      onPressed: delete,
                    )
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}