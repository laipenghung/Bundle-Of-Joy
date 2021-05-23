import 'package:bundle_of_joy/foodIntake/foodIntake_Track_Add.dart';
import 'package:bundle_of_joy/foodIntake/foodIntake_Track_RecordList.dart';
import 'package:bundle_of_joy/foodIntake/foodIntake_Track_View.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/record_ListView_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';

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
      appBar: AppBar(
        title: Text(
          "Food Intake Tracking",
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              HorizontalCardWidget(
                title: "Food Intake Record",
                description: "View all of your food record.",
                svgSrc: "assets/icons/verify.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodIntakeTrackRecordList(
                        svgSrc: "assets/icons/recipe.svg",
                        completeRecord: true,
                        collectionReference: collectionReferenceComplete,
                      ),
                    ),
                  );
                },
              ),
              HorizontalCardWidget(
                title: "Create New Food Record",
                description: "Create a new food record.",
                svgSrc: "assets/icons/add.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FoodIntakeTrackAdd()),
                  );
                },
              ),
              HorizontalCardWidget(
                title: "Update Pending Food Record",
                description: "Update your existing food record.",
                svgSrc: "assets/icons/edit.svg",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodIntakeTrackRecordList(
                        svgSrc: "assets/icons/recipe.svg",
                        completeRecord: false,
                        collectionReference: collectionReferencePending,
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
