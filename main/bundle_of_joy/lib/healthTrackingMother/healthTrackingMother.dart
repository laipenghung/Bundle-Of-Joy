import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class HealthTrackingMother extends StatefulWidget {
  @override
  _HealthTrackingMotherState createState() => _HealthTrackingMotherState();
}

class _HealthTrackingMotherState extends State<HealthTrackingMother> {
  final User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Health Tracking",
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
        stream: FirebaseFirestore.instance.collection('mother').doc(FirebaseAuth.instance.currentUser.uid).collection("health_record").snapshots(),
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
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.015,
                              bottom: MediaQuery.of(context).size.height * 0.015,
                              left: MediaQuery.of(context).size.width * 0.07),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                child: Image.asset(
                                  "assets/icons/health-tracking.png",
                                  height: MediaQuery.of(context).size.height * 0.06,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Day:",
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data.documents[index]["mh_day_of_pregnancy"].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.04,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  Text(
                                    snapshot.data.documents[index]["mh_date"],
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
                        ),
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.03,
                          endIndent: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black,
                          thickness: MediaQuery.of(context).size.height * 0.001,
                        ),
                      ],
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
