import 'package:bundle_of_joy/foodIntake/foodIntakeTrackAdd.dart';
import 'package:bundle_of_joy/foodIntake/foodIntakeTrackRecordList.dart';
import 'package:bundle_of_joy/foodIntake/foodIntakeTrackView.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/recordListViewWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'foodIntake_add_1_dateTime.dart';
import 'foodIntake_recordList_done.dart';
import 'foodIntake_recordList_pending.dart';

class FoodIntakeTrackMain extends StatefulWidget {
  @override
  _FoodIntakeTrackMainState createState() => _FoodIntakeTrackMainState();
}

class _FoodIntakeTrackMainState extends State<FoodIntakeTrackMain> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReferenceComplete = _db.collection('mother').doc(user.uid).collection('foodIntake_Done');
    CollectionReference collectionReferencePending = _db.collection('mother').doc(user.uid).collection('foodIntake_Pending');

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: true,
            pinned: true,
            stretch: true,
            stretchTriggerOffset: 70.0,
            backgroundColor: appbar1,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                "Food Intake Tracking",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              background: Image.network(
                "https://static.vecteezy.com/system/resources/previews/000/171/284/original/free-hand-drawn-vector-nightscape-illustration.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  HorizontalCardWidget(
                      title: "Food Intake Record",
                      description: "View all of your food record.",
                      svgSrc: "assets/icons/verify.svg",
                      press: () {
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => FoodIntakeListDone()),
                          MaterialPageRoute(
                              builder: (context) => FoodIntakeTrackRecordList(
                                    svgSrc: "assets/icons/menu.svg",
                                    completeRecord: true,
                                    collectionReference: collectionReferenceComplete,
                                  )),
                        );
                      }),
                  HorizontalCardWidget(
                      title: "Create New Food Record",
                      description: "Create a new food record.",
                      svgSrc: "assets/icons/add.svg",
                      press: () {
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => FoodIntakeAdd1()),
                          MaterialPageRoute(builder: (context) => FoodIntakeTrackAdd()),
                          //MaterialPageRoute(builder: (context) => FoodIntakeAddTest()),
                        );
                      }),
                  HorizontalCardWidget(
                      title: "Update Pending Food Record",
                      description: "Update your existing food record.",
                      svgSrc: "assets/icons/edit.svg",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodIntakeTrackRecordList(
                                    svgSrc: "assets/icons/menu.svg",
                                    completeRecord: false,
                                    collectionReference: collectionReferencePending,
                                  )),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
