import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class MotherInfo extends StatefulWidget {
  final Map<String, dynamic> document;
  MotherInfo({Key key, this.document}) : super(key: key);
  @override
  _MotherInfo createState() => _MotherInfo(document);
}

class _MotherInfo extends State<MotherInfo> {
  final Map<String, dynamic> document;
  _MotherInfo(this.document);

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    final _listItems = ["Name", "Age", "Date Of Birth", "Blood Type", "No Of Child", "Personal Phone", "Emergency Contact"];

    final _listInfo = [
      document["m_name"].toString(),
      document["m_age"].toString(),
      document["m_dob"].toString(),
      document["m_bloodType"].toString(),
      document["m_no_of_child"].toString(),
      document["m_phone"].toString(),
      document["m_emergencyContact"].toString()
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Mother's Profile",
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
      body: ListView.separated(
        itemCount: _listItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _listItems[index],
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Comfortaa",
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            trailing: Text(
              _listInfo[index],
              style: TextStyle(
                fontFamily: "Comfortaa",
                fontSize: fontSize,
              ),
            ),
            onTap: () {
              //editBox(index, document, context);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
