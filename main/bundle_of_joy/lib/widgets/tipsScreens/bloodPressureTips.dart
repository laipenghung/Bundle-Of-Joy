import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodPressureTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List bloodPressureConditionSystolicList = ["Normal", "Elevated", "Hypertension Stage 1", "Hypertension Stage 2", "Hypertensive Crisis"];
    List bloodPressureReadingSystolicList = ["Less than 120", "120 - 129", "130 - 139", "140 or higher", "Higher than 180"];
    List bloodPressureConditionDiastolicList = ["Normal or Elevated", "Hypertension Stage 1", "Hypertension Stage 2", "Hypertensive Crisis"];
    List bloodPressureReadingDiastolicList = ["Less than 80", "80 - 89", "90 or higher", "Higher than 120"];
    TextStyle normalTextStyle = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.035, fontStyle: FontStyle.italic,);
    TextStyle hyperlinkTextStyle = TextStyle(color: Colors.blue.shade700, fontSize: MediaQuery.of(context).size.width * 0.035, fontStyle: FontStyle.italic,);

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
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
                    "Blood Pressure",
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
                        "What Systolic, Diastolic Blood Pressure Numbers Mean",
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
                        "When you get your blood pressure numbers, there are two of them. The first, or “top” one, is your systolic blood pressure. The second, or “bottom,” one is diastolic blood pressure. Knowing both is important and could save your life.",
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
                        "What Does the Systolic Blood Pressure Number Mean?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.053,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "When your heart beats, it squeezes and pushes blood through your arteries to the rest of your body. This force creates pressure on those blood vessels, and that's your systolic blood pressure. Here’s how to understand your systolic blood pressure number:",
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
                        "• Normal: Below 120\n• Elevated: 120-129\n• Stage 1 high blood pressure (also called hypertension): 130-139\n• Stage 2 hypertension: 140 or more\n• Hypertensive crisis: 180 or more",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 8),
                      child: Text(
                        "What Does the Diastolic Blood Pressure Number Mean?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.053,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "The diastolic reading, or the bottom number, is the pressure in the arteries when the heart rests between beats. This is the time when the heart fills with blood and gets oxygen. This is what your diastolic blood pressure number means:",
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
                        "• Normal: Lower than 80\n• Stage 1 hypertension: 80-89\n• Stage 2 hypertension: 90 or more\n• Hypertensive crisis: 120 or more",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.black.withOpacity(0.65),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 5, bottom: 8),
                      child: Text(
                        "How BoJ Analyzer™ Analyse Your Blood Pressure Reading",
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
                        "The chart that display at the section below has more details. Just a quick tip, even if your diastolic number is normal (lower than 80), you can have elevated blood pressure if the systolic reading is 120-129.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.043,
                          color: Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Blood Pressure Stages Table (Systolic)",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
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
                                    "Blood Pressure Stage",
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
                                    "Blood Pressure (mm/Hg)",
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
                          for (var x in zip([bloodPressureConditionSystolicList, bloodPressureReadingSystolicList]))
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
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Blood Pressure Stages Table (Diastolic)",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
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
                                    "Blood Pressure Stage",
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
                                    "Blood Pressure (mm/Hg)",
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
                          for (var x in zip([bloodPressureConditionDiastolicList, bloodPressureReadingDiastolicList]))
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
                            ..onTap = () => launch("https://www.webmd.com/hypertension-high-blood-pressure/guide/diastolic-and-systolic-blood-pressure-know-your-numbers#1")
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
              )
            ],
          ),
        )
      ],
    );
  }
}