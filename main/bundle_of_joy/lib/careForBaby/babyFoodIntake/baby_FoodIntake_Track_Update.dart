import 'package:bundle_of_joy/careForBaby/careForBaby_Function.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../main.dart';

class BabyFoodIntakeTrackUpdate extends StatefulWidget {
  final String recordID, selectedBabyID;
  final BuildContext babyFoodRecordListContext;
  BabyFoodIntakeTrackUpdate({Key key, this.recordID, this.selectedBabyID, @required this.babyFoodRecordListContext}) : super(key: key);

  @override
  _BabyFoodIntakeTrackUpdateState createState() => _BabyFoodIntakeTrackUpdateState();
}

class _BabyFoodIntakeTrackUpdateState extends State<BabyFoodIntakeTrackUpdate> {
  var bodyContent;
  void initState() {
    super.initState();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Pending");
    bodyContent = FutureBuilder<DocumentSnapshot>(
      future: collectionReference.doc(widget.recordID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
          String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
          DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
          String formattedTime = DateFormat('h:mm a').format(parsedTime);
          Map food = snapshot.data.data()["foodMap"];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GestureDetector(
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
                  RecordDateTimeWidget(svgSrcDate: "assets/icons/testAM.svg", svgSrcTime: "assets/icons/clock.svg", date: formattedDate, dateDesc: babyFoodDateDesc, time: formattedTime, timeDesc: babyFoodTimeDesc),
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
                      "After Meal Behavior",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //Update symptoms and allergies
                  RecordSymptomsAndAllergiesUpdate(
                    svgSrc: "assets/icons/face-swelling.svg",
                    selectedBabyID: widget.selectedBabyID,
                    recordID: widget.recordID,
                    selectedDate: snapshot.data.data()["selectedDate"],
                    selectedTime: snapshot.data.data()["selectedTime"],
                    foodMap: food,
                    babyFoodRecordListContext: widget.babyFoodRecordListContext,
                  ),
                  //Update data to database
                ],
              ),
            );
          }
        } else if (snapshot.hasError) {
          print("error");
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Update Food Record",
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
        child: bodyContent,
      ),
    );
  }
}

class RecordSymptomsAndAllergiesUpdate extends StatefulWidget {
  final String svgSrc, selectedBabyID, recordID, selectedDate, selectedTime;
  final Map foodMap;
  final BuildContext babyFoodRecordListContext;
  RecordSymptomsAndAllergiesUpdate({Key key, this.svgSrc, this.selectedBabyID, this.recordID, this.selectedDate, this.selectedTime, this.foodMap, this.babyFoodRecordListContext}) : super(key: key);

  @override
  _RecordSymptomsAndAllergiesUpdateState createState() => _RecordSymptomsAndAllergiesUpdateState();
}

class _RecordSymptomsAndAllergiesUpdateState extends State<RecordSymptomsAndAllergiesUpdate> {
  CareForBabyFunction careForBabyFunction = CareForBabyFunction();
  MyApp main = MyApp();
  String notificationMessage;
  bool symptomsAndAllergies = false;
  String symptomsAndAllergiesDesc;
  TextEditingController textFieldController = TextEditingController();

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

  _showDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opps!"),
            content: Text(
              "Looks like u didn't enter anyting into the symptomps or allergies section" + "To update your baby current food record, please make sure you enter the symptomps or " + "allergies shown by your baby.",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      widget.svgSrc,
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Symptoms and Allergies",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Container(
                      height: 20,
                      width: 60,
                      child: Switch(
                        value: symptomsAndAllergies,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            symptomsAndAllergies = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                (symptomsAndAllergies == false)
                    ? UpdateSymptomsAndAllergiesFalse()
                    : Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "You can enter all the symptoms or allergies that shown on your baby in the textarea provided below.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: TextFormField(
                              maxLines: 7,
                              controller: textFieldController,
                              onChanged: (val) {
                                setState(() => symptomsAndAllergiesDesc = val);
                              },
                              //textInputAction: TextInputAction.send,
                              decoration: new InputDecoration(
                                hintText: "Enter the description of the symptoms or allergies that found on your baby.",
                                hintStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.035,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.65),
                                    //width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    //width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          BabyFoodRecrodDoneText(),
                        ],
                      ),
              ],
            ),
          ),
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
                if (textFieldController.text.isNotEmpty && symptomsAndAllergies == true) {
                  notificationMessage = "Baby food record successfully updated.";
                  careForBabyFunction
                      .updateBabyFoodRecordPending(widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, 
                        symptomsAndAllergies, symptomsAndAllergiesDesc, widget.recordID, context, widget.babyFoodRecordListContext)
                      .then((value) => _showNotification(notificationMessage));
                } else if (symptomsAndAllergies == false) {
                  notificationMessage = "Baby food record successfully updated.";
                  careForBabyFunction
                      .updateBabyFoodRecordPending(widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, 
                        symptomsAndAllergies, null, widget.recordID, context, widget.babyFoodRecordListContext)
                      .then((value) => _showNotification(notificationMessage));
                } else if (textFieldController.text.isEmpty && symptomsAndAllergies == true) {
                  _showDialogBox(context);
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
    );
  }
}

class UpdateSymptomsAndAllergiesFalse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "If your baby does not show any sign of symptoms and allergies you can straight tap on the update record button to " +
                "update this record. Else, you can toggle the switch one the top right corner and enter all the details.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 15),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Color(0xFFf5f5f5),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.red.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 8),
                child: SvgPicture.asset(
                  "assets/icons/warning.svg",
                  height: 25,
                  width: 25,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Your current selection is your baby does not show any sign of symptoms and allergies.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
        BabyFoodRecrodDoneText()
      ],
    );
  }
}
