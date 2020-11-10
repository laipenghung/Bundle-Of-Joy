import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
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
  TextEditingController _controllerFoodName = TextEditingController();
  TextEditingController _controllerFoodQty = TextEditingController();
  Map<dynamic, dynamic> foodMap = Map();
  String foodName = "", foodQty = "";

  List<dynamic> foodNameList = List<dynamic>();
  List<dynamic> foodQtyList = List<dynamic>();

  setMap() {
    foodMap[foodName] = foodQty;
    print(foodMap);
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
                controller: _controllerFoodQty,
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
                  if (_controllerFoodQty.text.isEmpty) {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Opps!"),
                            content: Text("You must enter the food quantity before add it to the list."),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          );
                        });
                  } else {
                    setMap();
                    foodNameList = foodMap.keys.toList();
                    foodQtyList = foodMap.values.toList();
                    _controllerFoodName.clear();
                    _controllerFoodQty.clear();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.055),
              //color: Colors.lightBlue,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Text(
                        "Enter the food the baby eat",
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
                              controller: _controllerFoodName,
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
                              if (_controllerFoodName.text.isEmpty) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Opps!"),
                                        content: Text("You must enter the food you consumed before add it to the list."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                createAlertDialog(context);
                                //_controllerFoodName.clear();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.blue,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
                          child: ListView.builder(
                              itemCount: foodNameList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.18,
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                      caption: "Delete",
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        setState(() {
                                          foodMap.remove(foodNameList[index]);
                                          foodNameList.removeAt(index);
                                          foodQtyList.removeAt(index);
                                          print(foodNameList);
                                          print(foodQtyList);
                                          print(foodMap);
                                        });
                                      },
                                    )
                                  ],
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        height: MediaQuery.of(context).size.width * 0.11,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              child: Text(
                                                "${foodNameList[index]}",
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: true,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              child: Text(
                                                "   x${foodQtyList[index]}",
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.025,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
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
                      print(foodMap);
                      Navigator.pop(context);
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
                      if (foodNameList.isEmpty || foodQtyList.isEmpty) {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Opps!"),
                                content: Text("Please enter at least one food with quantity specified."),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            });
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FoodIntakeAdd3(selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: foodMap)),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
