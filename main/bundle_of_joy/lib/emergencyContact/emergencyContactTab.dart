import '../emergencyContact/emergencyContactCall.dart';
import 'package:flutter/material.dart';
import 'emergencyContactAddScreen.dart';

class EmergencyContactTab extends StatelessWidget {
  final bool contact;
  EmergencyContactTab({Key key, @required this.contact}) : super();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emergency Contact",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: contact == true ? EmerContactCall() : AddEmerContactScreen(),
    );
  }
}
