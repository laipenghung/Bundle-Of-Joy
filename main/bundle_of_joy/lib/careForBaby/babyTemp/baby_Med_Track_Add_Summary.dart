import 'dart:developer';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:bundle_of_joy/careForBaby/careForBaby_Function.dart';
import 'package:bundle_of_joy/widgets/recordBodyTempWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class BabyMedTrackAddSummary extends StatefulWidget {
  final String selectedDate, selectedTime, bTempBefore, bTempAfter, selectedBabyID;
  final Map medsMap;
  final BuildContext babyAddMedBuildContext;
  BabyMedTrackAddSummary({Key key, @required this.selectedDate, @required this.selectedTime, @required this.bTempBefore, @required this.bTempAfter, 
    @required this.selectedBabyID, @required this.medsMap, @required this.babyAddMedBuildContext
  }) : super(key: key);

  @override
  _BabyMedTrackAddSummaryState createState() => _BabyMedTrackAddSummaryState();
}

class _BabyMedTrackAddSummaryState extends State<BabyMedTrackAddSummary> {
  MyApp main = MyApp();
  String notificationMessage, notificationMessageAfter;

  void _showNotification(notificationMessage) async {
    await notification(notificationMessage);
  }

  Future<void> notification(notificationMessage) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Channel Id',
      'Channel title',
      'channel body',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
      styleInformation: BigTextStyleInformation(''),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Baby Medicine Intake Tracking', notificationMessage, notificationDetails);
  }

  void _showNotificationAfter4Hour(notificationMessageAfter) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kuching"));
    var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(hours: 4));

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Schedule Id',
      'Notification After 4 Hour',
      'Notification After 4 Hour',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
      styleInformation: BigTextStyleInformation(''),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.zonedSchedule(0, 'Baby Medicine Intake Tracking', notificationMessageAfter, scheduledTime, notificationDetails, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    CareForBabyFunction careForBabyFunction = CareForBabyFunction();
    DateTime parsedDate = DateTime.parse(widget.selectedDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    DateTime parsedTime = DateTime.parse(widget.selectedDate + " " + widget.selectedTime);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    Map medicine = widget.medsMap;
    double tempBeforeMeds = double.parse(widget.bTempBefore);
    //double tempAfterMeds = double.parse(widget.bTempAfter);

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Summary",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 18.0,
                left: 13.0,
              ),
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
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
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
            RecordFoodMedsWidget(
              svgSrc: "assets/icons/drugs.svg",
              title: babyMedsRecordListTitle,
              titleDesc: babyMedsRecordListTitleDesc,
              foodName: medicine.keys.toList(),
              foodQty: medicine.values.toList(),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
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
              tempAferMeds: (widget.bTempAfter == null) ? null : double.parse(widget.bTempAfter),
            ),
            Container(
              margin: EdgeInsets.only(left: 13, right: 13, bottom: 25),
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
                    if (widget.bTempAfter != null) {
                      notificationMessage = "Baby Medicine Record upload successfully.";
                      careForBabyFunction
                          .uploadBabyMedsRecordDone(widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.bTempBefore, widget.bTempAfter, widget.medsMap, context, widget.babyAddMedBuildContext)
                          .then((value) => _showNotification(notificationMessage));
                    } else {
                      notificationMessage = "Baby Medicine Record upload successfully. Remember to update your baby's body temperature reading after 4 hours.";
                      notificationMessageAfter = "Hey it's already 4 hours, remember to update your baby medicine record.";
                      careForBabyFunction
                          .uploadBabyMedsRecordPending(widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.bTempBefore, widget.bTempAfter, widget.medsMap, context, widget.babyAddMedBuildContext)
                          .then((value) {
                            _showNotification(notificationMessage);
                            _showNotificationAfter4Hour(notificationMessageAfter);
                          });
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
    );
  }
}
