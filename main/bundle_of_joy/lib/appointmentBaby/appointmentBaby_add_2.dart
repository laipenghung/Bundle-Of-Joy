import "package:flutter/material.dart";
import 'appointmentBaby_add_1.dart';
import 'appointmentBaby_add_3.dart';

class AppointmentBabyAdd2 extends StatefulWidget {
  final String name;
  final String babyID;

  AppointmentBabyAdd2({this.name, this.babyID});

  @override
  _AppointmentBabyAdd2State createState() => _AppointmentBabyAdd2State(name, babyID);
}

class _AppointmentBabyAdd2State extends State<AppointmentBabyAdd2> {
  // VARIABLES
  final String hospitalName;
  final String babyID;
  DateTime pickedDate;

  // MAKE THE DEFAULT DATE TODAY
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  _AppointmentBabyAdd2State(this.hospitalName, this.babyID);

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
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

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: Column(
        children: <Widget>[
          Container(
              // color: Colors.lightBlue,
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Hospital Selected",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.07,
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05),
                        decoration: myBoxDecoration(),
                        child: Center(
                          child: Text(
                            hospitalName,
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07, left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Select a date",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                height: MediaQuery.of(context).size.height * 0.07,
                                decoration: myBoxDecoration(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}",
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.height * 0.025,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.width * 0.05),
                                      child: Image.asset(
                                        "assets/icons/calendar.png",
                                        height: MediaQuery.of(context).size.height * 0.035,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                _pickDate();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: myBoxDecoration2(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentBabyAdd1(babyID: babyID)),
                  );
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: myBoxDecoration2(),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentBabyAdd3(
                              name: hospitalName,
                              date: pickedDate,
                              babyID: babyID,
                            )),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(primarySwatch: Colors.pink, splashColor: Colors.green),
          child: child,
        );
      },
    );

    if (date != null) {
      setState(() {
        pickedDate = date;
      });
    }
  }

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
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }
}