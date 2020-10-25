import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:intl/intl.dart';
import "baby.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

class AddBaby extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBaby();
}

class _AddBaby extends State<AddBaby>{
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    //DocumentReference babyDoc = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby");
    double longWidth = MediaQuery.of(context).size.width * 0.85;
    double shortWidth = MediaQuery.of(context).size.width * 0.4;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Add baby",
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
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _key,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: longWidth,
                      child: FormBuilderTextField(
                        attribute: "name",
                        decoration: InputDecoration(labelText: "Name*"),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: longWidth,
                      child: FormBuilderTextField(
                        attribute: "registered_id",
                        decoration: InputDecoration(labelText: "Baby registered ID*"),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: longWidth,
                      child: FormBuilderTextField(
                        attribute: "age",
                        decoration: InputDecoration(labelText: "Age* (Eg: 1 month)"),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: shortWidth,
                      child: FormBuilderDateTimePicker(
                        attribute: "dob",
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration: InputDecoration(labelText: "Date of Birth*"),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                    Container(
                      width: shortWidth,
                      child: FormBuilderDateTimePicker(
                        attribute: "tob",
                        inputType: InputType.time,
                        format: DateFormat("H:m"),
                        decoration: InputDecoration(labelText: "Time of Birth"),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: shortWidth,
                      child: FormBuilderDropdown(
                        attribute: "gender",
                        decoration: InputDecoration(labelText: "Gender*"),
                        validators: [FormBuilderValidators.required()],
                        items: ["Male", "Female"].map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text("$gender")
                        )).toList(),
                      ),
                    ),
                    Container(
                      width: shortWidth,
                      child: FormBuilderDropdown(
                        attribute: "bloodType",
                        decoration: InputDecoration(labelText: "Blood Type*"),
                        validators: [FormBuilderValidators.required()],
                        items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].map((bloodType) => DropdownMenuItem(
                            value: bloodType,
                            child: Text("$bloodType")
                        )).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(width: 1, color: Colors.black)
                        ),
                        child: Text("Submit"),
                        onPressed: (){
                          if(_key.currentState.saveAndValidate()){
                            print(_key.currentState.value);
                          }
                        },
                      ),
                      RaisedButton(
                          color: Color(0xFFFCFFD5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                              side: BorderSide(width: 1, color: Colors.black)
                          ),
                        child: Text("Reset"),
                        onPressed: (){
                          _key.currentState.reset();
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

