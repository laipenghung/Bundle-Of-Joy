import 'package:fa_stepper/fa_stepper.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "appointmentMother_add_hospital.dart";
import "appointmentMother_add_doctor.dart";
import "appointmentMother_add_date.dart";

class AppointmentMotherAddFull extends StatefulWidget {
  final String name;

  AppointmentMotherAddFull({this.name});

  @override
  _AppointmentMotherAddFullState createState() => _AppointmentMotherAddFullState(name);
}

class _AppointmentMotherAddFullState extends State<AppointmentMotherAddFull> {
  final String name;
  final User user = FirebaseAuth.instance.currentUser;
  _AppointmentMotherAddFullState(this.name);

  int _currentStep = 0;

  List<FAStep> _stepper = [
    // SELECT HOSPITAL /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    FAStep(
      title: Text(
        'Select a hospital',
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
        child: Container(
          height: 350,
          //color: Colors.blue,
          child: AppointmentMotherAddHospital(),
        ),
      ),
    ),

    // SELECT DOCTOR /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    FAStep(
      title: Text(
        'Select a doctor',
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
        child: Container(
          height: 350,
          //color: Colors.blue,
          child: AppointmentMotherAddDoctor(),
        ),
      ),
    ),

    // SELECT DATE /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    FAStep(
      title: Text(
        'Select a date',
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
      //isActive: true,
      //state: FAStepstate.disabled,
      content: Container(
        //color: Colors.blue,
        child: AppointmentMotherAddDate(),
      ),
    ),

    // SELECT TIME /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    FAStep(
        title: Text('Select a time'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
            )
          ],
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Text(
          "Appointment Management",
          style: TextStyle(
            fontFamily: 'Comfortaa',
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
            steps: _stepper,
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
                if (this._currentStep < this._stepper.length - 1) {
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
