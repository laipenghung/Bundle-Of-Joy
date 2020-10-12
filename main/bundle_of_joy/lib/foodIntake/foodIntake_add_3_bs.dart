import "package:flutter/material.dart";
import "foodIntake_add_2_food.dart";
import "foodIntake_summary_done.dart";
import "foodIntake_summary_pending.dart";

class FoodIntakeAdd3 extends StatefulWidget {
  final String selectedDate, selectedTime;
  final Map foodMap;
  FoodIntakeAdd3({Key key, @required this.selectedDate, this.selectedTime, this.foodMap}) : super(key: key);

  @override
  _FoodIntakeAdd3State createState() => _FoodIntakeAdd3State();
}

class _FoodIntakeAdd3State extends State<FoodIntakeAdd3> {
  String bPressureBefore = "", bPressureAfter = "";
  TextEditingController controllerBP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
            //color: Colors.lightBlue,
            height: MediaQuery.of(context).size.height * 0.52,
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
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => bPressureBefore = val);
                            },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              labelText: "Blood sugar reading",
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
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      "After eating (2 hours)",
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
                              setState(() => bPressureAfter = val);
                            },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              labelText: "Blood sugar reading",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodIntakeAdd2()),
                    );
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
                    validateInput(controllerBP.text);
                    //print(widget.foodMap);
                  },
                ),
              ],
            ),
          ),
        ],
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

  validateInput(String text) {
    if (text.isEmpty) {
      Navigator.push(
        context,
        // IF ALL FIELD IS FILLED, GO SUMMARY_DONE, ELSE GO SUMMARY_PENDING
        MaterialPageRoute(builder: (context) => FoodIntakeSummaryPending(selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime, foodMap: widget.foodMap,bPressureBefore: bPressureBefore)));
    } else {
      Navigator.push(
        context,
        // IF ALL FIELD IS FILLED, GO SUMMARY_DONE, ELSE GO SUMMARY_PENDING
        MaterialPageRoute(builder: (context) => FoodIntakeSummaryDone(selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime, foodMap: widget.foodMap, bPressureBefore: bPressureBefore, 
          bPressureAfter: bPressureAfter)));
    }
  }
}
