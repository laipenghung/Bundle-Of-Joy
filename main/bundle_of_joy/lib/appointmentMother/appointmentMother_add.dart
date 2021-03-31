import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:bundle_of_joy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'dart:async';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AppointmentMotherAdd extends StatefulWidget {
  @override
  _AppointmentMotherAddState createState() => _AppointmentMotherAddState();
}

class _AppointmentMotherAddState extends State<AppointmentMotherAdd> {
  String hospitalName, doctorName, formattedDate;

  MyApp main = MyApp();
  final User user = FirebaseAuth.instance.currentUser;
  DateTime today, pickedDate;
  String d, m, y, dateSelected;
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  void initState() {
    super.initState();

    today = DateTime.now();

    if (today.day < 10)
      d = "0${today.day}";
    else
      d = "${today.day}";

    if (today.month < 10)
      m = "0${today.month}";
    else
      m = "${today.month}";

    y = "${today.year}";

    dateSelected = y + "-" + m + "-" + d;

    hospitalName = "Not Selected";
    doctorName = "Not Selected";
    formattedDate = DateFormat('dd MMM yyyy').format(today);
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

  Widget doctorModalSheet(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('doctor').where("role", isEqualTo: "doctor").snapshots(),
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
                      'There is currently no doctors available',
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

  Widget dateModalSheet(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);

        pickedDate = _currentDate;

        if (pickedDate.day < 10)
          d = "0${pickedDate.day}";
        else
          d = "${pickedDate.day}";

        if (pickedDate.month < 10)
          m = "0${pickedDate.month}";
        else
          m = "${pickedDate.month}";

        y = "${pickedDate.year}";

        dateSelected = y + "-" + m + "-" + d;
      },

      height: 250,
      daysHaveCircularBorder: false, // RECTANGLE BORDER = FALSE // CIRCLE BORDER = TRUE
      showOnlyCurrentMonthDate: true,

      weekendTextStyle: TextStyle(color: Colors.black),

      thisMonthDayBorderColor: Colors.black,
      weekFormat: false,

      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,

      customGridViewPhysics: NeverScrollableScrollPhysics(),

      showHeader: false,

      todayTextStyle: TextStyle(color: Colors.black),
      todayBorderColor: Colors.black,
      todayButtonColor: Colors.yellow,

      selectedDayTextStyle: TextStyle(
        fontFamily: 'Comfortaa',
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.height * 0.02,
        color: Colors.black,
      ),
      selectedDayBorderColor: Colors.black,
      selectedDayButtonColor: Colors.blue,

      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),

      headerTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),

      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),

      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
    );

    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: Text('PREV'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month - 1);
                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          _currentMonth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    FlatButton(
                      child: Text('NEXT'),
                      onPressed: () {
                        setState(() {
                          _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month + 1);
                          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 65.0),
                child: _calendarCarouselNoHeader,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: myBoxDecoration(),
                child: Center(
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                width: MediaQuery.of(context).size.width * 0.25,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: myBoxDecoration(),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              onTap: () {
                _checkAppointment();
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR START
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
      // BODY START
      body: Column(
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
                                    child: dateModalSheet(context),
                                  ),
                                ),
                              ),
                            ),
                          );
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
        ],
      ),
    );
  }

  _checkAppointment() async {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var x = await _db.collection('mother_appointment').where("m_id", isEqualTo: user.uid).where("a_date", isEqualTo: dateSelected).get();

    if (x.docs.isEmpty) {
    } else {
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
          });
    }
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
}
