import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class VaccinationSchedule extends StatefulWidget {
  final String selectedBabyID;
  VaccinationSchedule({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _VaccinationSchedule createState() => _VaccinationSchedule(selectedBabyID);
}

class _VaccinationSchedule extends State<VaccinationSchedule> {
  final String selectedBabyID;
  _VaccinationSchedule(this.selectedBabyID);
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var initializationSettings = new InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future _showNotification(String age) async {
    var androidDetails = new AndroidNotificationDetails("vaccine", "Vaccination Schedule", "Baby Vaccination Schedule", importance: Importance.max);
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(1, "Upcoming Vaccination", "You have upcoming baby vaccination at "+age, generalNotificationDetails);
  }

  List<TableRow> _tableList(AsyncSnapshot<QuerySnapshot> collection, String age) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    Color rowColor = Colors.white;
    final _listField = ["bv_age", "bv_vaccinationName"];
    List<TableRow> _row = [];

    collection.data.docs.forEach((doc) {
      RegExp exp = new RegExp(r"\d+ \w+");
      print(exp.stringMatch(age).toString());

      if(doc.data()[_listField[0]].toString() == exp.stringMatch(age).toString()) {
        _showNotification(age);
        rowColor = Colors.greenAccent;
      } else {
        rowColor = Colors.white;
      }

      _row.add(
        TableRow(
          decoration: BoxDecoration(
            color: rowColor,
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
              child: Container(
                child: Center(
                  child: Text(
                    doc.data()[_listField[0]].toString(),
                    style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeText,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
              ),
              child: Container(
                child: Center(
                  child: Text(
                    doc.data()[_listField[1]].toString(),
                    style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: fontSizeText,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]
      ));
    });
    return _row;
  }

  Widget hasData(AsyncSnapshot<QuerySnapshot> collection, AsyncSnapshot<dynamic> baby) {
    double paddingLeftRight = MediaQuery.of(context).size.width * 0.05;
    double paddingTopBottom = MediaQuery.of(context).size.height * 0.03;
    double paddingTopBottomSmall = MediaQuery.of(context).size.height * 0.01;
    double heightSpacing = MediaQuery.of(context).size.height * 0.075;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    if(collection.hasData){
      if (collection.data.docs.isNotEmpty) {
        String age = baby.data["b_age"];

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(paddingLeftRight, paddingTopBottom, paddingLeftRight, 0),
                child: Container(
                  color: Color(0xFFFCFFD5),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(6),
                    },
                    border: TableBorder.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    children: [
                      TableRow(children: [
                        Container(
                          height: heightSpacing,
                          child: Center(
                            child: Text(
                              "Age",
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: heightSpacing,
                          child: Center(
                            child: Text(
                              "Vaccine Name",
                              style: TextStyle(
                                fontFamily: "Comfortaa",
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(paddingLeftRight, paddingTopBottomSmall, paddingLeftRight, paddingTopBottomSmall),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(4),
                    1: FlexColumnWidth(6),
                  },
                  border: TableBorder.all(
                    width: 1,
                    color: Colors.black,
                  ),
                  children: _tableList(collection, age),
                ),
              )
            ],
          ),
        );
      } else {
        return Center(
          child: Text(
            "There is currently no records",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
              color: Colors.black,
            ),
          ),
        );
      }
    } else {
      return loading();
    }
  }

  Widget loading(){
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.15,
            width: MediaQuery.of(context).size.width * 0.15,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: Colors.black,
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            "Loading...",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query vaccination = FirebaseFirestore.instance
        .collection("mother")
        .doc(user.uid)
        .collection("baby")
        .doc(selectedBabyID)
        .collection("baby_vaccination")
        .where("bv_dateGiven", isNull: true)
        .orderBy("bv_id", descending: false);

    DocumentReference baby = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID);

    return StreamBuilder(
        stream: vaccination.snapshots(),
        builder: (context, collection) {
          return StreamBuilder(
            stream: baby.snapshots(),
            builder: (context, baby) {
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                  title: Text(
                    "Vaccination Schedule",
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),

                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),

                  //automaticallyImplyLeading: false, // CENTER THE TEXT
                  backgroundColor: Color(0xFFFCFFD5),
                  centerTitle: true,
                ),
                body: hasData(collection, baby),
              );
            }
          );
        });
  }
}
