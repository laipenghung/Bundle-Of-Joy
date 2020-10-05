import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../firestore/emerContact.dart';

class EmerContactAdd extends StatefulWidget {
  @override
  _EmerContactAddState createState() => _EmerContactAddState();
}

class _EmerContactAddState extends State<EmerContactAdd> {
  final ContactPicker _contactPicker = new ContactPicker();
  //Contact _contact;
  String _emerContactNo = "", _emerContactName = "";
  EmerContact emerContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Form(
              child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 40.0,
              child: RaisedButton(
                onPressed: () async {
                  Contact contact = await _contactPicker.selectContact();
                  setState(() {
                    _emerContactNo = contact.phoneNumber.number;
                    _emerContactName = contact.fullName;
                  });
                  Fluttertoast.showToast(
                    msg: _emerContactName + "\n" + _emerContactNo,
                    toastLength: Toast.LENGTH_LONG,
                  );
                },
                child: Text("Add from Phone Contact"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: 20.0,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Contact Name",
                ),
                onChanged: (val) {
                  setState(() => _emerContactName = val);
                },
                //validator: (val) {
                //if (val.isEmpty) return "Enter the contact name";
                //},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: 20.0,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Contact Number",
                ),
                onChanged: (val) {
                  setState(() => _emerContactNo = val);
                },
                //validator: (val) {
                //if (val.isEmpty) return "Enter the contact name";
                //},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 40,
              child: RaisedButton(
                color: Colors.yellow,
                //onPressed: emerContact.addEmerContact(),
                child: Text("Confirm Emergency Contact"),
              ),
            ),
          ),
        ],
      ))),
    );
  }
}
