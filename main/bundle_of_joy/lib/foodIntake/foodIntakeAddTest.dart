import 'dart:developer';

import 'package:fa_stepper/fa_stepper.dart';
import 'package:flutter/material.dart';

class FoodIntakeAddTest extends StatefulWidget {
  @override
  _FoodIntakeAddTestState createState() => _FoodIntakeAddTestState();
}

class _FoodIntakeAddTestState extends State<FoodIntakeAddTest> {
  int _currentStep = 0;
  String selectedDate, selectedTime;
  DateTime pickedDate;
  TimeOfDay time;
  String d, m, y, hour, min, dateToPass, timeToPass;
  List<FAStep> stepper;

   @override
  void initState() {
    super.initState();

    pickedDate = DateTime.now();
    time = TimeOfDay.now();

    if (pickedDate.day < 10)
      d = "0${pickedDate.day}";
    else
      d = "${pickedDate.day}";

    if (pickedDate.month < 10)
      m = "0${pickedDate.month}";
    else
      m = "${pickedDate.month}";

    y = "${pickedDate.year}";

    if (time.hour < 10)
      hour = "0${time.hour}";
    else
      hour = "${time.hour}";

    if (time.minute < 10)
      min = "0${time.minute}";
    else
      min = "${time.minute}";

    dateToPass = y + "-" + m + "-" + d;
    timeToPass = hour + ":" + min;

    stepper = [
      // SELECT HOSPITAL /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      FAStep(
        title: Text(
          'Select a time',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        //isActive: true,
        //state: FAStepstate.disabled,
        content: Scrollbar(
          child: Column(
            children: <Widget>[
              Container(
                //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          child: Container(
                            //width: MediaQuery.of(context).size.width * 0.85,
                            //height: MediaQuery.of(context).size.height * 0.07,
                            //decoration: myBoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dateToPass,
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    //fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  //margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.width * 0.05),
                                  child: Image.asset(
                                    "assets/icons/calendar.png",
                                    //height: MediaQuery.of(context).size.height * 0.035,
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            pickDate();
                            print(dateToPass);
                            log("message");
                          }),
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    ];
  }

  void pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              surface: Color(int.parse("0xFFFCFFD5")),
              onSurface: Colors.black,
            ),
          ),
          child: child,
        );
      },
    );

    if (date != null) {
      setState(() {
        pickedDate = date;

        if (pickedDate.day < 10)
          d = "0${pickedDate.day}";
        else
          d = "${pickedDate.day}";

        if (pickedDate.month < 10)
          m = "0${pickedDate.month}";
        else
          m = "${pickedDate.month}";

        y = "${pickedDate.year}";

        dateToPass = y + "-" + m + "-" + d;
      });
    }
  }

  pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              surface: Color(int.parse("0xFFFCFFD5")),
              onSurface: Colors.black,
            ),
          ),
          child: child,
        );
      },
    );

    if (t != null) {
      setState(() {
        time = t;

        if (time.hour < 10)
          hour = "0${time.hour}";
        else
          hour = "${time.hour}";

        if (time.minute < 10)
          min = "0${time.minute}";
        else
          min = "${time.minute}";

        timeToPass = hour + ":" + min;
      });
    }
  }
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: Text(
          "Appointment Management",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),

        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),

        //automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: Container(
        child: FAStepper(
            steps: stepper,
            stepNumberColor: Colors.grey,
            //stepNumberColor: Color(0xFFFCFFD5),
            physics: ClampingScrollPhysics(),
            currentStep: this._currentStep,
            onStepTapped: (step) {
              setState(() {
                this._currentStep = step;
              });
              print('onStepTapped: ' + step.toString());
            },
            onStepContinue: () {
              setState(() {
                if (this._currentStep < this.stepper.length - 1) {
                  this._currentStep = this._currentStep + 1;
                } else {
                  _currentStep = 0;
                }
              });
              print('onStepContinue: ' + _currentStep.toString());
            },
            onStepCancel: () {
              setState(() {
                if (this._currentStep > 0) {
                  this._currentStep = this._currentStep - 1;
                } else {
                  this._currentStep = 0;
                }
              });
              print('onStepCancel: ' + _currentStep.toString());
            }),
      ),
    );
  }
}