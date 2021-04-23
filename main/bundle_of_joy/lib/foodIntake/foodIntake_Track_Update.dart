import 'package:bundle_of_joy/foodIntake/foodIntake_Track_Add.dart';
import 'package:bundle_of_joy/foodIntake/foodIntake_Track_Function.dart';
import 'package:bundle_of_joy/main.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordFoodMedsWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class FoodIntakeTrackUpdate extends StatefulWidget {
  final String foodIntakeRecordID;
  final BuildContext pendingRecordsListScreenBuildContext;
  FoodIntakeTrackUpdate({Key key, @required this.foodIntakeRecordID, @required this.pendingRecordsListScreenBuildContext}) : super(key: key);

  @override
  _FoodIntakeTrackUpdateState createState() => _FoodIntakeTrackUpdateState();
}

class _FoodIntakeTrackUpdateState extends State<FoodIntakeTrackUpdate> {
  //var test =
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Pending");
  var bodyWidget;

  void initState() {
    super.initState();
    bodyWidget = FutureBuilder<DocumentSnapshot>(
      future: collectionReference.doc(widget.foodIntakeRecordID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
          String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
          DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
          String formattedTime = DateFormat('h:mm a').format(parsedTime);
          Map food = snapshot.data.data()["foodMap"];
          double bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
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
                RecordBloodSugarUpdate(
                  svgSrc: "assets/icons/blood-donation.svg",
                  selectedDate: snapshot.data.data()["selectedDate"],
                  selectedTime: snapshot.data.data()["selectedTime"],
                  bSugarBefore: bSugarBefore,
                  foodMap: food,
                  recordID: widget.foodIntakeRecordID,
                  pendingRecordsListScreenBuildContext: widget.pendingRecordsListScreenBuildContext,
                ),
              ],
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
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: bodyWidget,
      ),
    );
  }
}

class RecordBloodSugarUpdate extends StatefulWidget {
  final String svgSrc;
  final String selectedDate;
  final String selectedTime;
  final double bSugarBefore;
  final Map foodMap;
  final String recordID;
  final BuildContext pendingRecordsListScreenBuildContext;
  const RecordBloodSugarUpdate({
    Key key,
    this.svgSrc,
    this.bSugarBefore,
    this.selectedDate,
    this.selectedTime,
    this.foodMap,
    this.recordID,
    this.pendingRecordsListScreenBuildContext
  }) : super(key: key);

  @override
  _RecordBloodSugarUpdateState createState() => _RecordBloodSugarUpdateState();
}

class _RecordBloodSugarUpdateState extends State<RecordBloodSugarUpdate> {
  FoodIntakeTrackFunction foodIntakeTrackFunction = FoodIntakeTrackFunction();
  TextEditingController bSugarUpdateController = TextEditingController();
  String bSugarUpdate, dialogBoxContent;
  MyApp main = MyApp();

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
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
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Food Intake Tracking', 'Food record updated successfully.', notificationDetails);
  }

  _showDialogBox(BuildContext context, dialogBoxContent) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opps!"),
            content: Text(dialogBoxContent),
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

  Widget bloodGlucoseModalBottomSheetWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
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
                      "Blood Glucose",
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
            width: double.infinity,
            margin: EdgeInsets.all(13),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Blood Glucose Reading",
                      desc: "Blood glucose reading 2 hour after meal.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: bSugarUpdateController,
                        onChanged: (val) => setState(() => bSugarUpdate = val),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Blood glucose reading 2 hour after meal.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Column(children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      textColor: Colors.black.withOpacity(0.65),
                      onPressed: () {
                        bSugarUpdateController.clear();
                      },
                      child: Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                        if (bSugarUpdateController.text.isNotEmpty) {
                          setState(() {
                            //bSugarUpdateController.clear();
                            Navigator.of(context).pop();
                          });
                        } else {
                          dialogBoxContent = "Please make sure you entered your blood glucose reading into the " + "before meal section. Only 2 hour after meal section can be left empty.";
                          _showDialogBox(context, dialogBoxContent);
                        }
                      },
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
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
                        left: 10.0,
                      ),
                      child: Text(
                        "Blood Sugar Reading",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    "Your blood sugar reading before meal and 2 hours after meal.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Table(
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                width: 0.5,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            )),
                            child: Column(children: [
                              Text(
                                widget.bSugarBefore.toString() + " mmol/L",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Before meal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.033,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Column(children: [
                              Text(
                                (bSugarUpdate == null || bSugarUpdate == "") ? "-" : bSugarUpdate + " mmol/L",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "2 hours after meal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.033,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
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
                        if (bSugarUpdate != null) {
                          bSugarUpdateController.text = bSugarUpdate;
                        }
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                            ),
                            isScrollControlled: true,
                            builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.4,
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: bloodGlucoseModalBottomSheetWidget(context),
                                  ),
                                ));
                      },
                      child: Text(
                        "Update Blood Sugar Reading",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
                BloodSugarUpdateText(),
              ],
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
              color: appbar1,
              textColor: Colors.white,
              onPressed: () {
                if (bSugarUpdateController.text.isEmpty) {
                  dialogBoxContent = "Looks like u didn't enter anyting into 2 hours after meal section." + "To update your current food record, please make sure you enter Blood Sugar reading 2 hours after meal.";
                  _showDialogBox(context, dialogBoxContent);
                } else {
                  foodIntakeTrackFunction
                      .updateFoodRecordPending(
                        widget.selectedDate,
                        widget.selectedTime,
                        widget.bSugarBefore.toString(),
                        bSugarUpdate,
                        widget.foodMap,
                        context,
                        widget.recordID,
                        widget.pendingRecordsListScreenBuildContext,
                      )
                      .then((value) => _showNotification());
                }
              },
              child: Text(
                "Update Record",
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
