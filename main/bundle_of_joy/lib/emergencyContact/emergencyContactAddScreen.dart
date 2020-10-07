import 'package:flutter/material.dart';
//import 'emergencyContactAdd.dart';
import 'package:contact_picker/contact_picker.dart';
import '../firestore/emerContact.dart';
import 'package:bundle_of_joy/mother-to-be.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmerContactScreen extends StatefulWidget {
  @override
  _AddEmerContactScreenState createState() => _AddEmerContactScreenState();
}

class _AddEmerContactScreenState extends State<AddEmerContactScreen> {
  final ContactPicker _contactPicker = new ContactPicker();
  String _emerContactNo = "", _emerContactName = "";
  EmerContact emerContact = EmerContact();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/icons/contact.png"),
            )),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Text(
              "Seems like you don't have any emergency contact save in your profile.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          RaisedButton(
            color: Color(0xFFFCFFD5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: BorderSide(width: 1.5, color: Colors.black)),
            onPressed: () async {
              Contact contact = await _contactPicker.selectContact();
              setState(() {
                _emerContactNo = contact.phoneNumber.number;
                _emerContactName = contact.fullName;
                emerContact.addEmerContact(_emerContactNo);
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MotherToBeTab()));
                Fluttertoast.showToast(
                  msg: "Contact Added",
                  toastLength: Toast.LENGTH_LONG,
                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 12, bottom: 12),
              child: Text(
                "Add Contact",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.023,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}