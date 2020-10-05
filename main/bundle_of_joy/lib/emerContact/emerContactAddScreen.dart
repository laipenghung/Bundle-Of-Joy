import 'package:flutter/material.dart';
import 'emerContactAdd.dart';

class AddEmerContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.home,
            color: Colors.black,
            size: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
            child: Text(
              "Seems like you don't have any emergency contact save in your profile.",
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmerContactAdd()),
            ),
            child: Text("Add Contact"),
          ),
        ],
      ),
    );
  }
}