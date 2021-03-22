import 'package:bundle_of_joy/foodIntake/foodIntakeTrackAddSummary.dart';
import "package:flutter/material.dart";
import "foodIntake_add_2_food.dart";
import "foodIntake_summary_done.dart";
import "foodIntake_summary_pending.dart";

class FoodIntakeAdd3 extends StatefulWidget {
  final String selectedDate, selectedTime;
  final Map foodMap;
  FoodIntakeAdd3({Key key, this.selectedDate, this.selectedTime, this.foodMap}) : super(key: key);

  @override
  _FoodIntakeAdd3State createState() => _FoodIntakeAdd3State();
}

class _FoodIntakeAdd3State extends State<FoodIntakeAdd3> {
  String bSugarBefore = "", bSugarAfter = "";
  TextEditingController controllerBP = TextEditingController();
  TextEditingController bSugarBeforeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Food Intake Tracking",
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

      // BODY
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
              //color: Colors.lightBlue,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Enter the blood sugar reading",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Before eating",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.055,
                            child: Form(
                              child: TextFormField(
                                controller: bSugarBeforeController,
                                onChanged: (val) {
                                  setState(() => bSugarBefore = val);
                                },
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: "Blood sugar reading (mmol/L)",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                onSaved: (String value) {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "After eating (2 hours) (Optional)",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: MediaQuery.of(context).size.height * 0.022,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.055,
                            child: TextFormField(
                              controller: controllerBP,
                              onChanged: (val) {
                                setState(() => bSugarAfter = val);
                              },
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: "Blood sugar reading (mmol/L)",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                              onSaved: (String value) {},
                              validator: (String value) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: myBoxDecoration(),
                      child: Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: myBoxDecoration(),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      validateInput(controllerBP.text, bSugarBeforeController.text);
                      //print(widget.foodMap);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0) //<--- border radius here
          ),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0) //<--- border radius here
          ),
    );
  }

  validateInput(String bsAfter, String bsBefore) {
    if (bsBefore.isEmpty) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Opps!"),
              content: Text("Please enter your Blood Sugar reading before you eat."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    } else {
      if (bsAfter.isEmpty) {
        Navigator.push(
            context,
            // IF ALL FIELD IS FILLED, GO SUMMARY_DONE, ELSE GO SUMMARY_PENDING
            MaterialPageRoute(
                //builder: (context) =>
                    //FoodIntakeSummaryPending(selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: widget.foodMap, bSugarBefore: bSugarBefore)));
                builder: (context) => FoodIntakeTrackAddSummary(
                    selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: widget.foodMap, bSugarBefore: bSugarBefore, bSugarAfter: null)));
      } else {
        Navigator.push(
            context,
            // IF ALL FIELD IS FILLED, GO SUMMARY_DONE, ELSE GO SUMMARY_PENDING
            MaterialPageRoute(
                //builder: (context) => FoodIntakeSummaryDone(
                    //selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: widget.foodMap, bSugarBefore: bSugarBefore, bSugarAfter: bSugarAfter)));
                builder: (context) => FoodIntakeTrackAddSummary(
                    selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: widget.foodMap, bSugarBefore: bSugarBefore, bSugarAfter: bSugarAfter)));
      }
    }
  }
}
