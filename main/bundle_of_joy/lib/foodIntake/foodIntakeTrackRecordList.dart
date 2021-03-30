import 'dart:developer';

import 'package:bundle_of_joy/foodIntake/foodIntakeTrackUpdate.dart';
import 'package:bundle_of_joy/foodIntake/foodIntakeTrackView.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/recordListViewWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoodIntakeTrackRecordList extends StatefulWidget {
  final bool completeRecord;
  final CollectionReference collectionReference;
  final String svgSrc;
  FoodIntakeTrackRecordList({Key key, @required this.completeRecord, @required this.collectionReference, @required this.svgSrc}) : super(key: key);

  @override
  _FoodIntakeTrackRecordListState createState() => _FoodIntakeTrackRecordListState();
}

class _FoodIntakeTrackRecordListState extends State<FoodIntakeTrackRecordList> {
  bool descendingDate = true, descendingTime = true;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;
  String databaseTable;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Select Food Record",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),        
        backgroundColor: appThemeColor,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort_rounded, 
              color: Colors.white,
            ), 
            onPressed: () {
              
            })
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
                  child: Text(
                    'There is currently no records',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      color: Colors.black,
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
                    itemBuilder: (_, index){
                      return Container(
                        child: RecordListViewWidget(
                          svgSrc: widget.svgSrc,
                          recordDate: DateFormat('d MMM yyyy').format(DateTime.parse(snapshot.data.documents[index]['selectedDate'])),
                          recordTime: DateFormat('h:mm a').format(DateTime.parse(snapshot.data.documents[index]['selectedDate'] + " " + snapshot.data.documents[index]['selectedTime'])),
                          babyFoodRecord: false,
                          longPress: (){
                            log("message");
                          },
                          delete: (){
                            if(widget.completeRecord == true){
                              setState(() => databaseTable = "foodIntake_Done");
                            }else{
                              setState(() => databaseTable = "foodIntake_Pending");
                            }
                            _db.collection("mother").doc(user.uid).collection(databaseTable).doc(snapshot.data.documents[index]['recordID']).delete();
                          },
                          press: (){
                            if(widget.completeRecord == true){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FoodIntakeTrackView(foodIntakeRecordID: snapshot.data.documents[index]["recordID"])),
                              );
                            }else{
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FoodIntakeTrackUpdate(foodIntakeRecordID: snapshot.data.documents[index]["recordID"])),
                              );
                            } 
                          },
                        ),
                      );
                    }
                  ),
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