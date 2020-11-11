import 'package:bundle_of_joy/motherProfile/mother.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class MotherInfo extends StatefulWidget {
  final String pid;
  MotherInfo({Key key, this.pid}) : super(key: key);
  @override
  _MotherInfo createState() => _MotherInfo(pid);
}

class _MotherInfo extends State<MotherInfo> {
  String input;
  final String pid;
  _MotherInfo(this.pid);

  Future<bool> editBox(int index, AsyncSnapshot<DocumentSnapshot> document, BuildContext context) {
    Mother mother = new Mother();
    final _listEditTitles = [
      "Edit Name",
      "Edit Age",
      "Edit Date Of Birth",
      "Edit Blood Type",
      "Edit No Of Child",
      "Edit Personal Phone",
      "Edit Emergency Contact"
    ];
    final _listField = ["m_name", "m_age", "m_dob", "m_bloodType", "m_no_of_child", "m_phone", "m_emergencyContact"];
    Future<bool> _selectDate() async {
      DateTime selectedDate = DateTime.now();
      String year, month, day, DOB;
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(selectedDate.year - 150),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.dark(
                  surface: Color(int.parse("0xFFFCFFD5")),
                  onSurface: Colors.black,
                ),
              ),
              child: child,
            );
          });
      if (picked != null) {
        setState(() {
          year = picked.year.toString();
          month = picked.month.toString();
          day = picked.day.toString();
          DOB = "$year-$month-$day";
          mother.editProfile(_listField[index], DOB, pid);
        });
        return true;
      } else {
        return false;
      }
    }

    if (index == 2) {
      return _selectDate();
    } else {
      input = document.data.data()[_listField[index]].toString();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Color(0xFFFCFFD5),
              title: Center(child: Text(_listEditTitles[index])),
              content: editField(index, document, _listField),
              actions: <Widget>[
                FlatButton(
                  child: Text("Done"),
                  onPressed: () {
                    mother.editProfile(_listField[index], input, pid);
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Widget editField(int index, AsyncSnapshot<DocumentSnapshot> document, List _listField) {
    double margin = 30;
    if (index == 3) {
      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Color(0xFFFCFFD5),
              value: input,
              items: <String>["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  input = value;
                });
              },
            ),
          ),
        );
      });
    } else if (index == 1 || index == 4 || index == 5 || index == 6) {
      return Container(
        margin: EdgeInsets.only(left: margin + 20, right: margin + 20),
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: document.data.data()[_listField[index]].toString()),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            input = value;
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: margin, right: margin),
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: document.data.data()[_listField[index]].toString()),
          onChanged: (value) {
            input = value;
          },
        ),
      );
    }
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    DocumentReference patient = FirebaseFirestore.instance.collection("patient").doc(pid);

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
      body: StreamBuilder(
        stream: patient.snapshots(),
        builder: (context, document) {
          var patient = document.data;
          final _listItems = ["Name", "Age", "Date Of Birth", "Blood Type", "No Of Child", "Personal Phone", "Emergency Contact"];
          final _listInfo = [
            patient.data()["m_name"].toString(),
            patient.data()["m_age"].toString(),
            patient.data()["m_dob"].toString(),
            patient.data()["m_bloodType"].toString(),
            patient.data()["m_no_of_child"].toString(),
            patient.data()["m_phone"].toString(),
            patient.data()["m_emergencyContact"].toString()
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
                  editBox(index, document, context);
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
          );
        }
      ),
    );
  }
}
