import 'package:bundle_of_joy/foodIntake/foodIntake_Track_Function.dart';
import 'package:bundle_of_joy/widgets/recordBloodSugarWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import '../main.dart';

class FoodIntakeTrackAddSummary extends StatefulWidget {
  final String selectedDate, selectedTime, bSugarBefore, bSugarAfter;
  final Map foodMap;

  FoodIntakeTrackAddSummary({Key key, this.selectedDate, this.selectedTime, this.foodMap, this.bSugarBefore, this.bSugarAfter}) : super(key: key);

  @override
  _FoodIntakeTrackAddSummaryState createState() => _FoodIntakeTrackAddSummaryState();
}

class _FoodIntakeTrackAddSummaryState extends State<FoodIntakeTrackAddSummary> {
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
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Food Intake Tracking', notificationMessage, notificationDetails);
  }

  void _showNotificationAfter2Hour(notificationMessage) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Kuching"));
    var scheduledTime = tz.TZDateTime.now(tz.local).add(const Duration(hours: 2));

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Schedule Id',
      'Notification After 2 Hour',
      'Notification After 2 Hour',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
      styleInformation: BigTextStyleInformation(''),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.zonedSchedule(0, 'Food Intake Tracking', notificationMessage, scheduledTime, notificationDetails, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    FoodIntakeTrackFunction foodIntakeTrackFunction = FoodIntakeTrackFunction();
    DateTime parsedDate = DateTime.parse(widget.selectedDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    DateTime parsedTime = DateTime.parse(widget.selectedDate + " " + widget.selectedTime);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    Map food = widget.foodMap;
    double bSugarBefore = double.parse(widget.bSugarBefore);
    //double bSugarAfter = double.parse(widget.bSugarAfter);

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Review Food Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Conusmed Food",
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
              svgSrc: "assets/icons/healthy-food.svg",
              title: motherRecordListTitle,
              titleDesc: motherRecordListTitleDesc,
              foodName: food.keys.toList(),
              foodQty: food.values.toList(),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Blood Sugar",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            //Blood Sugar section
            RecordBloodSugarDoneWidget(
              svgSrc: "assets/icons/blood-donation.svg",
              bSugarBefore: bSugarBefore,
              bSugarAfter: (widget.bSugarAfter == null) ? null : double.parse(widget.bSugarAfter),
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
                    if (widget.bSugarAfter != null) {
                      notificationMessage = "Food Record upload successfully.";
                      foodIntakeTrackFunction
                          .uploadFoodRecordDone(
                            widget.selectedDate,
                            widget.selectedTime,
                            widget.bSugarBefore,
                            widget.bSugarAfter,
                            widget.foodMap,
                            context,
                          )
                          .then((value) => _showNotification(notificationMessage));
                    } else {
                      notificationMessage = "Remember to update your food record after 2 hours.";
                      foodIntakeTrackFunction
                          .uploadFoodRecordPending(
                            widget.selectedDate,
                            widget.selectedTime,
                            widget.bSugarBefore,
                            widget.bSugarAfter,
                            widget.foodMap,
                            context,
                          )
                          .then((value) => _showNotificationAfter2Hour(notificationMessage));
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
