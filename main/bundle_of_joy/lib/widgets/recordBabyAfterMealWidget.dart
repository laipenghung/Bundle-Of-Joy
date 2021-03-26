import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordBabyAfterMealWidget extends StatelessWidget {
  final String svgSrc, symptomsAndAllergiesDesc;
  final bool symptomsAndAllergies;
  
  const RecordBabyAfterMealWidget({
    Key key,
    this.svgSrc,
    this.symptomsAndAllergiesDesc,
    this.symptomsAndAllergies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //bool test = false;
    Color conditionColor;
    String conditionText;

    if(symptomsAndAllergies == true){
      conditionColor = Colors.red;
      conditionText = "Were found";
    }else{
      conditionColor = Colors.green;
      conditionText = "Were not found";
    }

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(15, 15),
              blurRadius: 20,
              spreadRadius: 15,
              color: Color(0xFFE6E6E6),
            ),
          ],),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(svgSrc, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 8.0,),
                  child: Text(
                    "Symptoms and Allergies",
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
                "This section display if your baby show any signs of symptoms or allergies 2 hours after the meal.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0, bottom: 8.0,),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 8, bottom: 3),
                    child: Text(
                      "Signs of symptoms and allergies",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.043,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    //padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 5,),
                          padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            color: conditionColor,
                          ),
                          child: Text(
                            conditionText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "2 hours after the meal.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              fontWeight: FontWeight.bold,
                              //color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (symptomsAndAllergies == true)? SymptompAndAllergyFound(symptomsAndAllergiesDesc: symptomsAndAllergiesDesc,) : SymptompAndAllergyNotFound(),
                ],
              )
            ),
            
          ],
        ),
      ),
    );
  }
}

class SymptompAndAllergyFound extends StatelessWidget {
  final String symptomsAndAllergiesDesc;
  
  const SymptompAndAllergyFound({
    Key key,
    this.symptomsAndAllergiesDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15,),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              "Section below display the symptomps and allergies shown by your baby.",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                color: Colors.black.withOpacity(0.65),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Color(0xFFf5f5f5),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Text(
              symptomsAndAllergiesDesc,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: SymptompAndAllergyFoundText(),
          )
        ],
      ),
    );
  }
}

class SymptompAndAllergyNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15,),
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Color(0xFFf5f5f5),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 8),
              child: SvgPicture.asset("assets/icons/tick.svg", height: 18, width: 18,),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Yay, your baby did not shown any signs of symptomps and allergies 2 hour after the meal.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}