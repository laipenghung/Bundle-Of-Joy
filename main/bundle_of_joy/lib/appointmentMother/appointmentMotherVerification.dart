import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'appointmentMotherMain.dart';

class AppointmentMotherVerification extends StatefulWidget {
  @override
  _AppointmentMotherVerificationState createState() => _AppointmentMotherVerificationState();
}

class _AppointmentMotherVerificationState extends State<AppointmentMotherVerification> {
  String input;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  
  Widget accountVerification(AsyncSnapshot<DocumentSnapshot> mother, CollectionReference patient, String uid) {
    if (mother.data.data()["is_verify"] == false) {
      return Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () => _pinPutFocusNode.unfocus(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03, 
                        bottom: MediaQuery.of(context).size.height * 0.033,
                      ),
                      child: Text(
                        "This feature is currently unavailable becasue your account is still not been verified. To verify your account," + 
                        " please enter the Verifaication Code that provided by the hospital.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.045,
                        bottom: MediaQuery.of(context).size.height * 0.045,
                      ),
                      child: PinPut(
                        keyboardType: TextInputType.text,
                        fieldsCount: 6,
                        eachFieldHeight: 50.0,
                        eachFieldWidth: 50.0,
                        onSubmit: (String pin) async {
                          Future<QuerySnapshot> pinCode = patient.where("pin_code", isEqualTo: pin).get();

                          pinCode.then((value) {
                            if(value.size == 0){
                                _showDialogBox(context);
                            } else {
                              CollectionReference users = FirebaseFirestore.instance.collection("mother");
                              users
                                  .doc(uid)
                                  .update({"pin_code": pin.toString(), "is_verify": true})
                                  .then((value) => print("Mother profile updated"))
                                  .catchError((e) => print("Failed to update mother profile: $e"));

                              patient
                                  .doc(value.docs.first.data()["patient_id"])
                                  .update({"m_id": uid})
                                  .then((value) => print("Patient updated"))
                                  .catchError((e) => print("Failed to update patient: $e"));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentMotherMain(),
                                ),
                              );
                            }
                          });
                        },
                        focusNode: _pinPutFocusNode,
                        controller: _pinPutController,
                        submittedFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        selectedFieldDecoration: _pinPutDecoration,
                        followingFieldDecoration: _pinPutDecoration.copyWith(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                    Container(
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          textColor: Colors.black.withOpacity(0.6),
                          onPressed: () => _pinPutFocusNode.requestFocus(),
                          child: Text(
                            "Focus",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          textColor: Colors.black.withOpacity(0.6),
                          onPressed: () {
                            _pinPutController.clear();
                            _pinPutFocusNode.unfocus();
                          },
                          child: Text(
                            "Reset",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            _pinPutController.clear();
                            Navigator.of(context).pop();
                            //_pinPutFocusNode.unfocus();
                          },
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.045,
                            ),
                          ), 
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      Future<QuerySnapshot> mother = patient.where("m_id", isEqualTo: uid).get();
      mother.then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentMotherMain(),
          ),
        );
      });
      return loadingWidget();
    }
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.red.withOpacity(0.8)),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  _showDialogBox(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Opps!"),
          content: Text(
            "The Verification Code you entered is incorrect. Please enter the correct Verification Code next time. " +
            "If you still has trouble verify your account, try to contact the hospital that provide you Verification" +
            " Code for further assistant.",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                  setState(() {
                    _pinPutController.clear();
                    Navigator.of(context).pop();
                  });
              },
            ),
          ],
        );
      });
  }

  Widget loadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.38, bottom: 20.0),
                      child: SizedBox(
              height: MediaQuery.of(context).size.width * 0.18,
              width: MediaQuery.of(context).size.width * 0.18,
              child: CircularProgressIndicator(
                strokeWidth: 5,
                backgroundColor: Colors.black,
                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
              ),
            ),
          ),
          Text(
            "Loading..",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.collection("mother").doc(user.uid);
    CollectionReference patient = FirebaseFirestore.instance.collection("patient");
    
    return Container(
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: <Widget>[ 
            Text(
              "Account Verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ), // Your desired title      
            StreamBuilder(
              stream: users.snapshots(),
              builder: (context, mother) {
                if (mother.hasData) {
                  return accountVerification(mother, patient, user.uid.toString());
                } else {
                  return loadingWidget();
                }
            }),
          ],
        ),
      ),
    );
  }
}