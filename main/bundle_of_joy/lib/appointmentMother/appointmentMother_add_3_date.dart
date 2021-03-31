import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'appointmentMother_add_4_time.dart';

class AppointmentMotherAddDate extends StatefulWidget {
  final String hospitalName, doctorName, date;
  AppointmentMotherAddDate({this.hospitalName, this.doctorName, this.date});

  @override
  _AppointmentMotherAddDateState createState() => _AppointmentMotherAddDateState(hospitalName, doctorName, date);
}

class _AppointmentMotherAddDateState extends State<AppointmentMotherAddDate> {
  final String hospitalName, doctorName, date;
  _AppointmentMotherAddDateState(this.hospitalName, this.doctorName, this.date);

  DateTime pickedDate;
  String d, m, y, dateSelected;

  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  void initState() {
    super.initState();

    // MAKE THE DEFAULT DATE TODAY
    pickedDate = DateTime.now();

    // CHANGE THE DATE TO STRING FORMAT
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
  }

  @override
  Widget build(BuildContext context) {
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

        //print(_currentDate);
        //print(dateSelected);
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

    return Scaffold(
      // APP BAR
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
      body: Column(
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
      ),
    );
  }

  _checkAppointment() async {
    final User user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    var x = await _db.collection('mother_appointment').where("m_id", isEqualTo: user.uid).where("a_date", isEqualTo: dateSelected).get();

    if (x.docs.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppointmentMotherAddTime(hospitalName: hospitalName, doctorName: doctorName, date: dateSelected)),
      );
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

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
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

        dateSelected = y + "-" + m + "-" + d;
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
