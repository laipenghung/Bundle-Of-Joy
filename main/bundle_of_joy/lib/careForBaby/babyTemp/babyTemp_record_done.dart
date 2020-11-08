import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class BabyTempRecordDone extends StatefulWidget {
  final String babyTempRecordID, selectedBabyID;
  BabyTempRecordDone({Key key, this.babyTempRecordID, this.selectedBabyID}) : super(key: key);

  @override
  _BabyTempRecordDoneState createState() => _BabyTempRecordDoneState();
}

class _BabyTempRecordDoneState extends State<BabyTempRecordDone> {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0) //<--- border radius here
          ),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0) //<--- border radius here
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
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

      // BODY
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection("mother").doc(FirebaseAuth.instance.currentUser.uid)
          .collection("baby").doc(widget.selectedBabyID).collection("tempRecord_Done").doc(widget.babyTempRecordID).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map meds = snapshot.data.data()["medsMap"];
            List<dynamic> medsName = List<dynamic>();
            medsName = meds.values.toList();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
                    //color: Colors.lightBlue,
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/calendar.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                child: Text(
                                  snapshot.data.data()["selectedDate"],
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/time.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                child: Text(
                                  snapshot.data.data()["selectedTime"],
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/food-intake.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Table(
                                      //border: TableBorder.all(width: 1.0, color: Colors.black),
                                      children: [
                                        for (var x in medsName)
                                          TableRow(children: [
                                            TableCell(
                                                child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  //color: Colors.blue,
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  child: new Text(
                                                    x.toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Comfortaa',
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context).size.height * 0.023,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ))
                                          ])
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/icons/blood-sugar-level.png",
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Before: ",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.data()["bTempBefore"],
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                                    child: Row(
                                      children: [
                                        Text(
                                          "After: ",
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.data()["bTempAfter"],
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: myBoxDecoration(),
                            child: Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }, //ADD TO DATABASE
                        ),
                      ],
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
    );
  }
}
