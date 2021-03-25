import 'package:bundle_of_joy/careForBaby/careForBabyFunction.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordListWidget.dart';
import 'package:bundle_of_joy/widgets/textWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class BabyMedTrackUpadte extends StatefulWidget {
  final String babyTempRecordID, selectedBabyID;
  BabyMedTrackUpadte({Key key, this.babyTempRecordID, this.selectedBabyID}) : super(key: key);

  @override
  _BabyMedTrackUpadteState createState() => _BabyMedTrackUpadteState();
}

class _BabyMedTrackUpadteState extends State<BabyMedTrackUpadte> {
  var bodyWidget;

  void initState(){
    super.initState();
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Pending");
    bodyWidget = FutureBuilder<DocumentSnapshot>(
      future: collectionReference.doc(widget.babyTempRecordID).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
          String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
          DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
          String formattedTime =  DateFormat('h:mm a').format(parsedTime);
          Map medicine = snapshot.data.data()["medsMap"];
          double tempBeforeMeds = double.parse(snapshot.data.data()["bTempBefore"]);
          //double tempAfterMeds = double.parse(snapshot.data.data()["bTempAfter"]);

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
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
                  svgSrc: "assets/icons/healthy-food.svg",
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
                RecordBodyTempUpdate(
                  svgSrc: "assets/icons/testAM.svg",
                  selectedDate: snapshot.data.data()["selectedDate"],
                  selectedTime: snapshot.data.data()["selectedTime"],
                  recordID: widget.babyTempRecordID,
                  babyID: widget.selectedBabyID,
                  tempBeforeMeds: tempBeforeMeds,
                  medsMap: medicine,
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
            child: bodyWidget,
          ),
        ],
      ),
    );
  }
}

class RecordBodyTempUpdate extends StatefulWidget {
  final String svgSrc, selectedDate, selectedTime, recordID, babyID;
  final double tempBeforeMeds;
  final Map medsMap;
  const RecordBodyTempUpdate({
    Key key, this.svgSrc, this.tempBeforeMeds, this.selectedDate, this.selectedTime, this.medsMap, this.recordID, this.babyID
  }) : super(key: key);

  @override
  _RecordBodyTempUpdateState createState() => _RecordBodyTempUpdateState();
}

class _RecordBodyTempUpdateState extends State<RecordBodyTempUpdate> {
  CareForBabyFunction careForBabyFunction = CareForBabyFunction();
  TextEditingController textFieldController = TextEditingController();
  String bTempUpdate;
  MyApp main = MyApp();

  void _showNotification() async {
    await notification();
  }

  Future<void> notification() async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Channel Id', 'Channel title', 'channel body', priority: Priority.high, importance: Importance.max, ticker: 'test', styleInformation: BigTextStyleInformation(''),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Baby Medicine Intake Tracking', 'Baby medicine record updated successfully.', notificationDetails);
  }

  _showDialogBox(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Opps!"),
          content: Text(
            "Looks like u didn't enter anyting into 2 hours after taking medicine section." +
            "To update your baby current medicine record, please make sure you enter you baby's " + 
            "body temperature reading 2 hours after taking medicine.",
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
                    SvgPicture.asset(widget.svgSrc, height: 23, width: 23,),
                    Container(
                      padding: EdgeInsets.only(left: 10.0,),
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
                  margin: EdgeInsets.only(top: 8.0,),
                  child: Text(
                    "This section display your baby's body temperature before and 2 hours after taking the medicine.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15.0, bottom: 15.0,),
                  child: Table(
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.only(top: 8, bottom: 8,),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 0.5, 
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                )
                              ),
                              child: Column(
                                children: [
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
                                ] 
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.only(top: 5, bottom: 8,),
                              child: Column(
                                children: [
                                  IntrinsicWidth(
                                    //margin: EdgeInsets.all(20),
                                    child: TextFormField(
                                      controller: textFieldController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Body Temperature °C",
                                        hintStyle: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.035,
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(8, 7, 8, 1),
                                      ),
                                      onChanged: (value) {
                                        bTempUpdate = value;
                                      },
                                    ),
                                  ),  
                                  Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "After 2 hours",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.033,
                                        color: Colors.black.withOpacity(0.65),
                                      ),
                                    ),
                                  ),
                                ] 
                              ),
                            ),
                          ),
                        ]
                      ), 
                    ],
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
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                if(textFieldController.text.isEmpty){
                  _showDialogBox(context);
                }else{
                  careForBabyFunction.updateBabyMedsRecordPending(
                    widget.babyID, widget.selectedDate, widget.selectedTime, widget.tempBeforeMeds.toString(), bTempUpdate, widget.medsMap, widget.recordID, context
                  ).then((value) => _showNotification());
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