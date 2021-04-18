import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class BabyFoodRecordInsight extends StatefulWidget {
  final String svgSrc, selectedBabyID;
  const BabyFoodRecordInsight({
    Key key, @required this.svgSrc, @required this.selectedBabyID, 
  }) : super(key: key);

  @override
  _BabyFoodRecordInsightState createState() => _BabyFoodRecordInsightState();
}

class _BabyFoodRecordInsightState extends State<BabyFoodRecordInsight> {
  int totalRecordsCount = 0, symptomFoundRecordsCount = 0, symptomNotFoundRecordsCount = 0;
  List recordCountList = [];
  
  @override
  Widget build(BuildContext context) {
    TextStyle normalWidgetTextStyle = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035,);
    TextStyle boldWidgetTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.035,);
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("baby")
    .doc(widget.selectedBabyID).collection("babyFoodIntake_Done");
    
    return SizedBox(
      child: FutureBuilder<QuerySnapshot>(
        future: collectionReference.orderBy('selectedDate', descending: true).orderBy('selectedTime', descending: true).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((doc) {
              totalRecordsCount++;
              if(doc.data()["symptomsAndAllergies"] == true){symptomFoundRecordsCount++;}
              else{symptomNotFoundRecordsCount++;}
            });

            recordCountList.add(symptomFoundRecordsCount);
            recordCountList.add(symptomNotFoundRecordsCount);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(widget.svgSrc, height: 23, width: 23,),
                      Container(
                        padding: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 5.0),
                        child: Text(
                          "BoJ Insight™",
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
                    margin: EdgeInsets.only(top: 3.0, ),
                    child: Text(
                      "BoJ Insight™ will use your baby's food records that stored on the database and structures the data into useful information" + 
                          " hence providing you insights in what BoJ Insight™ has derived out of the entire data.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        color: Colors.black.withOpacity(0.65),
                      ),
                    ),
                  ),
                  (totalRecordsCount > 1)
                  ?Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: BabyFoodRecordInsightTableWidget(
                          recordCountList: recordCountList,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: double.infinity,
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(style: normalWidgetTextStyle, children: <TextSpan>[
                            TextSpan(text: "BoJ Insight™ found that you have "),
                            TextSpan(
                              text: totalRecordsCount.toString(),
                              style: boldWidgetTextStyle,
                            ),
                            TextSpan(
                              text: " baby's food records saved on the database. All of your baby's food records will be split into 2 category.",
                            ),
                          ])),
                      ),
                    ],
                  )
                  : InsightNotEnoughRecord(),
                ],
              );
            }
          } else if (snapshot.hasError) {
            print("error");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class BabyFoodRecordInsightTableWidget extends StatelessWidget {
  final List recordCountList;
  BabyFoodRecordInsightTableWidget({
    this.recordCountList
  });

  @override
  Widget build(BuildContext context) {
    List babyAfterMealBehaviorConditionList = ["Found", "Not Found"];

    return Container(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.0),
        child: Table(
          columnWidths: {0: FlexColumnWidth(6), 1: FlexColumnWidth(4),},
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        right: BorderSide(
                          width: 0.25, 
                          color: Colors.white,
                        ),
                      )
                    ),
                    width: double.infinity,
                    child: Text(
                      "Symptoms and Allergies",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        left: BorderSide(width: 0.25, color: Colors.white,),
                        right: BorderSide(width: 0.25, color: Colors.white,),
                      )
                    ),
                    width: double.infinity,
                    child: Text(
                      "Records Count",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ]
            ),
            for (var x in zip([babyAfterMealBehaviorConditionList, recordCountList]))
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                        right: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                      )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4),
                    width: double.infinity,
                    child: Text(
                      x[0],
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                        left: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                      )
                    ),
                    width: double.infinity,
                    child: Text(
                      (x[1] != 0)? x[1].toString() + " Record(s)" : "-",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.033,
                        color: Colors.black.withOpacity(0.75),
                      ),
                    ),
                  ),
                ),
              ]
            ), 
          ],
        ),
      ),
    );
  }
}