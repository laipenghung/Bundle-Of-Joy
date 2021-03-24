import 'dart:developer';

import 'package:bundle_of_joy/careForBaby/careForBabyFunction.dart';
import 'package:bundle_of_joy/widgets/recordBabyAfterMealUpdateWidget.dart';
import 'package:bundle_of_joy/widgets/recordBabyAfterMealWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordListWidget.dart';
import 'package:bundle_of_joy/widgets/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';

class BabyFoodIntakeAddSummary extends StatefulWidget {
  final String selectedBabyID, selectedDate, selectedTime;
  final Map foodMap;
  BabyFoodIntakeAddSummary({Key key, this.selectedBabyID, this.selectedDate, this.selectedTime, this.foodMap}) : super(key: key);
  
  @override
  _BabyFoodIntakeAddSummaryState createState() => _BabyFoodIntakeAddSummaryState();
}

class _BabyFoodIntakeAddSummaryState extends State<BabyFoodIntakeAddSummary> {
  CareForBabyFunction careForBabyFunction = CareForBabyFunction();
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

  _showDialogBox(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Opps!"),
          content: Text(
            "Looks like u didn't enter anyting into the symptomps or allergies section" +
            "To upload your baby current food record, please make sure you enter the symptomps or " + 
            "allergies shown by your baby.",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();  
              },
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            //expandedHeight: MediaQuery.of(context).size.height * 0.15,
            floating: true,
            pinned: true,
            stretch: true,
            //stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Container(
                child: Text(
                  "Food Intake Record",
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
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
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
                    date: widget.selectedDate,
                    dateDesc: babyFoodDateDesc,
                    time: widget.selectedTime,
                    timeDesc: babyFoodTimeDesc
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 13.0, left: 13.0,),
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
                  RecordListWidget(
                    svgSrc: "assets/icons/healthy-food.svg",
                    title: babyFoodRecordListTitle,
                    titleDesc: babyFoodRecordListTitleDesc,
                    foodName: widget.foodMap.keys.toList(),
                    foodQty: widget.foodMap.values.toList(),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 13.0, left: 13.0,),
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
                  RecordBabyAfterMealUpdateWidget(
                    svgSrc: "assets/icons/testAM.svg",
                    //symptomsAndAllergies: false,
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
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          if(completeFoodRecord == true && symptomsAndAllergies == false){
                            notificationMessage = "Baby food record upload successfully.";
                            careForBabyFunction.uploadBabyFoodRecordDone(
                              widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, symptomsAndAllergies, null, context,
                            ).then((value) => _showNotification(notificationMessage));
                          }else if(textFieldController.text.isNotEmpty && completeFoodRecord == false && symptomsAndAllergies == true){
                            notificationMessage = "Baby food record upload successfully.";
                            careForBabyFunction.uploadBabyFoodRecordDone(
                              widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, symptomsAndAllergies, symptomsAndAllergiesDesc, context,
                            ).then((value) => _showNotification(notificationMessage));
                          }else if(textFieldController.text.isEmpty && symptomsAndAllergies == true){
                            _showDialogBox(context);
                          }else{
                            notificationMessage = "Remember to update your baby's food record after 2 hours.";
                            careForBabyFunction.uploadBabyFoodRecordPending(
                              widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, context
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
          ),
        ],
      ),
    );
  }
}