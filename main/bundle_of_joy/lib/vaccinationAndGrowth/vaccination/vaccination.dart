import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class Vaccination extends StatefulWidget {
  final String selectedBabyID;
  Vaccination({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _Vaccination createState() => _Vaccination(selectedBabyID);
}

class _Vaccination extends State<Vaccination> {
  final String selectedBabyID;
  _Vaccination(this.selectedBabyID);

  List<TableRow> _tableList(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    final _listField = ["bv_vaccinationName", "bv_dateGiven"];
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
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
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
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(4),
                },
                border: TableBorder.all(width: 1.0, color: Colors.black),
                children: [
                  TableRow(children: [
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
                    Container(
                      color: Color(0xFFFCFFD5),
                      height: heightSpacing,
                      child: Center(
                        child: Text(
                          "Date Taken",
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
                  0: FlexColumnWidth(6),
                  1: FlexColumnWidth(4),
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
        .where("bv_dateGiven", isGreaterThan: "")
        .orderBy("bv_dateGiven", descending: false);

    return StreamBuilder(
        stream: vaccination.snapshots(),
        builder: (context, collection) {
          return hasData(collection);
        });
  }
}
