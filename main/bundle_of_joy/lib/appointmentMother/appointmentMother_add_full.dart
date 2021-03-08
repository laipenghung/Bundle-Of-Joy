import 'package:fa_stepper/fa_stepper.dart';
import "package:flutter/material.dart";
import "appointmentMother_build.dart";

class AppointmentMotherAddFull extends StatefulWidget {
  final String name;

  AppointmentMotherAddFull({this.name});

  @override
  _AppointmentMotherAddFullState createState() => _AppointmentMotherAddFullState(name);
}

class _AppointmentMotherAddFullState extends State<AppointmentMotherAddFull> {
  final String name;
  _AppointmentMotherAddFullState(this.name);

  String title = 'Stepper (Custom)';
  int _currentStep = 0;

  List<FAStep> _stepper = [
    FAStep(
        title: Text('Select a Hospital'),
        isActive: true,
        state: FAStepstate.complete,
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
    FAStep(
        title: Text('Select a Date'),
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
        FAStep(
        title: Text('Select a Session'),
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

        //automaticallyImplyLeading: false, // CENTER THE TEXT
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
            setState((){
              this._currentStep = step;
            });
            print('onStepTapped: ' + step.toString());
          },
          onStepContinue: () {
            setState((){
              if(this._currentStep < this._stepper.length - 1) {
                this._currentStep = this._currentStep + 1;
              }
              else {
                _currentStep = 0;
              }
            });
            print('onStepContinue: ' + _currentStep.toString());
          },
          onStepCancel: () {
            setState(() {
              if(this._currentStep > 0) {
                this._currentStep = this._currentStep - 1;
              }
              else {
                this._currentStep = 0; 
              }
            });
            print('onStepCancel: ' + _currentStep.toString());
          }
        ),
      ),
    );
  }
}
