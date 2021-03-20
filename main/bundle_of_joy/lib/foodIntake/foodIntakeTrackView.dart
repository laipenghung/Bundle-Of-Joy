import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiver/iterables.dart';
import 'package:intl/intl.dart';

class FoodIntakeTrackView extends StatefulWidget {
  final String foodIntakeRecordID;
  FoodIntakeTrackView({Key key, @required this.foodIntakeRecordID}) : super(key: key);

  @override
  _FoodIntakeTrackViewState createState() => _FoodIntakeTrackViewState();
}

class _FoodIntakeTrackViewState extends State<FoodIntakeTrackView> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid).collection("foodIntake_Done");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.2,
            floating: true,
            pinned: true,
            stretch: true,
            stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                "Food Intake Tracking",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: FutureBuilder<DocumentSnapshot>(
              future: collectionReference.doc(widget.foodIntakeRecordID).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  DateTime parsedDate = DateTime.parse(snapshot.data.data()["selectedDate"]);
                  String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
                  DateTime parsedTime = DateTime.parse(snapshot.data.data()["selectedDate"] + " " + snapshot.data.data()["selectedTime"]);
                  String formattedTime =  DateFormat('h:mm a').format(parsedTime);
                  Map food = snapshot.data.data()["foodMap"];
                  List<dynamic> foodName = List<dynamic>();
                  List<dynamic> foodQty = List<dynamic>();
                  foodName = food.keys.toList();
                  foodQty = food.values.toList();
                  var bSugarBefore = double.parse(snapshot.data.data()["bsBefore"]);
                  var bSugarAfter = double.parse(snapshot.data.data()["bsAfter"]);
                  //print(foodName);
                  //print(foodQty);

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 18.0, left: 13.0,),
                          child: Text(
                            "Date and Time",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Date and Time section
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(15, 15),
                                  blurRadius:30,
                                  spreadRadius: 20,
                                  color: Color(0xFFE6E6E6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0,),
                                      child: Text(
                                        "Date",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    //"27 Jan 2021",
                                    formattedDate,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.056,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    "The date you record this intake.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: Colors.black.withOpacity(0.65),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25.0,),
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0,),
                                      child: Text(
                                        "Time",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    //"9:00 P.M.",
                                    formattedTime,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.055,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    "The time you record this intake.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: Colors.black.withOpacity(0.65),
                                    ),
                                  ),
                                ),
                              ],
                            ), 
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                          child: Text(
                            "Conusmed Food",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Food section
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(30, 17),
                                  blurRadius: 23,
                                  spreadRadius: -13,
                                  color: Color(0xFFE6E6E6),
                                ),
                              ],),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                                    Container(
                                      padding: EdgeInsets.only(left: 8.0,),
                                      child: Text(
                                        "Food",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 8.0,),
                                  child: Text(
                                    "Food that you consumed.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: Colors.black.withOpacity(0.65),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: Table(
                                    children: [
                                      //for(var x in foodName)
                                      for (var x in zip([foodName, foodQty]))
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: double.infinity,
                                                  child: Text(
                                                    x[0].toString(),
                                                    //"Food name 1",
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.only(bottom: 8.0),
                                                  child: Text(
                                                    "x " + x[1].toString() + " Plate",
                                                    //"Food name 1",
                                                    textAlign: TextAlign.left,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                                      color: Colors.black.withOpacity(0.65),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]
                                      ), 
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                          child: Text(
                            "Blood Pressure",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        //Blood Pressure section
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(30, 17),
                                  blurRadius: 23,
                                  spreadRadius: -13,
                                  color: Color(0xFFE6E6E6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0,),
                                      child: Text(
                                        "Blood Pressue Reading",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.045,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 15.0, bottom: 15.0,),
                                  child: Table(
                                    //border: TableBorder.all(color: Colors.black),
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.only(top: 8, bottom: 8,),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 0.5, 
                                                    color: Colors.black.withOpacity(0.65),
                                                  ),
                                                )
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    bSugarBefore.toString() + " mmol/L",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(top: 3),
                                                    child: Text(
                                                      "Before 2 hours",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(context).size.width * 0.033,
                                                        color: Colors.black.withOpacity(0.65),
                                                      ),
                                                    ),
                                                  ),
                                                ] 
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.only(top: 8, bottom: 8,),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    bSugarAfter.toString() + " mmol/L",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(top: 3),
                                                    child: Text(
                                                      "After 2 hours",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(context).size.width * 0.033,
                                                        color: Colors.black.withOpacity(0.65),
                                                      ),
                                                    ),
                                                  ),
                                                ] 
                                              ),
                                            ),
                                          ),
                                        ]
                                      ), 
                                    ],
                                  ),
                                ),
                              ],
                            ), 
                          ),
                        ),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  print("error");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}