import 'package:flutter/material.dart';
import 'emergencyContactAdd.dart';

class AddEmerContactScreen extends StatelessWidget {
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
              )
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          Padding(
            padding: const EdgeInsets.only(left:50, right:50),
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
              side: BorderSide(width: 1.5, color: Colors.black)
            ),
          
            onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmerContactAdd()),
            ),

            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20, top: 12, bottom: 12),

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