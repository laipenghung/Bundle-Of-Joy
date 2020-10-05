import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "firestore/mother.dart";

class MotherProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotherProfile();
}

class _MotherProfile extends State<MotherProfile>{
  String input = "";
  ListView _listView(AsyncSnapshot<DocumentSnapshot> document) {
    final _listItems = ["Picture", "Name", "Age", "Date Of Birth", "Blood Type", "No Of Child", "Personal Phone", "Emergency Contact"];
    final _listInfo = [
      "Picture_no",
      document.data.data()["m_name"].toString(),
      document.data.data()["m_age"].toString(),
      document.data.data()["m_dob"].toString(),
      document.data.data()["m_bloodType"].toString(),
      document.data.data()["m_no_of_child"].toString(),
      document.data.data()["m_phone"].toString(),
      document.data.data()["m_emergencyContact"].toString()
    ];
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
            onTap: (){
              editBox(index, document, context);
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
    );
  }

  Future<bool> editBox(int index, AsyncSnapshot<DocumentSnapshot> document, BuildContext context) {
    Mother mother = new Mother();
    final _listEditTitles = ["Edit Picture", "Edit Name", "Edit Age", "Edit Date Of Birth", "Edit Blood Type", "Edit No Of Child", "Edit Personal Phone", "Edit Emergency Contact"];
    final _listField = ["photoURL", "m_name", "m_age", "m_dob", "m_bloodType", "m_no_of_child", "m_phone", "m_emergencyContact"];
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFCFFD5),
          title: Text(_listEditTitles[index]),
          content: editField(index, document, _listField),
          actions: <Widget>[
            FlatButton(
              child: Text("Done"),
              onPressed: () {
                mother.editProfile(_listField[index], input);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Widget editField(int index, AsyncSnapshot<DocumentSnapshot> document, List _lisField){
    if(index == 4){
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.only(left:20.0, right:20.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Color(0xFFFCFFD5),
                  value: input,
                  items: <String>["A", "B", "O", "AB"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState((){
                      input = value;
                    });
                  },
                ),
              ),
            );
          }
      );
    }
    else{
      return TextField(
        controller: TextEditingController(text: document.data.data()[_lisField[index]].toString()),
        onChanged: (value) {
          input = value;
        },
      );
    }
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

