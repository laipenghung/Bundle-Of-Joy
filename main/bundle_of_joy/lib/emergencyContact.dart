import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:contact_picker/contact_picker.dart';

class EmergencyContacyTab extends StatefulWidget {
  //final String user

  @override
  _EmergencyContacyTabState createState() => _EmergencyContacyTabState();
}

class _EmergencyContacyTabState extends State<EmergencyContacyTab> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency Contact",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      
      body: Column(
        children: <Widget>[
          Row(
            children: [
              Container(
                child: RaisedButton(
                  onPressed: () async {
                      Contact contact = await _contactPicker.selectContact();
                      setState(() {
                        _contact = contact;
                      });
                  },
                  child: Text(
                    "Get Contact"
                  ),
                ),
              )
            ],  
          ),

          Row(
            children: [
              Container(
                child: Text(
                  _contact == null ? "no select" : _contact.toString(),
                ),
              )
            ],
          )
        ],
      ) 
      
      
      
      
      
      
    );
  }
}
