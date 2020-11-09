import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "baby.dart";

class BabyInfo extends StatefulWidget {
  final Baby baby;
  BabyInfo({Key key, this.baby}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BabyInfo(baby);
}

class _BabyInfo extends State<BabyInfo> {
  final Baby baby;
  _BabyInfo(this.baby);
  String input;

  ListView _listView(AsyncSnapshot<DocumentSnapshot> document) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    final _listItems = [
      "Registered ID",
      "Name",
      "Date of Birth",
      "Time of Birth",
      "Place of Birth",
      "Gender",
      "Age",
      "Blood Type",
      "Mode Of Delivery",
      "Weight At Birth",
      "Length At Birth",
      "Head Circumference",
      "Order"
    ];

    final _listInfo = [
      baby.b_registered_id,
      baby.b_name,
      baby.b_dob.toDate().toString().substring(0, 10),
      baby.b_dob.toDate().toString().substring(11, 16),
      baby.b_place_of_birth,
      baby.b_gender,
      baby.b_age,
      baby.b_bloodType,
      baby.b_mode_of_delivery,
      baby.b_weight_at_birth.toString(),
      baby.b_length_at_birth.toString(),
      baby.b_head_circumference.toString(),
      baby.b_order.toString()
    ];

    return ListView.separated(
      itemCount: _listItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            _listItems[index],
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Comfortaa",
              fontWeight: FontWeight.bold,
              fontSize: fontSizeText,
            ),
          ),
          trailing: Text(
            _listInfo[index],
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference babyDoc = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").doc(baby.b_id);
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1, //APP BAR HEIGHT

        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          baby.b_name,
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
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
            stream: babyDoc.snapshots(),
            builder: (context, document) {
              return _listView(document);
            }),
      ),
    );
  }
}
