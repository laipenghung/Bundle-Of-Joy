import "package:flutter/material.dart";
import "appointmentMother_build.dart";
import "appointmentMother_1.dart";
import "appointmentMother_2.dart";

class AppointmentMother3 extends StatefulWidget {
  final String name;
  final DateTime date;

  AppointmentMother3({this.name, this.date});

  @override
  _AppointmentMother3State createState() =>
      _AppointmentMother3State(name, date);
}

class _AppointmentMother3State extends State<AppointmentMother3> {
  // VARIABLES
  final String nameFrom2;
  DateTime dateFrom2;

  _AppointmentMother3State(this.nameFrom2, this.dateFrom2);

  // MAKE THE DEFAULT DATE TODAY
  @override
  void initState() {
    super.initState();
    if (dateFrom2 == null) {
      dateFrom2 = DateTime.now();
    }
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
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
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width,
              // decoration: new BoxDecoration(color: Colors.red), // FOR DEBUGGING

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Container(
                      //color: Colors.lightBlue,
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width * 0.8,

                      child: Text(
                        nameFrom2,
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 25),
                      child: Text(
                        "${dateFrom2.day} - ${dateFrom2.month} - ${dateFrom2.year}",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.028,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: myBoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "A.M.",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    "assets/icons/am.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                        ),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: myBoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "P.M.",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Image.asset(
                                    "assets/icons/pm.png",
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 35, bottom: 10),
                      child: Text(
                        "Remaining Slot(s):",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.028,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 25),
                      child: Text(
                        "5",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.15,
                          color: Colors.black,
                        ),
                      ),
                    ),
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
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AppointmentMother2(name: nameFrom2)),
                            );
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: myBoxDecoration2(),
                            child: Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              )),

          // PAGINATION DOTS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1
              Container(
                  width: 15,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentMother1()),
                      );
                    },
                    fillColor: Color(0xFFFCFFD5),
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),
              // 2
              Container(
                  width: 15,
                  margin: EdgeInsets.only(left: 20),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppointmentMother2(
                                  name: nameFrom2,
                                )),
                      );
                    },
                    fillColor: Color(0xFFFCFFD5),
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),
              // 3
              Container(
                  width: 15,
                  margin: EdgeInsets.only(left: 20),
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.black,
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),
              // 4
              Container(
                  width: 15,
                  margin: EdgeInsets.only(left: 20),
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Color(0xFFFCFFD5),
                    shape: CircleBorder(
                        side: BorderSide(width: 1, color: Colors.black)),
                  )),
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
