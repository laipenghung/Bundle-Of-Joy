import "dart:async";
import "package:bundle_of_joy/appointmentBaby/appointmentBaby_main.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/services.dart";
import "package:pinput/pin_put/pin_put.dart";

class AppointmentBabyVerify extends StatefulWidget {
  final String babyID;
  AppointmentBabyVerify({this.babyID});

  @override
  State<StatefulWidget> createState() => _AppointmentBabyVerify(babyID);
}

class _AppointmentBabyVerify extends State<AppointmentBabyVerify> {
  final String selectedBabyID;
  _AppointmentBabyVerify(this.selectedBabyID);
  String input;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  Widget is_verify(AsyncSnapshot<DocumentSnapshot> mother, CollectionReference patient, String uid){
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double paddingTop = MediaQuery.of(context).size.height * 0.03;
    if(mother.data.data()["is_verify"] == false){
      return Builder(
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: paddingTop),
                    child: Text(
                      "Please enter your verification code given by hospital.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.bold,
                        fontSize: fontSizeTitle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(20.0),
                    padding: EdgeInsets.all(20.0),
                    child: PinPut(
                      keyboardType: TextInputType.text,
                      fieldsCount: 6,
                      onSubmit: (String pin) async {
                        Future<QuerySnapshot> pin_code = patient.where("pin_code", isEqualTo: pin).get();

                        pin_code.then((value) {
                          if(value.size == 0){
                            showDialog(
                              context: context,
                              builder: (BuildContext alertContext) {
                                return noRecordFound();
                              },
                            );
                          } else {
                            CollectionReference users = FirebaseFirestore.instance.collection("mother");
                            users.doc(uid).update({
                              "pin_code": pin.toString(),
                              "is_verify": true
                            }).then((value) => print("Mother profile updated"))
                                .catchError((e) => print("Failed to update mother profile: $e"));

                            patient.doc(value.docs.first.data()["patient_id"]).update({
                              "m_id": uid
                            }).then((value) => print("Patient updated"))
                                .catchError((e) => print("Failed to update patient: $e"));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AppointmentBabyMain(babyID: selectedBabyID),
                              ),
                            );
                          }
                        });
                      },
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: Colors.deepPurpleAccent.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: buttonShape(),
                        onPressed: () => _pinPutFocusNode.requestFocus(),
                        child: Text(
                            "Focus",
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                            )
                        ),
                      ),
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: buttonShape(),
                        onPressed: () => _pinPutFocusNode.unfocus(),
                        child: Text(
                            "Unfocus",
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                      ),
                      RaisedButton(
                        color: Color(0xFFFCFFD5),
                        shape: buttonShape(),
                        onPressed: () => _pinPutController.text = "",
                        child: Text(
                            "Clear All",
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      Future<QuerySnapshot> mother = patient.where("m_id", isEqualTo: uid).get();
      mother.then((value){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentBabyMain(babyID: selectedBabyID),
          ),
        );
      });
      return loading();
    }
  }

  RoundedRectangleBorder buttonShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(width: 1, color: Colors.black)
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  AlertDialog noRecordFound() {
    Widget closeButton = FlatButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Warning!",
        style: TextStyle(
          fontFamily: "Comfortaa",
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Sorry the verification code is invalid.\nPlease check again.",
        style: TextStyle(
          fontFamily: "Comfortaa",
        ),
        textAlign: TextAlign.center,
      ),
      actionsPadding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.28),
      actions: [
        Align(
            alignment: Alignment.center,
            child: closeButton
        ),
      ],
      backgroundColor: Color(0xFFFCFFD5),
    );

    return alert;
  }

  Widget loading(){
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.15,
            width: MediaQuery.of(context).size.width * 0.15,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: Colors.black,
              valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            "Loading...",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference users = FirebaseFirestore.instance.collection("mother").doc(user.uid);
    CollectionReference patient = FirebaseFirestore.instance.collection("patient");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Verify Account",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
            stream: users.snapshots(),
            builder: (context, mother) {
              if(mother.hasData) {
                return is_verify(mother, patient, user.uid.toString());
              } else {
                return loading();
              }
            }
        ),
      ),
    );
  }
}
