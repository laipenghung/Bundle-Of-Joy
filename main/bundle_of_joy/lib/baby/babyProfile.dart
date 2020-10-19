import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class BabyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BabyProfile();
}

class _BabyProfile extends State<BabyProfile>{

  Widget _listView(AsyncSnapshot<QuerySnapshot> collection){

  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    final User user = FirebaseAuth.instance.currentUser;
    Query baby = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").orderBy("b_name");
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Baby's Profile",
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
            stream: baby.snapshots(),
            builder: (context, document){
              return _listView(document);
            }
        ),
      ),
    );
  }
}

