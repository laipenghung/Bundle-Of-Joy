import 'package:bundle_of_joy/careForBaby/babyFoodIntake/baby_FoodIntake_Track_Add.dart';
import 'package:bundle_of_joy/careForBaby/babyFoodIntake/baby_FoodIntake_Track_RecordList.dart';
import 'package:bundle_of_joy/careForBaby/babyTemp/baby_Med_Track_Add.dart';
import 'package:bundle_of_joy/careForBaby/babyTemp/baby_Med_Track_RecordList.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';

class CareForBabyMain extends StatefulWidget {
  final String selectedBabyID;
  CareForBabyMain({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _CareForBabyMainState createState() => _CareForBabyMainState();
}

class _CareForBabyMainState extends State<CareForBabyMain> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference colRefBabyMedsComplete = _db.collection('mother').doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Done");
    CollectionReference colRefBabyMedsPending = _db.collection('mother').doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Pending");

    CollectionReference colRefBabyFoodComplete = _db.collection('mother').doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Done");
    CollectionReference colRefBabyFoodPending = _db.collection('mother').doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Pending");

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Care for Baby",
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              //Baby Food Tracking
              Container(
                width: MediaQuery.of(context).size.width * 1,
                //padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                child: Text(
                  "Baby Food Tracking",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              HorizontalCardWidget(
                  title: "Baby Food Intake Record",
                  description: "View all of your baby's food record.",
                  svgSrc: "assets/icons/verify.svg",
                  press: () {
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => BabyFoodIntakeListDone(selectedBabyID: widget.selectedBabyID)),
                      MaterialPageRoute(
                          builder: (context) => BabyFoodIntakeTrackRecordList(
                                selectedBabyID: widget.selectedBabyID,
                                collectionReference: colRefBabyFoodComplete,
                                completeBabyFoodRecord: true,
                                completeRecord: true,
                                svgSrc: "assets/icons/recipe.svg",
                              )),
                    );
                  }),

              HorizontalCardWidget(
                  title: "Create New Baby Food Record",
                  description: "Create a new food record for your baby.",
                  svgSrc: "assets/icons/add.svg",
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BabyFoodIntakeTrackAdd(selectedBabyID: widget.selectedBabyID)));
                  }),
              HorizontalCardWidget(
                  title: "Update Pending Baby Food Record",
                  description: "Update your baby's existing food record.",
                  svgSrc: "assets/icons/edit.svg",
                  press: () {
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => BabyFoodIntakeListPending(selectedBabyID: widget.selectedBabyID)),
                      MaterialPageRoute(
                        builder: (context) => BabyFoodIntakeTrackRecordList(
                          selectedBabyID: widget.selectedBabyID,
                          collectionReference: colRefBabyFoodPending,
                          completeBabyFoodRecord: false,
                          completeRecord: false,
                          svgSrc: "assets/icons/recipe.svg",
                        ),
                      ),
                    );
                  }),

              //Baby Medicine Tracking
              Container(
                width: MediaQuery.of(context).size.width * 1,
                //padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                child: Text(
                  "Baby Medicine Tracking",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              HorizontalCardWidget(
                  title: "Medicine Intake Record",
                  description: "View all of your baby's medicine record.",
                  svgSrc: "assets/icons/verify.svg",
                  press: () {
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) =>BabyTempListDone(selectedBabyID: widget.selectedBabyID)),
                      MaterialPageRoute(
                        builder: (context) => BabyMedTrackRecordList(
                          selectedBabyID: widget.selectedBabyID,
                          svgSrc: "assets/icons/medsRecord.svg",
                          completeRecord: true,
                          collectionReference: colRefBabyMedsComplete,
                        ),
                      ),
                    );
                  }),
              HorizontalCardWidget(
                title: "Create New Medicine Record",
                description: "Create a new medicine record for your baby.",
                svgSrc: "assets/icons/add.svg",
                press: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => BabyTempAdd1(selectedBabyID: widget.selectedBabyID)),
                    MaterialPageRoute(builder: (context) => BabyMedTrackAdd(selectedBabyID: widget.selectedBabyID)),
                  );
                },
              ),
              HorizontalCardWidget(
                title: "Update Pending Medicine Record",
                description: "Update your baby's existing medicine record.",
                svgSrc: "assets/icons/edit.svg",
                press: () {
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => BabyTempListPending(selectedBabyID: widget.selectedBabyID)),
                    MaterialPageRoute(
                      builder: (context) => BabyMedTrackRecordList(
                        selectedBabyID: widget.selectedBabyID,
                        svgSrc: "assets/icons/medsRecord.svg",
                        completeRecord: false,
                        collectionReference: colRefBabyMedsPending,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
