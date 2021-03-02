import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class EmerContactCall extends StatefulWidget {
  final String patientID;
  EmerContactCall({Key key, this.patientID});

  @override
  _EmerContactCallState createState() => _EmerContactCallState();
}

class _EmerContactCallState extends State<EmerContactCall> {
  final User user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var selectedContactNo;
  String primaryEmerContact, secondaryEmerContact;
  List<String> contact = List<String>();

  void initState(){
    super.initState();
    _getEmerContact();
  }

  //Change the data fetch from firebase from list into map
  void _getEmerContact() async {
    var x = await _db.collection('patient').where('patient_id', isEqualTo: widget.patientID).get();
    if (x.docs[0].data()["m_emergencyContactNoPrimary"] != null){
      //String primaryEmerContactName = x.docs[0].data()["m_emergencyContactNamePrimary"];
      primaryEmerContact = x.docs[0].data()["m_emergencyContactNoPrimary"];
      //primaryEmerContact = primaryEmerContactName + " ("+primaryEmerContactNo+")"; 
      //log(primaryEmerContact);
      setState(() {
        contact.add(primaryEmerContact);
      });
      
    }
    if (x.docs[0].data()["m_emergencyContactNoSecondary"] != null){
      //String secondaryEmerContactName = x.docs[0].data()["m_emergencyContactNameSecondary"];
      secondaryEmerContact = x.docs[0].data()["m_emergencyContactNoSecondary"];
      //primaryEmerContact = secondaryEmerContactName + " ("+secondaryEmerContactNo+")"; 
      //log(secondaryEmerContact);
      setState(() {
        contact.add(secondaryEmerContact);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/icons/alarm.png"),
            )),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Text(
            "Have an emergency? \n Click the button to call now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.black,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Container( //Dropdown list for emergenct contact
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Select Emergency Contact"),
                      value: selectedContactNo,
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          selectedContactNo = newValue;
                        });
                        print(selectedContactNo);
                      },
                      items: contact.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Container(
            child: RaisedButton(
                color: Color(0xFFFCFFD5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(width: 1.5, color: Colors.black)),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                      top: MediaQuery.of(context).size.height * 0.02,
                      bottom: MediaQuery.of(context).size.height * 0.02),
                  child: Text(
                    "Call Now",
                    style: (TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontFamily: "Comfortaa",
                    )),
                  ),
                ),
                onPressed: ()  {
                    FlutterPhoneDirectCaller.callNumber(selectedContactNo);
                }),
          ),
        ],
      ),
    );
  }
}
