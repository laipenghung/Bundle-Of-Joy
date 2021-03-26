import 'dart:developer';

import 'package:bundle_of_joy/careForBaby/careForBabyFunction.dart';
import 'package:bundle_of_joy/widgets/recordBodyTempWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordListWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class BabyMedTrackAddSummary extends StatefulWidget {
  final String selectedDate, selectedTime, bTempBefore, bTempAfter, selectedBabyID;
  final Map medsMap;
  BabyMedTrackAddSummary({Key key, @required this.selectedDate, this.selectedTime, this.bTempBefore, this.bTempAfter, this.selectedBabyID, this.medsMap}) : super(key: key);

  @override
  _BabyMedTrackAddSummaryState createState() => _BabyMedTrackAddSummaryState();
}

class _BabyMedTrackAddSummaryState extends State<BabyMedTrackAddSummary> {
  MyApp main = MyApp();
  String notificationMessage;
  
  void _showNotification(notificationMessage) async {
    await notification(notificationMessage);
  }

  Future<void> notification(notificationMessage) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Channel Id', 'Channel title', 'channel body', priority: Priority.high, importance: Importance.max, ticker: 'test', styleInformation: BigTextStyleInformation(''),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Baby Medicine Intake Tracking', notificationMessage, notificationDetails);
  }
  
  @override
  Widget build(BuildContext context) {
    CareForBabyFunction careForBabyFunction = CareForBabyFunction();
    DateTime parsedDate = DateTime.parse(widget.selectedDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    DateTime parsedTime = DateTime.parse(widget.selectedDate+ " " + widget.selectedTime);
    String formattedTime =  DateFormat('h:mm a').format(parsedTime);
    Map medicine = widget.medsMap;
    double tempBeforeMeds = double.parse(widget.bTempBefore);
    //double tempAfterMeds = double.parse(widget.bTempAfter);
    
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            stretch: true,
            backgroundColor: appThemeColor,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Container(
                child: Text(
                  "Medicine Intake Record",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 18.0, left: 13.0,),
                  child: Text(
                    "Date and Time",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
                //Widget for display Date and Time
                RecordDateTimeWidget(
                  svgSrcDate: "assets/icons/testAM.svg",
                  svgSrcTime: "assets/icons/clock.svg",
                  date: formattedDate,
                  dateDesc: babyMedsDateDesc,
                  time: formattedTime,
                  timeDesc: babyMedsTimeDesc,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                  child: Text(
                    "Conusmed Medicine",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
                //Widget for display Consumed Food
                RecordListWidget(
                  svgSrc: "assets/icons/drugs.svg",
                  title: babyMedsRecordListTitle,
                  titleDesc: babyMedsRecordListTitleDesc,
                  foodName: medicine.keys.toList(),
                  foodQty: medicine.values.toList(),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                  child: Text(
                    "Body Temperature",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
                //Body Temperature section
                RecordBodyTempWidget(
                  svgSrc: "assets/icons/thermometer.svg",
                  tempBeforeMeds: tempBeforeMeds,
                  tempAferMeds: (widget.bTempAfter == null)? null : double.parse(widget.bTempAfter),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13, right: 13, bottom: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appThemeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if(widget.bTempAfter != null){
                          notificationMessage = "Baby Medicine Record upload successfully.";
                          careForBabyFunction.uploadBabyMedsRecordDone(
                            widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.bTempBefore, widget.bTempAfter, widget.medsMap, context
                          ).then((value) => _showNotification(notificationMessage));
                        }else{
                          notificationMessage = "Remember to update your baby's body temperature reading after 2 hours.";
                          careForBabyFunction.uploadBabyMedsRecordPending(
                            widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.bTempBefore, widget.bTempAfter, widget.medsMap, context
                          ).then((value) => _showNotification(notificationMessage));
                        }
                      },
                      child: Text(
                        "Upload Record",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
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
    );
  }
}