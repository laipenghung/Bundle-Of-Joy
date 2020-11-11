import "dart:async";
import 'package:bundle_of_joy/motherProfile/motherInfo.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/services.dart";
import 'mother.dart';
import "package:pinput/pin_put/pin_put.dart";

class MotherProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MotherProfile();
}

class _MotherProfile extends State<MotherProfile> {
  String input;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

/*  Future<bool> editBox(int index, AsyncSnapshot<DocumentSnapshot> document, BuildContext context) {
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
          lastDate: DateTime(selectedDate.year + 10),
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
          mother.editProfile(_listField[index], DOB);
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
                    mother.editProfile(_listField[index], input);
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
              items: <String>["A", "B", "O", "AB"].map((String value) {
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
  }*/

  Widget is_verify(AsyncSnapshot<DocumentSnapshot> mother, CollectionReference patient, String uid) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.03;
    if (mother.data.data()["is_verify"] == false) {
      return Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: paddingTop),
                    child: Text(
                      "Please enter your verification code given by hospital.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.all(20.0),
                    child: PinPut(
                      keyboardType: TextInputType.text,
                      fieldsCount: 6,
                      onSubmit: (String pin) async {
                        Future<QuerySnapshot> pin_code = patient.where("pin_code", isEqualTo: pin).get();

                        pin_code.then((value) {
                          if (value.size == 0) {
                            print("No record found");
                          } else {
                            CollectionReference users = FirebaseFirestore.instance.collection("mother");
                            users
                                .doc(uid)
                                .update({"pin_code": pin.toString(), "is_verify": true})
                                .then((value) => print("Mother profile updated"))
                                .catchError((e) => print("Failed to update mother profile: $e"));

                            patient
                                .doc(value.docs.first.data()["patient_id"])
                                .update({"m_id": uid})
                                .then((value) => print("Patient updated"))
                                .catchError((e) => print("Failed to update patient: $e"));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MotherInfo(document: value.docs.first.data()),
                              ),
                            );
                          }
                        });
                      },
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.deepPurpleAccent.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: buttonShape(),
                        onPressed: () => _pinPutFocusNode.requestFocus(),
                        child: Text('Focus',
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.022,
                            )),
                      ),
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: buttonShape(),
                        onPressed: () => _pinPutFocusNode.unfocus(),
                        child: Text('Unfocus',
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.022,
                            )),
                      ),
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: buttonShape(),
                        onPressed: () => _pinPutController.text = '',
                        child: Text('Clear All',
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.022,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      Future<QuerySnapshot> mother = patient.where("m_id", isEqualTo: uid).get();
      mother.then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MotherInfo(document: value.docs.first.data()),
          ),
        );
      });
      return loading();
    }
  }

  RoundedRectangleBorder buttonShape() {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 1.5, color: Colors.black));
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(width: 2, color: Colors.black),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  Widget loading() {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
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
            "Loading...",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.collection("mother").doc(user.uid);
    CollectionReference patient = FirebaseFirestore.instance.collection("patient");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Account Verification",
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
            builder: (context, mother) {
              if (mother.hasData) {
                return is_verify(mother, patient, user.uid.toString());
              } else {
                return loading();
              }
            }),
      ),
    );
  }
}
