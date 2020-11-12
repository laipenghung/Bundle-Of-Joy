import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class VaccinationSchedule extends StatefulWidget {
  final String selectedBabyID;
  VaccinationSchedule({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _VaccinationSchedule createState() => _VaccinationSchedule(selectedBabyID);
}

class _VaccinationSchedule extends State<VaccinationSchedule> {
  final String selectedBabyID;
  _VaccinationSchedule(this.selectedBabyID);

  List<TableRow> _tableList(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    final _listField = ["bv_age", "bv_vaccinationName"];
    List<TableRow> _row = [];

    collection.data.docs.forEach((doc) {
      _row.add(TableRow(children: [
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
      ]));
    });
    return _row;
  }

  Widget hasData(AsyncSnapshot<QuerySnapshot> collection) {
    double paddingLeftRight = MediaQuery.of(context).size.width * 0.05;
    double paddingTopBottom = MediaQuery.of(context).size.height * 0.03;
    double paddingTopBottomSmall = MediaQuery.of(context).size.height * 0.01;
    double heightSpacing = MediaQuery.of(context).size.height * 0.075;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    if (collection.data.docs.isNotEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(paddingLeftRight, paddingTopBottom, paddingLeftRight, 0),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(6),
                },
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(children: [
                    Container(
                      color: Color(0xFFFCFFD5),
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
                      color: Color(0xFFFCFFD5),
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
            Padding(
              padding: EdgeInsets.fromLTRB(paddingLeftRight, paddingTopBottomSmall, paddingLeftRight, paddingTopBottomSmall),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(4),
                  1: FlexColumnWidth(6),
                },
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: _tableList(collection),
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
        .orderBy("bv_age", descending: false);

    return StreamBuilder(
        stream: vaccination.snapshots(),
        builder: (context, collection) {
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
            body: hasData(collection),
          );
        });
  }
}
