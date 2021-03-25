import 'dart:developer';

import 'package:bundle_of_joy/widgets/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

bool symptomsAndAllergies = false, completeFoodRecord = false;
String symptomsAndAllergiesDesc = "";
TextEditingController textFieldController = TextEditingController();

class RecordBabyAfterMealUpdateWidget extends StatefulWidget {
  final String svgSrc;
  RecordBabyAfterMealUpdateWidget({Key key, this.svgSrc,}) : super(key: key);

  @override
  _RecordBabyAfterMealUpdateWidgetState createState() => _RecordBabyAfterMealUpdateWidgetState();
}

class _RecordBabyAfterMealUpdateWidgetState extends State<RecordBabyAfterMealUpdateWidget> {
  //static bool symptomsAndAllergies = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
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
                SvgPicture.asset(widget.svgSrc, height: 23, width: 23,),
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
                Spacer(flex: 3,),
                Container(
                  height: 20,
                  width: 60,
                  child: Switch(
                    value: symptomsAndAllergies,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setState(() {
                        symptomsAndAllergies = value;
                        
                        log(symptomsAndAllergiesDesc);
                        //test = symptomsAndAllergies;
                      });
                    },
                  ),
                )
              ],
            ),
            (symptomsAndAllergies == false)? SymptomsAndAllergiesFalse() : SymptomsAndAllergiesTrue(),
          ],
        ),
      ),
    );
  }
}

class SymptomsAndAllergiesTrue extends StatefulWidget {
  @override
  _SymptomsAndAllergiesTrueState createState() => _SymptomsAndAllergiesTrueState();
}

class _SymptomsAndAllergiesTrueState extends State<SymptomsAndAllergiesTrue> {
  //TextEditingController textFieldController = TextEditingController();
  //String userInput;
  void initState(){
    super.initState();
    symptomsAndAllergiesDesc = "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "You can enter all the symptoms or allergies that shown on your baby in the textarea provided below.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: TextFormField(
            maxLines: 7,
            controller: textFieldController,
            onChanged: (val) {
              setState(() {
                symptomsAndAllergiesDesc = val;
                completeFoodRecord = false;
              });
            },
            //textInputAction: TextInputAction.send,
            decoration: new InputDecoration(
              hintText: "Enter the description of the symptoms or allergies that found on your baby.",
              hintStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.65),
                  //width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.red,
                  //width: 1,
                ),
              ),
            ),
          ),
        ),
        BabyFoodRecrodDoneText(),
      ],
    );
  }
}

class SymptomsAndAllergiesFalse extends StatefulWidget {
  @override
  _SymptomsAndAllergiesFalseState createState() => _SymptomsAndAllergiesFalseState();
}

class _SymptomsAndAllergiesFalseState extends State<SymptomsAndAllergiesFalse> {
  List<String> uploadMethodList = [
    "Upload it as pending record", 
    "Upload it as complete record"
  ];
  String warningComplete = "Your current selection is to upload the food record as complete record.";
  String warningPending = "Your current selection is to upload the food record as pending record. You are required to update the food record after 2 hours.";
  String dropdownValue = "Upload it as pending record";
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            "If you want to update the after meal behavior, you can toogle switch one the top right corner. " + 
            "You can upload the current food record as the complete record or upload it as pending record.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 5, bottom: 15, ),
          child: Center(
            child: Container(
              child: DropdownButton<String>(
                value: dropdownValue,
                items: uploadMethodList.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    symptomsAndAllergies = false;
                    dropdownValue = value;
                    index = uploadMethodList.indexOf(value);
                    (index == 0)? completeFoodRecord = false : completeFoodRecord = true; 
                  });
                },
              ),
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 15),
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
                child: SvgPicture.asset("assets/icons/warning.svg", height: 25, width: 25,),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  (completeFoodRecord == false)? warningPending : warningComplete,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
        (completeFoodRecord == false)? BabyFoodRecrodAddText() : BabyFoodRecrodDoneText(),
      ],
    );
  }
}


