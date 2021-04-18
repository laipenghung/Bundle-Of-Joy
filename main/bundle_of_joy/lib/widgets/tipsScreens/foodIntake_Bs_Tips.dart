import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodIntakeBloodSugarTips extends StatelessWidget {
  Widget build(BuildContext context) {
    List bloodGlucoseConditionList = ["Excellent", "Good", "Acceptable", "Poor"];
    List bloodGlucoseReadingBeforeList = ["4.0 - 6.0", "6.1 - 8.0", "8.1 - 10.0", "10.0 above"];
    List bloodGlucoseReadingAfterList = ["5.0 - 7.0", "7.1 - 10.0", "10.1 - 13.0", "13.0 above"];
    TextStyle normalTextStyle = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035, fontStyle: FontStyle.italic,);
    TextStyle hyperlinkTextStyle = TextStyle(color: Colors.blue.shade700, fontSize: MediaQuery.of(context).size.width * 0.035, fontStyle: FontStyle.italic,);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(10.0)),
            color: appbar1,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.65),
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 0),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Flexible(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Blood Sugar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(13),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 8),
                      child: Text(
                        "Why Monitor Blood Glucose",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.053,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Checking your blood glucose levels helps you see how your food, exercise, activities, stress, medication and insulin doses are affecting them. Knowing this helps you make any necessary changes to your lifestyle.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 8),
                      child: Text(
                        "What Caused High Blood Glucose Levels",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.053,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "High blood glucose levels (hyperglycaemia) may occur if you have diabetes and do not manage it properly. It can be caused by:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "• Forgetting to take medication, or taking too little medication\n• Not taking proper care with insulin injections\n• Not following meal plans\n• Illness and/or infection\n• Stress ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black.withOpacity(0.65),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Blood glucose levels should be checked with a blood glucose meter regularly, but high levels will provide the following warning symptoms:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "• Frequent passing of urine \n• Increased thirst and hunger\n• Tiredness\n• Difficulty in seeing clearly\n• Weight loss",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black.withOpacity(0.65),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 8),
                      child: Text(
                        "How to Check Blood Glucose",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.053,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "There are many different meters available and each of them works differently. Follow the specific instructions that come with the blood glucose monitor. Your doctor or diabetes care team will help you decide which one to use. Most meters require the following steps to be taken when carrying out a blood sugar test.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "1. Wash hands well with soap and water. Dry them.\n2. Insert a test strip into the reader.\n3. Squeeze your fingers.\n4. Prick the side of your finger with the lancet.\n5. Squeeze out a drop of blood.\n6. Place the drop of blood onto a test strip, ensuring the drop is big enough.\n7. Take the blood glucose reading and record it.\n8. Throw used lancets in a puncture-resistant plastic container or metal tin.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black.withOpacity(0.65),
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 8),
                      child: Text(
                        "How BoJ Analyzer™ Analyse Your Blood Glucose Reading",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.053,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "The table below displays the blood glucose reading before meal. The reading is split into 4 condition category known as Excellent, Good, Acceptable, Poor.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Table(
                        columnWidths: {0: FlexColumnWidth(5), 1: FlexColumnWidth(5),},
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: appbar1,
                                    border: Border(
                                      right: BorderSide(
                                        width: 0.25, 
                                        color: Colors.white,
                                      ),
                                    )
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    "Blood Glucose Condition",
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
                                    color: appbar1,
                                    border: Border(
                                      left: BorderSide(width: 0.25, color: Colors.white,),
                                      right: BorderSide(width: 0.25, color: Colors.white,),
                                    )
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    "Blood Glucose (mmol/L)",
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
                          for (var x in zip([bloodGlucoseConditionList, bloodGlucoseReadingBeforeList]))
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
                                    x[1].toString(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.033,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ), 
                        ],
                      ), 
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "The table below displays the blood glucose reading for 2 hour after meal. The reading is split into 4 condition category known as Excellent, Good, Acceptable, Poor.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Table(
                        columnWidths: {0: FlexColumnWidth(5), 1: FlexColumnWidth(5),},
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: appbar1,
                                    border: Border(
                                      right: BorderSide(
                                        width: 0.25, 
                                        color: Colors.white,
                                      ),
                                    )
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    "Blood Glucose Condition",
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
                                    color: appbar1,
                                    border: Border(
                                      left: BorderSide(width: 0.25, color: Colors.white,),
                                      right: BorderSide(width: 0.25, color: Colors.white,),
                                    )
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    "Blood Glucose (mmol/L)",
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
                          for (var x in zip([bloodGlucoseConditionList, bloodGlucoseReadingAfterList]))
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
                                    x[1].toString(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.033,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          ), 
                        ],
                      ), 
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(style: normalTextStyle, children: <TextSpan>[
                        TextSpan(text: "All the information used in article above were taken from ",),
                        TextSpan(
                          text: "here", 
                          style: hyperlinkTextStyle,
                          recognizer: TapGestureRecognizer() 
                            ..onTap = () => launch("https://www.healthhub.sg/a-z/diseases-and-conditions/669/blood-glucose-monitoring")
                        ),
                        TextSpan(text: " .",),
                      ])),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          color: appbar1,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}