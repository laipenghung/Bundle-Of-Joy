import 'package:flutter/material.dart';

import 'babyTemp_add_dateTime.dart';
import 'babyTemp_summary_done.dart';
import 'babyTemp_summary_pending.dart';

class BabyTempAdd2 extends StatefulWidget {
  final String selectedDate, selectedTime, selectedBabyID, meds;
  BabyTempAdd2({Key key, this.selectedDate, this.selectedTime, this.selectedBabyID, this.meds}) : super(key: key);

  @override
  _BabyTempAdd2State createState() => _BabyTempAdd2State();
}

class _BabyTempAdd2State extends State<BabyTempAdd2> {
  String bTempBefore = "", bTempAfter = "";
  TextEditingController bTempBeforeController = TextEditingController();
  TextEditingController bTempAfterController = TextEditingController();

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

  validateInput(String bTempAfter, String bTempBefore) {
    if (bTempBefore.isEmpty) {
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
      if (bTempAfter.isEmpty) {
        Navigator.push(
            context,
            // IF ALL FIELD IS FILLED, GO SUMMARY_DONE, ELSE GO SUMMARY_PENDING
            MaterialPageRoute(builder: (context) => BabyTempSummaryPending(selectedDate: widget.selectedDate, selectedTime: widget.selectedTime,
              bTempBefore: bTempBefore, selectedBabyID: widget.selectedBabyID, meds: widget.meds,)));
      } else {
        Navigator.push(
            context,
            // IF ALL FIELD IS FILLED, GO SUMMARY_DONE, ELSE GO SUMMARY_PENDING
            MaterialPageRoute(
                builder: (context) => BabyTempSummaryDone(
                    selectedDate: widget.selectedDate,
                    selectedTime: widget.selectedTime,
                    bTempBefore: bTempBefore,
                    bTempAfter: bTempAfter,
                    selectedBabyID: widget.selectedBabyID,
                    meds: widget.meds,)));
      }
    }
  }

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
      body: Column(
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
                      "Enter the temp before",
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
                      "Before taking Meds",
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
                              controller: bTempBeforeController,
                              onChanged: (val) {
                                setState(() => bTempBefore = val);
                              },
                              keyboardType: TextInputType.number,
                              decoration: new InputDecoration(
                                labelText: "temperature",
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
                      "After taking meds",
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
                            controller: bTempAfterController,
                            onChanged: (val) {
                              setState(() => bTempAfter = val);
                            },
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              labelText: "Body temperature (Optional)",
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
                    validateInput(bTempAfterController.text, bTempBeforeController.text);
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
}
