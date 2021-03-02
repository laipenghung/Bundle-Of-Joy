import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'emerContact.dart';
import 'package:bundle_of_joy/mother-to-be.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EContactAddSecondary extends StatefulWidget {
  final String patientID;
  EContactAddSecondary({Key key, this.patientID});

  @override
  _EContactAddSecondaryState createState() => _EContactAddSecondaryState();
}

class _EContactAddSecondaryState extends State<EContactAddSecondary> {
  String _secEmerContactNo = "", _secEmerContactName = "";
  EmerContact secEmerContact = EmerContact();

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
    return Scaffold(
      body: Center(
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
                "Seems like you don't have a secondary emergency contact save in your profile.",
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
                String message = "You have successfully save your secondary emergency contact to your profile. You can always manage your emergency contacts in Profile.";
                setState(() {
                  _secEmerContactNo = contact.phoneNumber.number;
                  _secEmerContactName = contact.fullName;      
                  secEmerContact.addEmerContactSecondary(_secEmerContactNo, _secEmerContactName, widget.patientID);
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
      ),
      
    );
  }
}