import 'package:bundle_of_joy/foodIntake/foodIntake_Track_Function.dart';
import 'package:bundle_of_joy/widgets/record_BloodSugar_Widget.dart';
import 'package:bundle_of_joy/widgets/record_DateTime_Widget.dart';
import 'package:bundle_of_joy/widgets/record_FoodMeds_Widget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';
import '../main.dart';

class FoodIntakeTrackAddSummary extends StatefulWidget {
  final String selectedDate, selectedTime, bSugarBefore, bSugarAfter;
  final Map foodMap;
  final BuildContext addFoodScreenContext;

  FoodIntakeTrackAddSummary({Key key, this.selectedDate, this.selectedTime, this.foodMap, this.bSugarBefore, this.bSugarAfter, this.addFoodScreenContext}) : super(key: key);

  @override
  _FoodIntakeTrackAddSummaryState createState() => _FoodIntakeTrackAddSummaryState();
}

class _FoodIntakeTrackAddSummaryState extends State<FoodIntakeTrackAddSummary> {
  MyApp main = MyApp();
  String notificationMessage, notificationMessageAfter2hour;

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

  void _showNotificationAfter2Hour(notificationMessageAfter2hour) async {
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
    await main.createState().flutterLocalNotificationsPlugin.zonedSchedule(0, 'Food Intake Tracking', notificationMessageAfter2hour, scheduledTime, notificationDetails,
        androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
    FoodIntakeTrackFunction foodIntakeTrackFunction = FoodIntakeTrackFunction();
    DateTime parsedDate = DateTime.parse(widget.selectedDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    DateTime parsedTime = DateTime.parse(widget.selectedDate + " " + widget.selectedTime);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    Map food = widget.foodMap;
    // if(widget.bSugarBefore != null){double bSugarBefore = double.parse(widget.bSugarBefore);}

    //double bSugarAfter = double.parse(widget.bSugarAfter);

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Review Food Record",
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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: 13.0,
                left: 13.0,
              ),
              child: Text(
                "Consumed Food",
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
                "Blood Glucose",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: Colors.black,
                ),
              ),
            ),
            //Blood Glucose section
            RecordBloodSugarDoneWidget(
              svgSrc: "assets/icons/blood-donation.svg",
              bSugarBefore: (widget.bSugarBefore == null) ? null : double.parse(widget.bSugarBefore),
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
                            widget.addFoodScreenContext,
                          )
                          .then((value) => _showNotification(notificationMessage));
                    } else if (widget.bSugarAfter == null && widget.bSugarBefore == null) {
                      notificationMessage = "Food Record upload successfully.";
                      foodIntakeTrackFunction
                          .uploadFoodRecordDone(
                            widget.selectedDate,
                            widget.selectedTime,
                            widget.bSugarBefore,
                            widget.bSugarAfter,
                            widget.foodMap,
                            context,
                            widget.addFoodScreenContext,
                          )
                          .then((value) => _showNotification(notificationMessage));
                    } else {
                      notificationMessage = "Food Record upload successfully. Remember to update your food record after 2 hours.";
                      notificationMessageAfter2hour = "Hey it's already 2 hours, remember to update your food record.";
                      foodIntakeTrackFunction
                          .uploadFoodRecordPending(
                        widget.selectedDate,
                        widget.selectedTime,
                        widget.bSugarBefore,
                        widget.bSugarAfter,
                        widget.foodMap,
                        context,
                        widget.addFoodScreenContext,
                      )
                          // .then((value) => _showNotificationAfter2Hour(notificationMessage))
                          .then((value) {
                        _showNotification(notificationMessage);
                        _showNotificationAfter2Hour(notificationMessageAfter2hour);
                      });
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
