import "package:flutter/material.dart";
import "foodIntake_add_1_dateTime.dart";
import "foodIntake_add_3_bs.dart";

import 'package:quiver/iterables.dart';

class FoodIntakeAdd2 extends StatefulWidget {
  final String selectedDate, selectedTime;
  FoodIntakeAdd2({Key key, this.selectedDate, this.selectedTime}) : super(key: key);

  @override
  _FoodIntakeAdd2State createState() => _FoodIntakeAdd2State();
}

class _FoodIntakeAdd2State extends State<FoodIntakeAdd2> {
  TextEditingController _controller = TextEditingController();
  Map<dynamic, dynamic> foodMap = Map();
  String foodName = "", foodQty = "";

  List<dynamic> foodNameList = List<dynamic>();
  List<dynamic> foodQtyList = List<dynamic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
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
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.055,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          height: MediaQuery.of(context).size.height * 0.055,
                          child: TextFormField(
                            controller: _controller,
                            onChanged: (val) {
                              setState(() => foodName = val);
                            },
                            //textInputAction: TextInputAction.send,
                            decoration: new InputDecoration(
                              labelText: "Food name",
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
                        InkWell(
                          child: Container(
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
                          onTap: () {
                            createAlertDialog(context);
                            _controller.clear();
                          },
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                    child: Table(
                      //border: TableBorder.all(width: 1.0, color: Colors.black),
                      children: [
                        for(var x in zip([foodNameList, foodQtyList])) TableRow(
                          children: [
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Text(x[0].toString()+"\nx"+x[1].toString()),
                                ],
                              ) 
                            )
                          ]
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Container(
          //child: Center(
          //child: testPrint(),
          //),
          //),
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
                    print(foodMap);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodIntakeAdd1()),
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
                    //print(widget.selectedDate + "   " + widget.selectedTime);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FoodIntakeAdd3(selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: foodMap)),
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

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFCFFD5),
            title: Text("Quantity of food"),
            content: Container(
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    foodQty = val;
                    //testPrint();
                  });
                },
                //controller:
                keyboardType: TextInputType.number,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                onPressed: () {
                  setMap();
                  foodNameList = foodMap.keys.toList();
                  foodQtyList = foodMap.values.toList();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  setMap() {
    foodMap[foodName] = foodQty;
    print(foodMap);
  }

  testPrint() {
    if (foodMap.isNotEmpty) {
      int index;
      String key = foodMap.keys.elementAt(index);
      return ListTile(
        title: Text(key),
        subtitle: Text(foodMap[key]),
      );
    }
  }
}
