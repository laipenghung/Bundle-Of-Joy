import 'package:bundle_of_joy/careForBaby/careForBaby_Function.dart';
import 'package:bundle_of_joy/widgets/recordBabyAfterMealWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../main.dart';

class BabyFoodIntakeAddSummary extends StatefulWidget {
  final String selectedBabyID, selectedDate, selectedTime, symptomsAndAllergiesDesc;
  final bool symptomsAndAllergies, completeFoodRecord;
  final Map foodMap;
  final BuildContext babyAddFoodBuildContext;
  BabyFoodIntakeAddSummary({Key key, this.selectedBabyID, this.selectedDate, this.selectedTime, this.foodMap, this.completeFoodRecord, 
    this.symptomsAndAllergies, this.symptomsAndAllergiesDesc, @required this.babyAddFoodBuildContext
  }) : super(key: key);

  @override
  _BabyFoodIntakeAddSummaryState createState() => _BabyFoodIntakeAddSummaryState();
}

class _BabyFoodIntakeAddSummaryState extends State<BabyFoodIntakeAddSummary> {
  CareForBabyFunction careForBabyFunction = CareForBabyFunction();
  String notificationMessage, notificationMessageAfter;

  MyApp main = MyApp();

  void showNotification(String notificationMessage) async {
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
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Baby Food Intake Tracking', notificationMessage, notificationDetails);
  }

  void _showNotificationAfter2Hour(notificationMessageAfter) async {
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
    await main.createState().flutterLocalNotificationsPlugin.zonedSchedule(0, 'Baby Food Intake Tracking', notificationMessageAfter, scheduledTime, notificationDetails, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime);
  }

  @override
  Widget build(BuildContext context) {
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                  svgSrcDate: "assets/icons/testAM.svg", svgSrcTime: "assets/icons/clock.svg", date: widget.selectedDate, dateDesc: babyFoodDateDesc, time: widget.selectedTime, timeDesc: babyFoodTimeDesc),
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
                title: babyFoodRecordListTitle,
                titleDesc: babyFoodRecordListTitleDesc,
                foodName: widget.foodMap.keys.toList(),
                foodQty: widget.foodMap.values.toList(),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: 13.0,
                  left: 13.0,
                ),
                child: Text(
                  "After Meal Behavior",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    color: Colors.black,
                  ),
                ),
              ),
              //update
              RecordBabyAfterMealSummaryWidget(
                svgSrc: "assets/icons/face-swelling.svg",
                symptomsAndAllergies: widget.symptomsAndAllergies,
                symptomsAndAllergiesDesc: widget.symptomsAndAllergiesDesc,
                completeFoodRecord: widget.completeFoodRecord,
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
                      if (widget.completeFoodRecord == true && widget.symptomsAndAllergies == false) {
                        notificationMessage = "Baby food record upload successfully.";
                        careForBabyFunction
                            .uploadBabyFoodRecordDone(
                              widget.selectedBabyID,
                              widget.selectedDate,
                              widget.selectedTime,
                              widget.foodMap,
                              widget.symptomsAndAllergies,
                              null,
                              context,
                              widget.babyAddFoodBuildContext,
                            )
                            .then((value) => showNotification(notificationMessage));
                      } else if (widget.completeFoodRecord == false && widget.symptomsAndAllergies == true) {
                        notificationMessage = "Baby food record upload successfully.";
                        careForBabyFunction
                            .uploadBabyFoodRecordDone(
                              widget.selectedBabyID,
                              widget.selectedDate,
                              widget.selectedTime,
                              widget.foodMap,
                              widget.symptomsAndAllergies,
                              widget.symptomsAndAllergiesDesc,
                              context,
                              widget.babyAddFoodBuildContext,
                            )
                            .then((value) => showNotification(notificationMessage));
                      } else if (widget.completeFoodRecord == false && widget.symptomsAndAllergies == false) {
                        notificationMessage = "Baby Food Record upload successfully. Remember to update your baby's food record after 2 hours.";
                        notificationMessageAfter = "Hey it's already 2 hours, remember to update your baby food record.";
                        careForBabyFunction
                            .uploadBabyFoodRecordPending(widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, context, widget.babyAddFoodBuildContext)
                            .then((value) {
                              showNotification(notificationMessage);
                              _showNotificationAfter2Hour(notificationMessageAfter);
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
      ),
    );
  }
}
