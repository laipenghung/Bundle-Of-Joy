import 'package:bundle_of_joy/careForBaby/babyFoodIntake/baby_FoodIntake_Track_SneakPeak.dart';
import 'package:bundle_of_joy/careForBaby/babyFoodIntake/baby_FoodIntake_Track_Update.dart';
import 'package:bundle_of_joy/careForBaby/babyFoodIntake/baby_FoodIntake_Track_View.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/record_ListView_Widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BabyFoodIntakeTrackRecordList extends StatefulWidget {
  final bool completeRecord, completeBabyFoodRecord;
  final CollectionReference collectionReference;
  final String svgSrc, selectedBabyID;
  BabyFoodIntakeTrackRecordList({Key key, @required this.completeRecord, @required this.collectionReference, @required this.svgSrc, @required this.selectedBabyID, this.completeBabyFoodRecord}) : super(key: key);
  @override
  _BabyFoodIntakeTrackRecordListState createState() => _BabyFoodIntakeTrackRecordListState();
}

class _BabyFoodIntakeTrackRecordListState extends State<BabyFoodIntakeTrackRecordList> {
  bool descendingDate = true, descendingTime = true;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;
  String databaseTable;

  static String sortAscByDate = "Sort By Date Ascendingly";
  static String sortDescByDate = "Sort By Date Descendingly";
  static List<String> choices = <String>[sortAscByDate, sortDescByDate];

  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReferenceComplete = _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Done");
    CollectionReference collectionReferencePending = _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection("babyFoodIntake_Pending");

    void choiceAction(String choice) {
      if (choice == sortAscByDate) {
        setState(() {
          descendingDate = false;
          descendingTime = false;
        });
      } else if (choice == sortDescByDate) {
        setState(() {
          descendingDate = true;
          descendingTime = true;
        });
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Select Food Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
          ),
        ),
        backgroundColor: background2,
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.sort_rounded,
              color: Colors.white,
            ),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder(
          stream: widget.collectionReference.orderBy('selectedDate', descending: descendingDate).orderBy('selectedTime', descending: descendingTime).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      backgroundColor: Colors.black,
                      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                    ),
                  ),
                );
              } else if (snapshot.data.documents.isEmpty) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
                    child: Text(
                      'There is currently no records',
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return Container(
                          child: RecordListViewWidget(
                            svgSrc: widget.svgSrc,
                            recordPrimaryTitle: "Record Date",
                            recordSecondaryTitle: "Record Time",
                            recordPrimaryDesc: DateFormat('d MMM yyyy').format(DateTime.parse(snapshot.data.documents[index]['selectedDate'])),
                            recordSecondaryDesc: DateFormat('h:mm a').format(DateTime.parse(snapshot.data.documents[index]['selectedDate'] + " " + snapshot.data.documents[index]['selectedTime'])),
                            babyFoodRecord: true,
                            motherHealthRecord: false,
                            completeBabyFoodRecord: widget.completeBabyFoodRecord,
                            symptomsAllergies: (widget.completeRecord == true) ? snapshot.data.documents[index]["symptomsAndAllergies"] : null,
                            longPress: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                  ),
                                  isScrollControlled: true,
                                  builder: (context) => Container(
                                        height: MediaQuery.of(context).size.height * 0.8,
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: BabyFoodIntakeTrackSneakPeak(
                                            foodIntakeRecordID: snapshot.data.documents[index]["recordID"],
                                            selectedBabyID: widget.selectedBabyID,
                                            collectionReference: (widget.completeRecord == true) ? collectionReferenceComplete : collectionReferencePending,
                                            completeRecord: widget.completeRecord,
                                          ),
                                        ),
                                      ));
                            },
                            delete: () {
                              if (widget.completeRecord == true) {
                                setState(() => databaseTable = "babyFoodIntake_Done");
                              } else {
                                setState(() => databaseTable = "babyFoodIntake_Pending");
                              }
                              _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID).collection(databaseTable).doc(snapshot.data.documents[index]['recordID']).delete();
                            },
                            press: () {
                              if (widget.completeRecord == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BabyFoodIntakeTrackView(
                                            recordID: snapshot.data.documents[index]["recordID"],
                                            selectedBabyID: widget.selectedBabyID,
                                          )),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BabyFoodIntakeTrackUpdate(
                                            recordID: snapshot.data.documents[index]["recordID"],
                                            selectedBabyID: widget.selectedBabyID,
                                            babyFoodRecordListContext: context,
                                          )),
                                );
                              }
                            },
                          ),
                        );
                      }),
                );
              }
            } else if (snapshot.hasError) {
              print("error");
            }
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
                    'Loading...',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
