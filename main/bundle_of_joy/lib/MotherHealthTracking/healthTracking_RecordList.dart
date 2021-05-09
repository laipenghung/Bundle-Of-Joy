import 'dart:developer';
import 'package:bundle_of_joy/MotherHealthTracking/healthTracking_Add.dart';
import 'package:bundle_of_joy/MotherHealthTracking/healthTracking_RecordView.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/recordListViewWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HealthTrackRecordList extends StatefulWidget {
  final CollectionReference collectionReference;
  final String svgSrc;
  HealthTrackRecordList({Key key, @required this.collectionReference, @required this.svgSrc}) : super(key: key);
  @override
  _HealthTrackRecordListState createState() => _HealthTrackRecordListState();
}

class _HealthTrackRecordListState extends State<HealthTrackRecordList> {
  bool descendingDate = true;
  final User user = FirebaseAuth.instance.currentUser;
  String databaseTable;

  static String sortAscByDate = "Sort By Date Ascendingly";
  static String sortDescByDate = "Sort By Date Descendingly";
  static List<String> choices = <String>[sortAscByDate, sortDescByDate];

  @override
  Widget build(BuildContext context) {
    void choiceAction(String choice) {
      if (choice == sortAscByDate) {
        setState(() {
          descendingDate = false;
        });
      } else if (choice == sortDescByDate) {
        setState(() {
          descendingDate = true;
        });
      }
    }

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Health Record",
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: appbar1,
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
          stream: widget.collectionReference.orderBy('mh_day_of_pregnancy', descending: descendingDate).snapshots(),
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
                      'There is currently no record',
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
                            recordSecondaryTitle: "Day Of Pregnancy",
                            recordPrimaryDesc: DateFormat('d MMM yyyy').format(DateTime.parse(snapshot.data.documents[index]['mh_date'])),
                            recordSecondaryDesc: snapshot.data.documents[index]['mh_day_of_pregnancy'].toString(),
                            babyFoodRecord: false,
                            motherHealthRecord: true,
                            longPress: () {
                              log("message");
                            },
                            delete: () {},
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HealthTrackRecordView(healthRecordID: snapshot.data.documents[index]["mh_id"])),
                              );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HealthTrackingAdd()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: appbar1,
      ),
    );
  }
}
