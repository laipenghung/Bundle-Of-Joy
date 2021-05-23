import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/loadingWidget.dart';
import 'package:bundle_of_joy/widgets/vaccination_Widget.dart';
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

  Widget hasData(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    List ageListString = [];
    List vaccineNameList = [];
    List dateTakenList = [];

    if (collection.data.docs.isNotEmpty) {
      collection.data.docs.forEach((doc) {
        ageListString.add(doc.data()["bv_age"].toString());
        vaccineNameList.add(doc.data()["bv_vaccinationName"].toString());
        dateTakenList.add(doc.data()["bv_dateGiven"].toString());
      });

      return SingleChildScrollView(
        child: Column(
          children: [
            VaccinationWidget(
              tableTitle: "Vaccination Record Table",
              tableDesc: "This section display the history of taken vaccination of your baby.",
              svgSrcTable: "assets/icons/table.svg",
              ageListString: ageListString,
              vaccineNameList: vaccineNameList,
              tableMeasurement: "Vaccine Name",
              dateTakenList: dateTakenList,
              vaccineTrack: false,
            ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Baby Vaccination Records",
          style: TextStyle(
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: vaccination.snapshots(),
          builder: (context, collection) {
            if (collection.hasData) {
              return hasData(collection);
            } else {
              return LoadingWidget();
            }
          }),
    );
  }
}
