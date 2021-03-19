import "package:flutter/material.dart";
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import "package:cloud_firestore/cloud_firestore.dart";
// import "package:firebase_auth/firebase_auth.dart";

class AppointmentMotherAddDate extends StatefulWidget {
  /*
  final String name;
  AppointmentMotherAddHospital({this.name});

  @override
  _AppointmentMotherAddHospitalState createState() => _AppointmentMotherAddHospitalState(name);
  */

  _AppointmentMotherAddDateState createState() => _AppointmentMotherAddDateState();
}

class _AppointmentMotherAddDateState extends State<AppointmentMotherAddDate> {
  /*
  final String name;
  final User user = FirebaseAuth.instance.currentUser;
  _AppointmentMotherAddHospitalState(this.name);
  */

  _AppointmentMotherAddDateState();

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  // List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

  // EVENT ICON
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(1000)), border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  // MARKED DATE MAP
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  // CREATE CALENDARCAROUSEL
  // CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  CalendarCarousel _calendarCarouselNoHeader;

  // Add more events to _markedDateMap EventList
  @override
  void initState() {
    _markedDateMap.add(
        new DateTime(2019, 2, 25),
        new Event(
          date: new DateTime(2019, 2, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2019, 2, 10),
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2019, 2, 11), [
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2019, 2, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      // weekDays: null, /// for pass null when you do not want to render weekDays
      headerText: 'Custom Header',
      weekFormat: true,
      markedDatesMap: _markedDateMap,
      height: 200.0,
      selectedDateTime: _currentDate2,
      showIconBehindDayText: true,
      daysHaveCircularBorder: false,

      /// null for no border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.green,
      markedDateMoreShowTotal: true, // null for not showing hidden events indicator
      // markedDateIconMargin: 9,
      // markedDateIconOffset: 3,
    );
    */
    // Example with custom icon

    // Calendar Carousel
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },

      daysHaveCircularBorder: false, // RECTANGLE BORDER = FALSE // CIRCLE BORDER = TRUE
      showOnlyCurrentMonthDate: false,

      weekendTextStyle: TextStyle(color: Colors.black),

      thisMonthDayBorderColor: Colors.black,
      weekFormat: false,
      //firstDayOfWeek: 4,

      height: 300.0,

      markedDatesMap: _markedDateMap,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,

      customGridViewPhysics: NeverScrollableScrollPhysics(),

      markedDateCustomShapeBorder: CircleBorder(
        side: BorderSide(color: Colors.yellow),
      ),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),

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
      selectedDayButtonColor: Colors.blue,

      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal: true,

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

      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Column(
      children: <Widget>[
        // LEGEND
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
                  width: MediaQuery.of(context).size.height * 0.015,
                  height: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.green,
                ),
                Text(
                  "Available",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.01),
                  width: MediaQuery.of(context).size.height * 0.015,
                  height: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.red,
                ),
                Text(
                  "Full",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.01),
                  width: MediaQuery.of(context).size.height * 0.015,
                  height: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.blue,
                ),
                Text(
                  "Selected",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04, right: MediaQuery.of(context).size.width * 0.01),
                  width: MediaQuery.of(context).size.height * 0.015,
                  height: MediaQuery.of(context).size.height * 0.015,
                  color: Colors.yellow,
                ),
                Text(
                  "Today",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
        // CUSTOM HEADER
        Container(
          child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.01),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
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
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: _calendarCarouselNoHeader,
        ),
      ],
    );
  }
}
