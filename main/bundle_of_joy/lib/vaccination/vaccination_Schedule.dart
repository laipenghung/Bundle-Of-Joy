import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/loadingWidget.dart';
import 'package:bundle_of_joy/widgets/vaccinationWidget.dart';
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

  Widget hasData(AsyncSnapshot<QuerySnapshot> collection, AsyncSnapshot<dynamic> baby) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    List ageListString = [];
    List vaccineNameList = [];

    if (collection.hasData && baby.hasData) {
      if (collection.data.docs.isNotEmpty) {
        String age = baby.data["b_age"];

        collection.data.docs.forEach((doc) {
          ageListString.add(doc.data()["bv_age"].toString());
          vaccineNameList.add(doc.data()["bv_vaccinationName"].toString());
        });

        return SingleChildScrollView(
          child: Column(
            children: [
              VaccinationWidget(
                tableTitle: "Vaccination Schedule Table",
                tableDesc: "This section display the vaccination schedule record of your baby." +
                "\nIf the table row is highlighted in green, you are recommended to make an appointment with a pediatrician for injection during that time.",
                svgSrcTable: "assets/icons/table.svg",
                ageListString: ageListString,
                vaccineNameList: vaccineNameList,
                tableMeasurement: "Vaccine Name",
                vaccineTrack: true,
                age: age,
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
    } else {
      return LoadingWidget();
    }
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query vaccination =
        FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID).collection("baby_vaccination").where("bv_dateGiven", isNull: true).orderBy("bv_id", descending: false);

    DocumentReference baby = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").doc(selectedBabyID);

    return StreamBuilder(
        stream: vaccination.snapshots(),
        builder: (context, collection) {
          return StreamBuilder(
              stream: baby.snapshots(),
              builder: (context, baby) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Vaccination Schedule",
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
                  body: hasData(collection, baby),
                );
              });
        });
  }
}
