import 'package:bundle_of_joy/MotherHealthTracking/healthTracking_Function.dart';
import 'package:bundle_of_joy/widgets/motherHealthRecordWidgets.dart';
import 'package:bundle_of_joy/widgets/recordBloodGlucoseWidget.dart';
import 'package:bundle_of_joy/widgets/recordBloodPressureWidget.dart';
import 'package:bundle_of_joy/widgets/recordBodyPhysiqueWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../main.dart';

class HealthTrackingAddSummary extends StatefulWidget {
  final String selectedDate, selectedTime;
  final double bSugar, height, weight;
  final int dayOfPregnancy, bPressure_dia, bPressure_sys;
  final BuildContext addHealthScreenContext;

  HealthTrackingAddSummary({Key key, this.selectedDate, this.selectedTime, this.bPressure_dia, this.bPressure_sys, this.bSugar, this.dayOfPregnancy, this.height, this.weight, this.addHealthScreenContext}) : super(key: key);

  @override
  _HealthTrackingAddSummaryState createState() => _HealthTrackingAddSummaryState();
}

class _HealthTrackingAddSummaryState extends State<HealthTrackingAddSummary> {
  MyApp main = MyApp();
  String notificationMessage;

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
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Health Record', notificationMessage, notificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    HealthTrackingFunction healthTrackingFunction = HealthTrackingFunction();
    DateTime parsedDate = DateTime.parse(widget.selectedDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    DateTime parsedTime = DateTime.parse(widget.selectedDate + " " + widget.selectedTime);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    int bPressure_dia = widget.bPressure_dia, bPressure_sys = widget.bPressure_sys, dayOfPregnancy = widget.dayOfPregnancy;
    double bSugar = widget.bSugar, height = widget.height, weight = widget.weight;

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Review Health Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
          ),
        ),
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
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
              dateDesc: motherRecordDateDesc,
              time: formattedTime,
              timeDesc: motherRecordTimeDesc,
            ),
            // Pregnancy Info section
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Pregnancy Info",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            HealthRecordPregnancyWidget(
              svgSrcDate: "assets/icons/calendarPreg.svg",
              svgSrcDatePreg: "assets/icons/babyDate.svg",
              dayOfPregnancy: dayOfPregnancy,
              recordDate: parsedDate,
            ),
            // Blood Pressure section
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Blood Pressure",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            RecordBloodPressureWidget(
              svgSrc: "assets/icons/blood-pressure.svg",
              bPressure_dia: bPressure_dia,
              bPressure_sys: bPressure_sys,
              showAnalyzer: false,
            ),
            // Blood Sugar section
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Blood Glucose",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            RecordBloodGlucoseWidget(
              svgSrc: "assets/icons/blood-donation.svg",
              bloodSugarReading: bSugar,
              showAnalyzer: false,
            ),
            // Body Physique section
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Body Physique",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            RecordBodyPhysiqueWidget(
              svgSrc: "assets/icons/body-mass-index.svg",
              weightReading: weight,
              heightReading: height,
              showAnalyzer: false,
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
                  color: appbar1,
                  textColor: Colors.white,
                  onPressed: () {
                    if (widget.bPressure_dia != null && widget.bPressure_sys != null && widget.weight != null) {
                      notificationMessage = "Health Record upload successfully.";
                      healthTrackingFunction.uploadHealthRecord(
                        widget.selectedDate,
                        widget.selectedTime,
                        widget.bPressure_dia,
                        widget.bPressure_sys,
                        widget.bSugar,
                        widget.dayOfPregnancy,
                        widget.height,
                        widget.weight,
                        widget.addHealthScreenContext,
                        context,
                      ).then((value) => _showNotification(notificationMessage));
                    }
                  },
                  child: Text(
                    "Upload Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
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
