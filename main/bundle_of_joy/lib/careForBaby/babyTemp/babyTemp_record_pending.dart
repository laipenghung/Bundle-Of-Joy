import 'package:bundle_of_joy/careForBaby/careForBabyTab.dart';
import 'package:bundle_of_joy/mother-for-baby.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../main.dart';

class BabyTempRecordPending extends StatefulWidget {
  final String babyTempRecordID, selectedBabyID;
  BabyTempRecordPending({Key key, this.babyTempRecordID, this.selectedBabyID}) : super(key: key);

  @override
  _BabyTempRecordPendingState createState() => _BabyTempRecordPendingState();
}

class _BabyTempRecordPendingState extends State<BabyTempRecordPending> {
  MyApp main = MyApp();
  String bTempUpdate = "";
  TextEditingController controllerBT = TextEditingController();
  var content;

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
    await main
        .createState()
        .flutterLocalNotificationsPlugin
        .show(0, 'Medicine Intake Tracking', 'Baby\'s body temperature updated.\nYou can now view it in Medicine Intake Record of the baby.', notificationDetails);
  }

  void initState() {
    super.initState();
    content = FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("mother")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("baby")
          .doc(widget.selectedBabyID)
          .collection("tempRecord_Pending")
          .doc(widget.babyTempRecordID)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          Map meds = snapshot.data.data()["medsMap"];
          List<dynamic> medsName = List<dynamic>();
          medsName = meds.values.toList();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
                  //color: Colors.lightBlue,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/icons/calendar.png",
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                            Container(
                              //color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                              child: Text(
                                snapshot.data.data()["selectedDate"],
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/icons/time.png",
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                            Container(
                              //color: Colors.red,
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                              child: Text(
                                snapshot.data.data()["selectedTime"],
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom: MediaQuery.of(context).size.height * 0.01,
                                left: MediaQuery.of(context).size.width * 0.02,
                              ),
                              child: Image.asset(
                                "assets/icons/medicine.png",
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09),
                                  child: Table(
                                    //border: TableBorder.all(width: 1.0, color: Colors.black),
                                    children: [
                                      for (var x in medsName)
                                        TableRow(children: [
                                          TableCell(
                                              child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
                                                //color: Colors.blue,
                                                child: new Text(
                                                  "- ",
                                                  style: TextStyle(
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context).size.height * 0.023,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
                                                //color: Colors.blue,
                                                width: MediaQuery.of(context).size.width * 0.35,
                                                child: new Text(
                                                  x.toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: MediaQuery.of(context).size.height * 0.023,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ))
                                        ])
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset(
                                "assets/icons/temp.png",
                                height: MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Text(
                                          "Before: ",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.data()["bTempBefore"] + " °C",
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, top: MediaQuery.of(context).size.height * 0.02),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "After: ",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        height: MediaQuery.of(context).size.height * 0.04,
                                        child: TextFormField(
                                          controller: controllerBT,
                                          onChanged: (val) {
                                            setState(() => bTempUpdate = val);
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: new InputDecoration(
                                            //labelText: "Blood sugar reading",
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          onSaved: (String value) {},
                                          validator: (String value) {
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: myBoxDecoration(),
                          child: Center(
                            child: Text(
                              "Back",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: myBoxDecoration(),
                          child: Center(
                            child: Text(
                              "Done",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (controllerBT.text.isEmpty) {
                            return showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Opps!"),
                                    content: Text("Body temperature after taking the medicine not entered."),
                                    actions: <Widget>[
                                      RaisedButton(
                                        child: Text("Ok"),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            updateBabyTemoRecord(snapshot.data.data()["motherID"], snapshot.data.data()["selectedDate"], snapshot.data.data()["selectedTime"],
                                snapshot.data.data()["bTempBefore"], bTempUpdate, widget.babyTempRecordID, widget.selectedBabyID, snapshot.data.data()["medsMap"]);
                            _showNotification();
                          }
                        }, //ADD TO DATABASE
                      ),
                    ],
                  ),
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

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0) //<--- border radius here
          ),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0) //<--- border radius here
          ),
    );
  }

  Future<void> updateBabyTemoRecord(motherID, selectedDate, selectedTime, bTempBefore, bTempAfter, recordID, babyID, meds) {
    //final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference babyTempRecord = _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Done");
    return babyTempRecord.add({
      "motherID": motherID,
      "selectedDate": selectedDate,
      "selectedTime": selectedTime,
      "bTempBefore": bTempBefore,
      "bTempAfter": bTempAfter,
      "babyID": babyID,
      "medsMap": meds,
    }).then((value) {
      babyTempRecord.doc(value.id).update({
        "recordID": value.id,
      });
      print("Data uploaded");
      _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Pending").doc(recordID).delete();
      print("Data Deleted");
    }).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MotherForBabyTab()));
    }).catchError((error) => print("wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Medicine Intake Tracking",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: content,
    );
  }
}
