import "package:flutter/material.dart";
import "foodIntake_add_3_bs.dart";

class FoodIntakeSummaryPending extends StatefulWidget {
  final String selectedDate, selectedTime, bPressureBefore;
  final Map foodMap;
  FoodIntakeSummaryPending({Key key, @required this.selectedDate, 
    this.selectedTime, this.foodMap, this.bPressureBefore}) : super(key: key);
  @override
  _FoodIntakeSummaryPendingState createState() => _FoodIntakeSummaryPendingState();
}

class _FoodIntakeSummaryPendingState extends State<FoodIntakeSummaryPending> {
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
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
            //color: Colors.lightBlue,
            height: MediaQuery.of(context).size.height * 0.58,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icons/calendar.png",
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                        child: Text(
                          widget.selectedDate,
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icons/time.png",
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                        child: Text(
                          widget.selectedTime,
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icons/food-intake.png",
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                            child: Text(
                              "Char Siew Pau asdsadasdasdasdasds", // FOOD NAME
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                            child: Text(
                              "x 1", // QUANTITY
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/icons/blood-sugar-level.png",
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                            child: Row(
                              children: [
                                Text(
                                  "Before: ",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  widget.bPressureBefore,
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                            child: Row(
                              children: [
                                Text(
                                  "After: ",
                                  style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontWeight: FontWeight.bold,
                                    fontSize: MediaQuery.of(context).size.height * 0.025,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(
                                      //labelText: "Blood sugar reading",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      MaterialPageRoute(builder: (context) => FoodIntakeAdd3()),
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
                        "Done",
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {}, //ADD TO DATABASE
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
}
