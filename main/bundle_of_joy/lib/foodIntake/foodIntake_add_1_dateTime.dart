import "package:flutter/material.dart";
import "foodIntake_main.dart";
import "foodIntake_add_2_food.dart";

class FoodIntakeAdd1 extends StatefulWidget {
  @override
  _FoodIntakeAdd1State createState() => _FoodIntakeAdd1State();
}

class _FoodIntakeAdd1State extends State<FoodIntakeAdd1> {
  // Variables
  DateTime pickedDate;
  TimeOfDay time;

  // MAKE THE DEFAULT DATE TODAY
  @override
  void initState() {
    super.initState();

    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: Text(
          "Food Intake Tracking",
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
        children: [
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
            //color: Colors.lightBlue,
            height: MediaQuery.of(context).size.height * 0.52,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
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
                              print("${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}");
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07, left: MediaQuery.of(context).size.width * 0.03),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Text(
                      "Select a time",
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.07,
                              decoration: myBoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${time.hour} : ${time.minute}",
                                    style: TextStyle(
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.height * 0.025,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                                    child: Image.asset(
                                      "assets/icons/time.png",
                                      height: MediaQuery.of(context).size.height * 0.035,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        _pickTime();
                        print("${time.hour} : ${time.minute}");
                      }),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: myBoxDecoration(),
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
                      MaterialPageRoute(builder: (context) => FoodIntakeMain()),
                    );
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: myBoxDecoration(),
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
                    var selectedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    var selectedTime = "${time.hour}:${time.minute}";
                    print(selectedDate +"   "+ selectedTime);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodIntakeAdd2(selectedDate:selectedDate, selectedTime:selectedTime)),
                    );
                  },
                ),
              ],
            ),
          ),
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
      borderRadius: BorderRadius.all(Radius.circular(30.0) //<--- border radius here
          ),
    );
  }

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
              surface:  Color(int.parse("0xFFFCFFD5")),
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
      });
    }
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              surface:  Color(int.parse("0xFFFCFFD5")),
              onSurface: Colors.black,
            ),
          ),
          child: child,
        );
      },
    );

    if (t != null) {
      setState(() {
        time = t;
      });
    }
  }
}
