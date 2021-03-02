import 'package:flutter/material.dart';
//import 'emergencyContactAdd.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'emerContact.dart';
import 'package:bundle_of_joy/mother-to-be.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddEmerContactScreen extends StatefulWidget {
  final String patientID;
  AddEmerContactScreen({Key key, this.patientID});

  @override
  _AddEmerContactScreenState createState() => _AddEmerContactScreenState();
}

class _AddEmerContactScreenState extends State<AddEmerContactScreen> {
  String _emerContactNo = "", _emerContactName = "";
  EmerContact emerContact = EmerContact();

  _showDialogBox(BuildContext context, message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Emergency contact added."),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
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
                fontSize: fontSizeText,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          RaisedButton(
            color: Color(0xFFFCFFD5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(width: 1.5, color: Colors.black)),
            onPressed: () async {
              //Contact contact = await _contactPicker.selectContact();
              var contact = await FlutterContactPicker.pickPhoneContact();
              String message = "You have successfully save your emergency contact to your profile. You can always manage your emergency contacts in Profile." +
                "To add your second emergency contact click on the add icon located on the top right.";
              setState(() {
                _emerContactNo = contact.phoneNumber.number;
                _emerContactName = contact.fullName;     
                emerContact.addEmerContactPrimary(_emerContactNo, _emerContactName, widget.patientID);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MotherToBeTab()));
                _showDialogBox(context, message);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
              child: Text(
                "Add Contact",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeTitle,
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
