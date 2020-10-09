import "package:flutter/material.dart";

class FoodIntake1 extends StatefulWidget {
  @override
  _FoodIntake1State createState() => _FoodIntake1State();
}

class _FoodIntake1State extends State<FoodIntake1> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.055,
                      decoration: myBoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${pickedDate.day} - ${pickedDate.month} - ${pickedDate.year}",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 3, left: 15),
                            child: Image.asset(
                              "assets/icons/calendar.png",
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: _pickDate,
                  ),
                ],
              ),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(
                  top: 25,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.055,
                      decoration: myBoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${time.hour} : ${time.minute}",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 3, left: 15),
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
              onTap: _pickTime,
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                "Enter the food you eat",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.055,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: TextFormField(
                      //textInputAction: TextInputAction.send,
                      decoration: new InputDecoration(
                        //hintText: 'Food name..',
                        labelText: "Enter food..",

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),

                      onSaved: (String value) {},

                      validator: (String value) {
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: myBoxDecoration(),
                    child: Center(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                "Enter the blood sugar reading",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                "Before eating",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.055,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Enter blood sugar reading..",
                        
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      onSaved: (String value) {},
                      validator: (String value) {
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: myBoxDecoration(),
                    child: Center(
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 10),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                "After eating (2 hours)",
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.055,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Enter blood sugar reading..",
                        
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      onSaved: (String value) {},
                      validator: (String value) {
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width * 0.15,
                    decoration: myBoxDecoration(),
                    child: Center(
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: myBoxDecoration2(),
                    child: Center(
                      child: Text(
                        "View Report",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
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
      borderRadius:
          BorderRadius.all(Radius.circular(10.0) //<--- border radius here
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
      borderRadius:
          BorderRadius.all(Radius.circular(30.0) //<--- border radius here
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
          data:
              ThemeData(primarySwatch: Colors.pink, splashColor: Colors.green),
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
          data:
              ThemeData(primarySwatch: Colors.pink, splashColor: Colors.green),
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
