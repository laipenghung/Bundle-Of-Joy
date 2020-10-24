import "package:flutter/material.dart";
import "appointmentMother_add_1.dart";
import "appointmentMother_recordList.dart";

class AppointmentMotherMain extends StatefulWidget {
  @override
  _AppointmentMotherMainState createState() => _AppointmentMotherMainState();
}

class _AppointmentMotherMainState extends State<AppointmentMotherMain> {
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
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        //automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/appointment.png",
                          height: 90,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Upcoming Appointments",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentMotherRecordList()),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: myBoxDecoration(),
              child: InkWell(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/add.png",
                          height: 80,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Add Appointments",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppointmentMotherAdd1()),
                  );
                },
              ),
            ),
          ],
        ),
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
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }
}
