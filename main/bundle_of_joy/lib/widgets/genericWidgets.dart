import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

const Color background1 = Color(0xFFf4c2c2);
const Color background2 = Color(0xFF89cff0);
const Color background3 = Color(0xFFF5CEB8);
const Color appbar1 = Color(0xFFf5bab8);
const Color appbar2 = Color(0xFFf5bab8);
const Color appbar3 = Color(0xFFf5bab8);

const Color titleColor = Color(0xFF56453d);

//const Color appThemeColor = Color(0xFF89cff0);
//const Color appThemeColor = Color(0xFF55cbcd);
//const Color appThemeColor = Color(0xFF9ec4c5);
//const Color appThemeColor = Color(0xFFD44B87);
//const Color appThemeColor = Color(0xFFf5ceb8);

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
      margin: EdgeInsets.only(top: 15),
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
      //margin: EdgeInsets.only(top: 15),
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

class BabyGrowthHeightText extends StatelessWidget {
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
      margin: EdgeInsets.only(top: 15),
      child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "Your baby's height record will automatically added to your account once the doctor update your baby's growth record. ",
            ),
            TextSpan(
              text: "If the record still not show up after doctor update the record. We recommend you to refresh this page by pressing ",
            ),
            TextSpan(
              text: "Back",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " then open ",
            ),
            TextSpan(
              text: "Baby Height Tracking",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " again to refresh it.",
            ),
          ])),
    );
  }
}

class BabyGrowthWeightText extends StatelessWidget {
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
      margin: EdgeInsets.only(top: 15),
      child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(style: normalTextStye, children: <TextSpan>[
            TextSpan(
              text: "Your baby's weight record will automatically added to your account once the doctor update your baby's growth record. ",
            ),
            TextSpan(
              text: "If the record still not show up after doctor update the record. We recommend you to refresh this page by pressing ",
            ),
            TextSpan(
              text: "Back",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " then open ",
            ),
            TextSpan(
              text: "Baby Weight Tracking",
              style: highlightedTextStyle,
            ),
            TextSpan(
              text: " again to refresh it.",
            ),
          ])),
    );
  }
}

class WidgetTitle extends StatelessWidget {
  final String title;
  const WidgetTitle({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 18.0,
        left: 13.0,
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ModalSheetText extends StatelessWidget {
  final String title, desc;
  const ModalSheetText({Key key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 5),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Text(
            desc,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035, color: Colors.black.withOpacity(0.65)),
          ),
        ),
      ],
    );
  }
}

class InsightWidgetsTitle extends StatelessWidget {
  final String svgSrc, title, desc;
  InsightWidgetsTitle({
    @required this.svgSrc, @required this.title, @required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(svgSrc, height: 23, width: 23,),
            Container(
              padding: EdgeInsets.only(left: 10.0,),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 8.0,),
          child: Text(
            desc,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
      ],
    );
  }
}

class InsightNotEnoughRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Color(0xFFf5f5f5),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.red.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 8),
                child: SvgPicture.asset(
                  "assets/icons/warning.svg",
                  height: 25,
                  width: 25,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Looks like you don't have enough records. BoJ Insight™ requried at least 2 record to works.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
