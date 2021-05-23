import 'package:bundle_of_joy/careForBaby/babyTemp/baby_Med_Track_Update.dart';
import 'package:bundle_of_joy/careForBaby/babyTemp/baby_Med_Track_View.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/sneakPeek/sneakPeek_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BabyMedTrackSneakPeak extends StatefulWidget {
  final String medIntakeRecordID, selectedBabyID;
  final CollectionReference collectionReference;
  final bool completeRecord;

  BabyMedTrackSneakPeak({
    @required this.medIntakeRecordID,
    @required this.selectedBabyID,
    @required this.collectionReference,
    @required this.completeRecord,
  });
  @override
  _BabyMedTrackSneakPeakState createState() => _BabyMedTrackSneakPeakState();
}

class _BabyMedTrackSneakPeakState extends State<BabyMedTrackSneakPeak> {
  double tempAfterMeds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Flexible(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Baby Medicine Record",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer(flex: 2,),
              Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(
                          Icons.close_rounded,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )),
                ),
              )
            ],
          ),
        ),
        Container(
          child: FutureBuilder<DocumentSnapshot>(
            future: widget.collectionReference.doc(widget.medIntakeRecordID).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
                String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
                DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
                String formattedTime = DateFormat('h:mm a').format(parsedTime);
                Map meds = snapshot.data.data()["medsMap"];
                double tempBeforeMeds = double.parse(snapshot.data.data()["bTempBefore"]);
                if (widget.completeRecord == true) {
                  tempAfterMeds = double.parse(snapshot.data.data()["bTempAfter"]);
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      SneakPeakDateTimeWidget(
                        svgSrcDate: "assets/icons/testAM.svg",
                        svgSrcTime: "assets/icons/clock.svg",
                        date: formattedDate,
                        time: formattedTime,
                      ),
                      SneakPeakFoodMedsWidget(
                        svgSrc: "assets/icons/drugs.svg",
                        foodMedName: meds.keys.toList(),
                        foodMedQty: meds.values.toList(),
                        food: false,
                      ),
                      SneakPeakBodyTemperatureWidget(
                        svgSrc: "assets/icons/thermometer.svg",
                        bTempBefore: tempBeforeMeds,
                        bTempAfter: tempAfterMeds,
                      ),
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            textColor: Colors.black.withOpacity(0.6),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              "Close",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 13, right: 13, bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {
                              widget.collectionReference.doc(widget.medIntakeRecordID).delete();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Delete Medicine Record",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 13, right: 13, bottom: 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            color: appbar2,
                            textColor: Colors.white,
                            onPressed: () {
                              if (widget.completeRecord == true) {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BabyMedTrackView(
                                              babyTempRecordID: widget.medIntakeRecordID,
                                              selectedBabyID: widget.selectedBabyID,
                                            )));
                              } else {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BabyMedTrackUpadte(
                                              babyTempRecordID: widget.medIntakeRecordID,
                                              selectedBabyID: widget.selectedBabyID,
                                              babyMedRecordListContext: context,
                                            )));
                              }
                            },
                            child: Text(
                              (widget.completeRecord == true) ? "View Detailed Medicine Record" : "Update Medicine Record",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                shadows: <Shadow>[
                                  Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                                ],
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                print("error");
              }
              return CircularProgressIndicator();
            },
          ),
        )
      ],
    );
  }
}
