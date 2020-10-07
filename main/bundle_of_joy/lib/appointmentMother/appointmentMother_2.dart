import "package:flutter/material.dart";
import "appointMother_build.dart";
import "appointmentMother_1.dart";

class AppointmentMother2 extends StatefulWidget {
  final String name;

  AppointmentMother2(this.name);

  @override
  _AppointmentMother2State createState() => _AppointmentMother2State(name);
}

class _AppointmentMother2State extends State<AppointmentMother2> {

  // VARIABLES
  final String hospitalName;
  DateTime pickedDate;

  // MAKE THE DEFAULT DATE TODAY
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }
  
  _AppointmentMother2State(this.hospitalName);

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
                    child: Text(
                      hospitalName,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      "${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15),
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: myBoxDecoration(),
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 5),
                            child: Image.asset(
                              "assets/icons/calendar.png",
                              height: 150,
                            ),
                          ),

                          onTap: _pickDate,
                        ),
                        
                        Text(
                          "Pick A Date",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.035,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                      margin: EdgeInsets.only(top: 35),
                      decoration: myBoxDecoration2(),
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppointmentMother1()), //TO BE CHANGED TO APPOINTMOTHER3333
                      );
                    },
                  ),
                ],
              ),
            )
          ),

        // PAGINATION DOTS
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Container(
              width: 15,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentMother1(name: hospitalName)),
                  );
                },
                fillColor: Color(0xFFFCFFD5),
                shape: CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black)
                ),
              )
            ),

            Container(
              width: 15,
              margin: EdgeInsets.only(left: 20),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentMother2(hospitalName)),
                  );
                },
                fillColor: Colors.black,
                shape: CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black)
                ),
              )
            ),

            Container(
              width: 15,
              margin: EdgeInsets.only(left: 20),
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: Color(0xFFFCFFD5),
                shape: CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black)
                ),
              )
            ),

            Container(
              width: 15,
              margin: EdgeInsets.only(left: 20),
              child: RawMaterialButton(
                onPressed: () {},
                fillColor: Color(0xFFFCFFD5),
                shape: CircleBorder(
                  side: BorderSide(width: 1, color: Colors.black)
                ),
              )
            ),
          ],
        )
          
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5),
      initialDate: pickedDate,

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(primarySwatch: Colors.pink, splashColor: Colors.green),
          child: child,
        );
      },
    );

    if(date != null)
    {
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
        width: 5.0,
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
      borderRadius: BorderRadius.all(
        Radius.circular(30.0) //                 <--- border radius here
      ),
    );
  }
}
