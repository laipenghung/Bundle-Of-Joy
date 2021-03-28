import 'package:flutter/material.dart';

const Color appThemeColor = Color(0xFFff713a);
//const Color appThemeColor = Color(0xFFD44B87); //test color

//const Color appThemeColor = Color(0xFFf5ceb8);
const Color titleColor = Color(0xFF56453d);

const String motherRecordDateDesc = "The date you record this intake.";
const String motherRecordTimeDesc = "The time you record this intake.";
const String motherRecordListTitle = "Food";
const String motherRecordListTitleDesc = "Food that you consumed.";

const String babyFoodDateDesc = "The date you record this intake.";
const String babyFoodTimeDesc = "The time you record this intake.";
const String babyFoodRecordListTitle = "Food";
const String babyFoodRecordListTitleDesc = "Food consumed by your baby.";

const String babyMedsDateDesc = "Date you record your baby medicine intake.";
const String babyMedsTimeDesc = "Time you record your baby medicine intake.";
const String babyMedsRecordListTitle = "Medicine";
const String babyMedsRecordListTitleDesc = "Medicine consumed by your baby.";

class BloodSugarAddDoneText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "If you wish to view your Blood Sugar condition in detailed mode with BoJ Blood Sugar Analyzer™." +
                  " First, you will have to save the current food intake record. Then navigate to ",
            ),
            TextSpan(
              text: "Food Intake Tracking",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " > ",
            ),
            TextSpan(
              text: "Food Intake Record",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " and select the food intake record you wish to view.",
            ),
          ])),
    );
  }
}

class BloodSugarAddPendingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "Once you upload the current food record, you will receive a notification after " +
                  "2 hours to inform you to update the after meal Blood Sugar reading. To update it, navigate to ",
            ),
            TextSpan(
              text: "Food Intake Tracking",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " > ",
            ),
            TextSpan(
              text: "Update Pending Food Record",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " and select the pending food intake record you wish to update.",
            ),
          ])),
    );
  }
}

class BloodSugarUpdateText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "If you wish to view your Blood Sugar condition in detailed mode with BoJ Blood Sugar Analyzer™." +
                  " First, you will have to update this pending food intake record. Then navigate to ",
            ),
            TextSpan(
              text: "Food Intake Tracking",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " > ",
            ),
            TextSpan(
              text: "Food Intake Record",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " and select the food intake record you wish to view.",
            ),
          ])),
    );
  }
}

class BabyTempRecordViewText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(text: "If your baby's body temperature in the "),
            TextSpan(
              text: "After 2 hours",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " section is still higher than the body temperature reading at the ",
            ),
            TextSpan(
              text: "Before taking meds",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " section. We recommended you bring your baby to the nearest hospital or clinic for further checkup.",
            ),
          ])),
    );
  }
}

class BabyTempRecordAddText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "Once you upload the current medicine intake record, you will receive a notification after " +
                  "2 hours to inform you to update the you baby's body temperature reading after 2 hours taking the medicine. To update it, navigate to ",
            ),
            TextSpan(
              text: "Care For Baby",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " > ",
            ),
            TextSpan(
              text: "Update Pending Medicine Record",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " and select the pending medicine intake record you wish to update.",
            ),
          ])),
    );
  }
}

class SymptompAndAllergyFoundText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(text: "If your baby has shown signs of abnormal "),
            TextSpan(
              text: "Symptoms",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " or ",
            ),
            TextSpan(
              text: "Allergies",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: ". We strongly suggest you bring your baby to the nearest hospital or clinic for further checkup.",
            ),
          ])),
    );
  }
}

class BabyFoodRecrodAddText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "Once you upload the current baby food intake record, you will receive a notification after " +
                  "2 hours to inform you to update this food record on whether your baby show any signs of symptomps and allergies. To update it, navigate to ",
            ),
            TextSpan(
              text: "Care For Baby",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " > ",
            ),
            TextSpan(
              text: "Update Pending Baby Food Record",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " and select the pending baby food intake record you wish to update.",
            ),
          ])),
    );
  }
}

class BabyFoodRecrodDoneText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle normalTextStye = TextStyle(
      color: Colors.black.withOpacity(0.65),
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );
    TextStyle highlightedTextStyle = TextStyle(
      color: Colors.black.withOpacity(0.8),
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.width * 0.033,
    );

    return Container(
      width: double.infinity,
      child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "Once you upload the current baby food intake record, it will be saved on the database. " + "To view this baby food record, please navigate to ",
            ),
            TextSpan(
              text: "Care For Baby",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " > ",
            ),
            TextSpan(
              text: "Baby Food Intake Record",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " and select the baby food record you wish to view.",
            ),
          ])),
    );
  }
}
