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

class BabyMedTrackUpadte extends StatefulWidget {
  final String babyTempRecordID, selectedBabyID;
  final BuildContext babyMedRecordListContext;
  BabyMedTrackUpadte({Key key, this.babyTempRecordID, this.selectedBabyID, @required this.babyMedRecordListContext}) : super(key: key);

  @override
  _BabyMedTrackUpadteState createState() => _BabyMedTrackUpadteState();
}

class _BabyMedTrackUpadteState extends State<BabyMedTrackUpadte> {
  var bodyWidget;
  String reminderTime;

  void initState() {
    super.initState();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Pending");
    bodyWidget = FutureBuilder<DocumentSnapshot>(
      future: collectionReference.doc(widget.babyTempRecordID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
          String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
          DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
          String formattedTime = DateFormat('h:mm a').format(parsedTime);
          Map medicine = snapshot.data.data()["medsMap"];
          double tempBeforeMeds = double.parse(snapshot.data.data()["bTempBefore"]);
          //double tempAfterMeds = double.parse(snapshot.data.data()["bTempAfter"]);
          if(snapshot.data.data()["reminderTime"] != null){
            reminderTime = snapshot.data.data()["reminderTime"].toString();
          }else{
            reminderTime = "4";
          }

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
                    "Consumed Medicine",
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
                RecordBodyTempUpdate(
                  svgSrc: "assets/icons/thermometer.svg",
                  selectedDate: snapshot.data.data()["selectedDate"],
                  selectedTime: snapshot.data.data()["selectedTime"],
                  recordID: widget.babyTempRecordID,
                  babyID: widget.selectedBabyID,
                  tempBeforeMeds: tempBeforeMeds,
                  medsMap: medicine,
                  babyMedRecordListContext: widget.babyMedRecordListContext,
                  reminderTime: reminderTime,
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
          "Update Medicine Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: bodyWidget,
      ),
    );
  }
}

class RecordBodyTempUpdate extends StatefulWidget {
  final String svgSrc, selectedDate, selectedTime, recordID, babyID, reminderTime;
  final double tempBeforeMeds;
  final Map medsMap;
  final BuildContext babyMedRecordListContext;
  const RecordBodyTempUpdate({Key key, this.reminderTime, this.svgSrc, this.tempBeforeMeds, this.selectedDate, this.selectedTime, this.medsMap, this.recordID, this.babyID, this.babyMedRecordListContext}) : super(key: key);

  @override
  _RecordBodyTempUpdateState createState() => _RecordBodyTempUpdateState();
}

class _RecordBodyTempUpdateState extends State<RecordBodyTempUpdate> {
  CareForBabyFunction careForBabyFunction = CareForBabyFunction();
  TextEditingController bTempUpdateController = TextEditingController();
  String bTempUpdate, dialogBoxContent;
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
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Baby Medicine Intake Tracking', 'Baby medicine record updated successfully.', notificationDetails);
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

  Widget babyTempModalBottomSheetWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              color: appbar2,
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
                      "Body Temperature",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
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
                      title: "Body Temperature Reading",
                      desc: "Body temperature reading " + widget.reminderTime + " hour after medication.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: bTempUpdateController,
                        onChanged: (val) => setState(() => bTempUpdate = val),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Body Temperature Reading",
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
                        bTempUpdateController.clear();
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
                      color: appbar2,
                      textColor: Colors.white,
                      onPressed: () {
                        if (bTempUpdateController.text.isNotEmpty) {
                          setState(() {
                            //bSugarUpdateController.clear();
                            Navigator.of(context).pop();
                          });
                        } else {
                          dialogBoxContent = "Please make sure you entered your baby's body temperature reading into the " + widget.reminderTime +" hours after medication section.";
                          _showDialogBox(context, dialogBoxContent);
                        }
                      },
                      child: Text(
                        "Update",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
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
                        "Body Temperature Reading",
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
                    "This section display your baby's body temperature before and " + widget.reminderTime + " hours after taking the medicine.",
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
                                widget.tempBeforeMeds.toString() + " °C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Before taking meds",
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
                                (bTempUpdate == null || bTempUpdate == "") ? "-" : bTempUpdate + "°C",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "After " + widget.reminderTime + " hours",
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
                      color: appbar2,
                      textColor: Colors.white,
                      onPressed: () {
                        if (bTempUpdate != null) {
                          bTempUpdateController.text = bTempUpdate;
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
                                    child: babyTempModalBottomSheetWidget(context),
                                  ),
                                ));
                      },
                      child: Text(
                        "Update Baby Body Temperature Reading",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
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
                if (bTempUpdateController.text.isEmpty) {
                  dialogBoxContent = "Looks like u didn't enter anyting into 2 hours after taking medicine section." +
                      "To update your baby current medicine record, please make sure you enter you baby's " +
                      "body temperature reading 2 hours after taking medicine.";
                  _showDialogBox(context, dialogBoxContent);
                } else {
                  careForBabyFunction
                      .updateBabyMedsRecordPending(
                          widget.babyID, widget.selectedDate, widget.selectedTime, widget.tempBeforeMeds.toString(), bTempUpdate, 
                            widget.medsMap, widget.recordID, context, widget.babyMedRecordListContext,int.parse(widget.reminderTime))
                      .then((value) => _showNotification());
                }
              },
              child: Text(
                "Update Record",
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
    );
  }
}
