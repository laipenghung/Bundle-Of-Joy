import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class MotherProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotherProfile();
}

class _MotherProfile extends State<MotherProfile>{
  ListView _listView(AsyncSnapshot<DocumentSnapshot> document) {
    var data = document.data.data();
    final _listItems = ["Picture", "Name", "Age", "Date Of Birth", "Blood Type", "No Of Child", "Personal Phone", "Emergency Contact"];
    final _listInfo = ["null", data["m_name"].toString(),  data["m_age"].toString(),  data["m_dob"].toString(),  data["m_bloodType"].toString(),  data["m_no_of_child"].toString(),  data["m_phone"].toString(),  data["m_emergencyContact"].toString()];
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    return ListView.separated(
        itemCount: _listItems.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(
              _listItems[index],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            trailing: Text(_listInfo[index]),
          );
        },
        separatorBuilder: (context, index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.06;
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.collection("mother").doc(user.uid);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Mother's Profile",
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: users.snapshots(),
          builder: (context, document){
            return _listView(document);
          }
        ),
      ),
    );
  }
}

