import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";


class MotherHealthTracking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotherHealthTracking();
}

class _MotherHealthTracking extends State<MotherHealthTracking>{
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.collection("mother").doc(user.uid);
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    SingleChildScrollView _listView(AsyncSnapshot<DocumentSnapshot> document) {
      double picture_scale = 8.0;
      double paddingLeft = MediaQuery.of(context).size.width * 0.1;
      double paddingTopPic = MediaQuery.of(context).size.height * 0.05;
      double fontSizeText = MediaQuery.of(context).size.width * 0.04;

      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/icons/blood-sugar-level.png",
                        scale: picture_scale,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blood Sugar Level",
                          style: (
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeTitle,
                            )
                          ),
                        ),
                        Text(
                          "4.2",
                          style: (
                              TextStyle(
                                fontSize: fontSizeText,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/icons/blood-pressure-level.png",
                        scale: picture_scale,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Blood Pressure",
                          style: (
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle,
                              )
                          ),
                        ),
                        Text(
                          "4.2",
                          style: (
                              TextStyle(
                                fontSize: fontSizeText,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/icons/weight.png",
                        scale: picture_scale,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weight (kg)",
                          style: (
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle,
                              )
                          ),
                        ),
                        Text(
                          "4.2",
                          style: (
                              TextStyle(
                                fontSize: fontSizeText,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(paddingLeft, paddingTopPic, paddingLeft, 0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/icons/height.png",
                        scale: picture_scale,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, paddingLeft, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Height (cm)",
                          style: (
                              TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeTitle,
                              )
                          ),
                        ),
                        Text(
                          "4.2",
                          style: (
                              TextStyle(
                                fontSize: fontSizeText,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Health Tracking",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: fontSizeTitle,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: users.snapshots(),
          builder: (context, document){
            return _listView(document);
          }
      ),
    );
  }
}

