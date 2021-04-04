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

const String lowBloodSugar = "A reading in the “Too Low” range indicates that your blood glucose level is too low. We strongly advise you consume something that has about 15 grams(g) of carbohydrates(sugar). " +
  "Remember to wait about 15 minutes before eating any more. Be careful not to eat too much. This can cause high blood sugar and weight gain. Then, Check your blood sugar again and if you do not feel better " + 
  "in 15 minutes and your blood sugar is still lower than 3.9 mmol/L, eat another snack with 15 grams(g) of carbohydrates(sugar).";
const String excellentBloodSugar = "A reading in the “Excellent” range indicates that your blood glucose is at normal level. We still recommend you to drink lots of " +
  "water and get active by doing regular exercise to control your blood glucose.";
const String goodBloodSugar = "A reading in the “Good” range indicates that your blood glucose is at normal level. We still recommend you to drink lots of water and " +
  "get active by doing regular exercise to control your blood glucose.";
const String acceptableBloodSugar = "A reading in the “Acceptable” range indicates that your blood glucose level is quite high. We advise you to drink lots of water, cut down on carbohydrates(sugar) " + 
  "until your blood glucose level comes down (fasting is no recommended) and get active by doing regular exercise to control your blood glucose (Do not exercise when you have ketones as it can worsen the condition).";
const String poorBloodSugar = "A reading in the “Poor” range indicates that your blood glucose level is too high. We strongly advise you to drink lots of water, cut down on carbohydrates(sugar) " + 
  "until your blood glucose level comes down (fasting is no recommended), get active by doing regular exercise to control your blood glucose (Do not exercise when you have ketones as it can worsen the condition), " +
  "and continue taking your medications but consult your doctor to adjust them if the readings remain high. Ask your doctor if you need an extra dose of fast-acting insulin to help " +
  "temporarily correct high blood glucose; and how often you need it.";

const String sysNormalBloodPressure = "It seems like your blood pressure in systolic category is below 120. Your blood is at normal level. You're doing a great job, keep it up.";
const String sysEleBloodPressure = "It seems like your blood pressure in systolic category is between 120-129. We strongly suggest you to change your lifestyle and monitoring your " + 
  "blood pressure from time to time. Consult to doctor also is recommended since you can know more about your blood pressure condition.";
const String sysHyperS1BloodPressure = "It seems like your blood pressure in systolic category is between 130 to 139. We strongly suggest you pay visit to hospital or clinic and consult doctor. " + 
  "Then the doctor will recommend lifestyle changes and will consider whether you also need medication.";
const String sysHyperS2BloodPressure = "It seems like your blood pressure in systolic category is higher than 139. We advised you pay visit to hospital or clinic and consult doctor. " +
  "Then the doctor will recommend lifestyle changes and will consider starting you on medication to lower your blood pressure.";
const String sysHyperCrisisBloodPressure = "It seems like your blood pressure in systolic category is 180 or higher. If you suffered from symptoms such as hest pain, shortness of breath, " + 
  "numbness/weakness, and trouble with vision or with speaking. This is an emergency, ou must go to the hospital immediately if it's " + 
  "possible or call the emergency line and wait for help.";

const String diaNorEleBloodPressure = "It seems like your blood pressure in diastolic category is below 80. We strongly suggest you to change your lifestyle and monitoring your " + 
  "blood pressure from time to time. Consult to doctor also is recommended since you can know more about your blood pressure condition.";
const String diaHyperS1BloodPressure = "It seems like your blood pressure in diastolic category is between 80 to 89. We strongly suggest you pay visit to hospital or clinic and consult doctor. " + 
  "Then the doctor will recommend lifestyle changes and will consider whether you also need medication.";
const String diaHyperS2BloodPressure = "It seems like your blood pressure in diastolic category is higher than 89. We advised you pay visit to hospital or clinic and consult doctor." + 
  "Then the doctor will recommend lifestyle changes and will consider starting you on medication to lower your blood pressure.";
const String diaHyperCrisisBloodPressure = "It seems like your blood pressure in diastolic category is 120 or higher. If you suffered from symptoms such as hest pain, " + 
  "shortness of breath, numbness/weakness, and trouble with vision or with speaking. This is an emergency, you must go to the hospital immediately if it's possible or call the emergency line and wait for help.";

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
