import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:bundle_of_joy/main.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'appointmentMother_main.dart';

class AppointmentMotherAdd extends StatefulWidget {
  @override
  _AppointmentMotherAddState createState() => _AppointmentMotherAddState();
}

class _AppointmentMotherAddState extends State<AppointmentMotherAdd> {
  // User
  final User user = FirebaseAuth.instance.currentUser;
  // Hospital & Doctor
  String hospitalName, doctorName, selectedHospitalID;
  // Date Picker
  DateTime today, pickedDate;
  String d, m, y, dateSelected, formattedDate;
  // Session
  String _amColor, _pmColor, _eveColor, session, selectedSession;

  @override
  void initState() {
    super.initState();

    // Hospital & Doctor Initialise
    hospitalName = "Not Selected";
    doctorName = "Not Selected";
    selectedHospitalID = "";

    // Date Initialise
    today = DateTime.now();
    pickedDate = DateTime.now();
    formattedDate = DateFormat('dd MMM yyyy').format(today); // 03 Apr 2021
    dateSelected = DateFormat('yyyy-MM-dd').format(today); // 2020-04-01

    // Session Initialise
    _amColor = "off";
    _pmColor = "off";
    _eveColor = "off";
    session = "Not Selected";
    selectedSession = "Not Selected";
  }

  Future<void> deleteSelected(appointmentID) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    return _db.collection("mother_appointment").doc(appointmentID).delete();
  }

  Future<void> updateSlotCount(slotID, sessionForThisRecord, dateForThisRecord) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    CollectionReference slotRecord = _db.collection("appointment_slot");

    return slotRecord.doc(slotID).update({
      if (sessionForThisRecord == "Morning") "s_available_Morning": FieldValue.increment(1),
      if (sessionForThisRecord == "Afternoon") "s_available_Afternoon": FieldValue.increment(1),
      if (sessionForThisRecord == "Evening") "s_available_Evening": FieldValue.increment(1),
    });
  }

  // Hospital
  Widget hospitalModalSheet(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('hospital').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.15,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        backgroundColor: Colors.black,
                        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                      ),
                    ),
                  );
                } else if (snapshot.data.documents.isEmpty) {
                  return Center(
                    child: Text(
                      'There is currently no hospital available',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              hospitalName = snapshot.data.documents[index]['h_name'];
                              selectedHospitalID = snapshot.data.documents[index]['h_id'];
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.01),
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Hospital Name
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        child: Text(
                                          snapshot.data.documents[index]['h_name'],
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.width * 0.04,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                      // Address
                                      Row(
                                        children: [
                                          Container(
                                            child: Image.asset("assets/icons/address.png", height: MediaQuery.of(context).size.height * 0.03 // Icon Size
                                                ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                            child: Text(
                                              snapshot.data.documents[index]['h_address'],
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                      // Operating Hours
                                      Row(
                                        children: [
                                          Container(
                                            child: Image.asset("assets/icons/clock.png", height: MediaQuery.of(context).size.height * 0.03 // Icon Size
                                                ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                            child: Text(
                                              snapshot.data.documents[index]['h_operatingHour'],
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                                      // Phone Number
                                      Row(
                                        children: [
                                          Container(
                                            child: Image.asset("assets/icons/hospitalNum.png", height: MediaQuery.of(context).size.height * 0.03 // Icon Size
                                                ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                            child: Text(
                                              snapshot.data.documents[index]['h_tel'],
                                              style: TextStyle(
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: MediaQuery.of(context).size.width * 0.0,
                                  endIndent: MediaQuery.of(context).size.width * 0.0,
                                  color: Colors.black,
                                  thickness: MediaQuery.of(context).size.height * 0.002,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                print("error");
              }
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
                      'Loading...',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Doctor
  Widget doctorModalSheet(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('doctor').where("specialty", whereIn: ["Gynaecology", "gynaecology"]).where("h_id", isEqualTo: selectedHospitalID).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.15,
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        backgroundColor: Colors.black,
                        valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                      ),
                    ),
                  );
                } else if (snapshot.data.documents.isEmpty) {
                  return Center(
                    child: Text(
                      'There is currently no doctors available in selected hospital',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            setState(() {
                              doctorName = snapshot.data.documents[index]['d_name'];
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // LEFT
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // DOCTOR PICTURE
                                        Container(
                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                          child: Image.network(
                                            snapshot.data.documents[index]['d_pic_url'],
                                            width: MediaQuery.of(context).size.height * 0.12,
                                            height: MediaQuery.of(context).size.height * 0.12, // Icon Size
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                                    // RIGHT
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // NAME
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/identification.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_name'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.02,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Location in Hospital
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/address.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_h_location'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Phone Number
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/hospitalNum.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_tel'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Email
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/email.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_email'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Education
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/student.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_education'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                indent: MediaQuery.of(context).size.width * 0.0,
                                endIndent: MediaQuery.of(context).size.width * 0.0,
                                color: Colors.black,
                                thickness: MediaQuery.of(context).size.height * 0.002,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                print("error");
              }
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
                      'Loading...',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Date Picker
  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              surface: appbar1,
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

        (pickedDate.day < 10) ? d = "0${pickedDate.day}" : d = "${pickedDate.day}";
        (pickedDate.month < 10) ? m = "0${pickedDate.month}" : m = "${pickedDate.month}";
        y = "${pickedDate.year}";

        dateSelected = y + "-" + m + "-" + d;

        DateTime parsedDate = DateTime.parse(dateSelected);
        formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);

        // Session Initialise
        _amColor = "off";
        _pmColor = "off";
        _eveColor = "off";
        session = "Not Selected";
        selectedSession = "Not Selected";
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
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: appbar1,
        centerTitle: true,
      ),

      // BODY
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // HOSPITAL
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/hospital.svg",
                          height: 23,
                          width: 23,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Hospital",
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
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                        hospitalName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          color: appbar1,
                          textColor: Colors.white,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.7,
                                    child: SingleChildScrollView(
                                      child: hospitalModalSheet(context),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Select a hospital",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // DOCTOR
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/doctor.svg",
                          height: 23,
                          width: 23,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Doctor",
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
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                        doctorName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          color: appbar1,
                          textColor: Colors.white,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.7,
                                    child: SingleChildScrollView(
                                      child: doctorModalSheet(context),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Select a doctor",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // DATE
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/calendar.svg",
                          height: 23,
                          width: 23,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Date",
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
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                        formattedDate,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          color: appbar1,
                          textColor: Colors.white,
                          onPressed: () {
                            _pickDate();
                          },
                          child: Text(
                            "Select a date",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Session
            SizedBox(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/clock.svg",
                          height: 23,
                          width: 23,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Session",
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
                      margin: EdgeInsets.only(top: 15.0),
                      child: Text(
                        selectedSession,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          color: appbar1,
                          textColor: Colors.white,
                          child: Text(
                            "Select a session",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                              ],
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
                                isScrollControlled: true,
                                builder: (context) {
                                  return StatefulBuilder(builder: (BuildContext context, StateSetter setModalState) {
                                    return SingleChildScrollView(
                                      physics: ClampingScrollPhysics(),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.4,
                                          child: SingleChildScrollView(
                                            child: StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection('appointment_slot').where("date_string", isEqualTo: dateSelected).where("h_id", isEqualTo: selectedHospitalID).where("s_type", whereIn: ["Gynaecology", "gynaecology"]).snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                    return Center(
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                                                        child: SizedBox(
                                                          height: MediaQuery.of(context).size.width * 0.15,
                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                          child: CircularProgressIndicator(
                                                            strokeWidth: 5,
                                                            backgroundColor: Colors.black,
                                                            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else if (snapshot.data.documents.isEmpty) {
                                                    return Center(
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
                                                        child: Text(
                                                          'There is currently no slot on this date',
                                                          style: TextStyle(
                                                            fontFamily: 'Comfortaa',
                                                            fontSize: MediaQuery.of(context).size.width * 0.04,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Column(
                                                      children: <Widget>[
                                                        Container(
                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.01),
                                                          child: Container(
                                                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                                                            child: Text(
                                                              session,
                                                              style: TextStyle(
                                                                fontFamily: 'Comfortaa',
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: MediaQuery.of(context).size.height * 0.018,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                                                          child: SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    InkWell(
                                                                      child: Container(
                                                                        width: MediaQuery.of(context).size.width * 0.15,
                                                                        height: MediaQuery.of(context).size.height * 0.06,
                                                                        decoration: myBoxDecorationAM(),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              child: Image.asset(
                                                                                "assets/icons/am.png",
                                                                                height: MediaQuery.of(context).size.height * 0.035,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      onTap: () {
                                                                        setState(() {
                                                                          _amColor = "on";
                                                                          _pmColor = "off";
                                                                          _eveColor = "off";
                                                                          session = "Morning Session";
                                                                          selectedSession = "Morning";
                                                                        });
                                                                        setModalState(() {});
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context).size.width * 0.07,
                                                                    ),
                                                                    InkWell(
                                                                      child: Container(
                                                                        width: MediaQuery.of(context).size.width * 0.15,
                                                                        height: MediaQuery.of(context).size.height * 0.06,
                                                                        decoration: myBoxDecorationPM(),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              child: Image.asset(
                                                                                "assets/icons/pm.png",
                                                                                height: MediaQuery.of(context).size.height * 0.035,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      onTap: () {
                                                                        setState(() {
                                                                          _amColor = "off";
                                                                          _pmColor = "on";
                                                                          _eveColor = "off";
                                                                          session = "Afternoon Session";
                                                                          selectedSession = "Afternoon";
                                                                        });
                                                                        setModalState(() {});
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(context).size.width * 0.07,
                                                                    ),
                                                                    InkWell(
                                                                      child: Container(
                                                                        width: MediaQuery.of(context).size.width * 0.15,
                                                                        height: MediaQuery.of(context).size.height * 0.06,
                                                                        decoration: myBoxDecorationEVE(),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              child: Image.asset(
                                                                                "assets/icons/night.png",
                                                                                height: MediaQuery.of(context).size.height * 0.030,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      onTap: () {
                                                                        setState(() {
                                                                          _amColor = "off";
                                                                          _pmColor = "off";
                                                                          _eveColor = "on";
                                                                          session = "Evening Session";
                                                                          selectedSession = "Evening";
                                                                        });
                                                                        setModalState(() {});
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02),
                                                                    child: Text(
                                                                      "Remaining Slot(s):",
                                                                      style: TextStyle(
                                                                        fontFamily: 'Comfortaa',
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: MediaQuery.of(context).size.height * 0.018,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Builder(builder: (context) {
                                                                  if (selectedSession == "Morning") {
                                                                    return Builder(builder: (context) {
                                                                      if (snapshot.data.documents[0]['s_available_Morning'] < 6) {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                                          child: Text(
                                                                            snapshot.data.documents[0]['s_available_Morning'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.1,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                                          child: Text(
                                                                            snapshot.data.documents[0]['s_available_Morning'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.1,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    });
                                                                  } else if (selectedSession == "Afternoon") {
                                                                    return Builder(builder: (context) {
                                                                      if (snapshot.data.documents[0]['s_available_Afternoon'] < 6) {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                                          child: Text(
                                                                            snapshot.data.documents[0]['s_available_Afternoon'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.1,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                                          child: Text(
                                                                            snapshot.data.documents[0]['s_available_Afternoon'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.1,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    });
                                                                  } else if (selectedSession == "Evening") {
                                                                    return Builder(builder: (context) {
                                                                      if (snapshot.data.documents[0]['s_available_Evening'] < 6) {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                                          child: Text(
                                                                            snapshot.data.documents[0]['s_available_Evening'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.1,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                                          child: Text(
                                                                            snapshot.data.documents[0]['s_available_Evening'].toString(),
                                                                            style: TextStyle(
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: MediaQuery.of(context).size.height * 0.1,
                                                                              color: Colors.black,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                    });
                                                                  } else {
                                                                    return Container(
                                                                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
                                                                      child: Text(
                                                                        "Select a \nsession first",
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          fontFamily: 'Comfortaa',
                                                                          fontWeight: FontWeight.bold,
                                                                          fontSize: MediaQuery.of(context).size.height * 0.017,
                                                                          color: Colors.black,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                }),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                } else if (snapshot.hasError) {
                                                  print("Snapshot has error");
                                                }
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
                                                        'Loading...',
                                                        style: TextStyle(
                                                          fontFamily: 'Comfortaa',
                                                          fontSize: MediaQuery.of(context).size.width * 0.04,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 15),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: appbar1,
                  textColor: Colors.white,
                  onPressed: () {
                    _checkAppointment();
                  },
                  child: Text(
                    "Make Appointment",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                      ],
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkAppointment() async {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var x = await _db.collection('mother_appointment').where("m_id", isEqualTo: user.uid).where("a_date", isEqualTo: dateSelected).where("d_name", isEqualTo: doctorName).get();
    var y = await _db.collection('appointment_slot').where('date_string', isEqualTo: dateSelected).get();
    var h = await _db.collection('hospital').where('h_name', isEqualTo: hospitalName).get();
    var d = await _db.collection('doctor').where('d_name', isEqualTo: doctorName).get();

    // Check if appointment exist on the date selected
    if (x.docs.isNotEmpty) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opps!"),
            content: Text("You already have an appointment on $dateSelected. Please select another day."),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
    // Check all field not empty
    else if (hospitalName == "Not Selected" || doctorName == "Not Selected" || selectedSession == "Not Selected") {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opps!"),
            content: Text("Please make sure all selection are completed!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
    // Check if slot is available // Morning
    else if (selectedSession == "Morning") {
      if (y.docs[0].data()["s_available_Morning"] == 0) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sorry..."),
              content: Text("There is no more slot left for the session you selected. Please select another day or session :("),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        uploadAppointment(hospitalName, doctorName, dateSelected, selectedSession, h.docs[0].data()["h_id"], d.docs[0].data()["d_id"], y.docs[0].data()["s_id"]);
      }
    }
    // Afternoon
    else if (selectedSession == "Afternoon") {
      if (y.docs[0].data()["s_available_Afternoon"] == 0) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sorry..."),
              content: Text("There is no more slot left for the session you selected. Please select another day or session. :("),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        uploadAppointment(hospitalName, doctorName, dateSelected, selectedSession, h.docs[0].data()["h_id"], d.docs[0].data()["d_id"], y.docs[0].data()["s_id"]);
      }
    }
    // Evening
    else if (selectedSession == "Evening") {
      if (y.docs[0].data()["s_available_Evening"] == 0) {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sorry..."),
              content: Text("There is no more slot left for the session you selected. Please select another day or session. :("),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      } else {
        uploadAppointment(hospitalName, doctorName, dateSelected, selectedSession, h.docs[0].data()["h_id"], d.docs[0].data()["d_id"], y.docs[0].data()["s_id"]);
      }
    }
  }

  Future<void> uploadAppointment(hospitalName, doctorName, appointmentDate, appointmentSession, hospitalID, doctorID, slotID) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final User user = FirebaseAuth.instance.currentUser;

    CollectionReference appointmentRecord = _db.collection("mother_appointment");
    CollectionReference slotRecord = _db.collection("appointment_slot");
    return appointmentRecord.add({
      "h_name": hospitalName,
      "d_name": doctorName,
      "a_date": appointmentDate,
      "a_session": appointmentSession,
      "h_id": hospitalID,
      "d_id": doctorID,
      "s_id": slotID,
      "m_id": user.uid,
      "a_status": "Pending",
    }).then((value) {
      appointmentRecord.doc(value.id).update({
        "a_id": value.id,
      }).then((value) {
        slotRecord.doc(slotID).update({
          if (appointmentSession == "Morning") "s_available_Morning": FieldValue.increment(-1),
          if (appointmentSession == "Afternoon") "s_available_Afternoon": FieldValue.increment(-1),
          if (appointmentSession == "Evening") "s_available_Evening": FieldValue.increment(-1),
        }).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppointmentMotherMain()));
        });
      });
      print("Data uploaded");
    }).catchError((error) => print("Something is wrong here"));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    );
  }

  BoxDecoration myBoxDecoration2() {
    return BoxDecoration(
      color: appbar1,
      border: Border.all(
        color: Colors.black.withOpacity(0.65),
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }

  BoxDecoration myBoxDecorationAM() {
    return BoxDecoration(
      color: _amColor == "on" ? appbar1 : Colors.white,
      border: Border.all(
        color: Colors.black.withOpacity(0.65),
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  BoxDecoration myBoxDecorationPM() {
    return BoxDecoration(
      color: _pmColor == "on" ? appbar1 : Colors.white,
      border: Border.all(
        color: Colors.black.withOpacity(0.65),
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }

  BoxDecoration myBoxDecorationEVE() {
    return BoxDecoration(
      color: _eveColor == "on" ? appbar1 : Colors.white,
      border: Border.all(
        color: Colors.black.withOpacity(0.65),
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    );
  }
}
