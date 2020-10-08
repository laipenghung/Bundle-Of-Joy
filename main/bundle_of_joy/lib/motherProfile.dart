import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/services.dart";
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
    Future<bool> _selectDate() async{
      DateTime selectedDate = DateTime.now();
      String year, month, day, DOB;
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(selectedDate.year-150),
          lastDate: DateTime(selectedDate.year+10),
          builder: (BuildContext context, Widget child){
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.dark(
                  surface:  Color(int.parse("0xFFFCFFD5")),
                  onSurface: Colors.black,
                ),
              ),
              child: child,
            );
          }
      );
      if(picked != null){
        setState(() {
          year = picked.year.toString();
          month = picked.month.toString();
          day = picked.day.toString();
          DOB = "$year-$month-$day";
          mother.editProfile(_listField[index], DOB);
        });
        return true;
      }else{
        return false;
      }
    }

    if(index == 3){
      return _selectDate();
    }
    else {
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
                    mother.editProfile(_listField[index], input);
                    input = "";
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }

  Widget editField(int index, AsyncSnapshot<DocumentSnapshot> document, List _lisField){
    double margin = 30;
    if(index == 4){
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: EdgeInsets.only(left:margin, right:margin),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Color(0xFFFCFFD5),
                  value: input,
                  items: <String>["", "A", "B", "O", "AB"].map((String value) {
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
    else if(index == 2 || index == 5 || index == 6 || index == 7){
      return Container(
        margin: EdgeInsets.only(left:margin+20, right:margin+20),
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: document.data.data()[_lisField[index]].toString()),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            input = value;
          },
        ),
      );
    }
    else{
      return Container(
        margin: EdgeInsets.only(left:margin, right:margin),
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: document.data.data()[_lisField[index]].toString()),
          onChanged: (value) {
            input = value;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
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
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
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

