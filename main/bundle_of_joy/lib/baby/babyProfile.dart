import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "baby.dart";
import "babyInfo.dart";

class BabyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BabyProfile();
}

class _BabyProfile extends State<BabyProfile> {
  Widget _listView(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    final _listField = [
      "b_id",
      "m_id",
      "b_registered_id",
      "b_name",
      "b_dob",
      "b_place_of_birth",
      "b_gender",
      "b_age",
      "b_bloodType",
      "b_mode_of_delivery",
      "b_weight_at_birth",
      "b_length_at_birth",
      "b_head_circumference",
      "b_order"
    ];
    List<Baby> _listBaby = List<Baby>();
    if (collection.data.docs.isNotEmpty) {
      collection.data.docs.forEach((doc) {
        _listBaby.add(Baby(
            doc.data()[_listField[0]],
            doc.data()[_listField[1]],
            doc.data()[_listField[2]],
            doc.data()[_listField[3]],
            doc.data()[_listField[4]],
            doc.data()[_listField[5]],
            doc.data()[_listField[6]],
            doc.data()[_listField[7]],
            doc.data()[_listField[8]],
            doc.data()[_listField[9]],
            doc.data()[_listField[10]].toDouble(),
            doc.data()[_listField[11]].toDouble(),
            doc.data()[_listField[12]].toDouble(),
            doc.data()[_listField[13]].toInt()));
      });

      return ListView.separated(
        itemCount: _listBaby.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_listBaby[index].b_name),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BabyInfo(baby: _listBaby[index])),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    } else {
      return Container(
        child: Center(
          child: Text(
            "No Record Found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSizeTitle,
              fontFamily: "Comfortaa",
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query baby = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").orderBy("b_name");
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
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
            builder: (context, document) {
              return _listView(document);
            }),
      ),
    );
  }
}
