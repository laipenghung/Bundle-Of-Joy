import 'package:flutter/material.dart';

class BloodSugarAddDoneText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.033,);
    TextStyle highlightedTextStyle = TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.033,);

    return Container(
        width: double.infinity,
        child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: normalTextStye,
          children: <TextSpan>[
            TextSpan(
              text: "If you wish to view your Blood Sugar condition in detailed mode with BoJ Blood Sugar Analyzer™." +
                " First, you will have to save the current food intake record. Then navigate to ",
            ),
            TextSpan(text: "Food Intake Tracking", style: highlightedTextStyle,),
            TextSpan(text: " > ",),
            TextSpan(text: "Food Intake Record", style: highlightedTextStyle,),
            TextSpan(text: " and select the food intake record you wish to view.",),
          ]
        )
      ), 
    );
  }
}

class BloodSugarAddPendingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(color: Colors.black.withOpacity(0.65), fontSize: MediaQuery.of(context).size.width * 0.033,);
    TextStyle highlightedTextStyle = TextStyle(color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.033,);

    return Container(
        width: double.infinity,
        child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: normalTextStye,
          children: <TextSpan>[
            TextSpan(
              text: "Once you upload the current food record, you will receive a notification after " +
                "2 hours to inform you to update the after meal Blood Sugar reading. To update it, navigate to ",
            ),
            TextSpan(text: "Food Intake Tracking", style: highlightedTextStyle,),
            TextSpan(text: " > ",),
            TextSpan(text: "Update Pending Food Record", style: highlightedTextStyle,),
            TextSpan(text: " and select the pending food intake record you wish to update.",),
          ]
        )
      ), 
    );
  }
}