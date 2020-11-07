import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

import 'babyTemp_record_done.dart';

class BabyTempListDone extends StatefulWidget {
  final String selectedBabyID;
  BabyTempListDone({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _BabyTempListDoneState createState() => _BabyTempListDoneState();
}

class _BabyTempListDoneState extends State<BabyTempListDone> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> deleteSelected(recordID) {
    //final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;

    return _db.collection("mother").doc(user.uid).collection("baby").doc(widget.selectedBabyID)
      .collection("tempRecord_Done").doc(recordID).delete().then((value) {
      print("Deleted");
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FoodIntakeListDone()));
    }).catchError((error) => print("wrong"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Baby Temperature Record",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _db.collection('mother').doc(user.uid).collection("baby")
          .doc(widget.selectedBabyID).collection("tempRecord_Done").snapshots(),
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
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        print(snapshot.data.documents[index]['recordID']);
                        //go to record_pending
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BabyTempRecordDone(babyTempRecordID: snapshot.data.documents[index]["recordID"],
                            selectedBabyID: widget.selectedBabyID)),
                        );
                      },
                      child: Column(
                        children: [
                          Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.22,
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                caption: "Delete",
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  print(snapshot.data.documents[index]['recordID']);
                                  deleteSelected(snapshot.data.documents[index]['recordID']);
                                },
                              )
                            ],
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.015,
                                  bottom: MediaQuery.of(context).size.height * 0.015,
                                  left: MediaQuery.of(context).size.width * 0.07),
                              //color: Colors.lightBlue,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                    child: Image.asset(
                                      "assets/icons/meal.png",
                                      height: MediaQuery.of(context).size.height * 0.06,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date:",
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Text(
                                                "Time:",
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data.documents[index]['selectedDate'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                              Text(
                                                snapshot.data.documents[index]['selectedTime'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                                      Text(
                                        'View Record >>>',
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontSize: MediaQuery.of(context).size.width * 0.03,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            indent: MediaQuery.of(context).size.width * 0.03,
                            endIndent: MediaQuery.of(context).size.width * 0.03,
                            color: Colors.black,
                            thickness: MediaQuery.of(context).size.height * 0.001,
                          ),
                        ],
                      ),
                    );
                  },
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
    );
  }
}
