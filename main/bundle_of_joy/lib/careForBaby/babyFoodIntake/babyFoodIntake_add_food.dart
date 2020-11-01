import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quiver/iterables.dart';

import 'babyFoodIntake_summary.dart';

class BabyFoodIntakeAdd2 extends StatefulWidget {
  final String selectedBabyID, selectedDate, selectedTime;
  BabyFoodIntakeAdd2(
      {Key key, this.selectedBabyID, this.selectedDate, this.selectedTime})
      : super(key: key);

  @override
  _BabyFoodIntakeAdd2State createState() => _BabyFoodIntakeAdd2State();
}

class _BabyFoodIntakeAdd2State extends State<BabyFoodIntakeAdd2> {
  TextEditingController _controller = TextEditingController();
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
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.055),
            //color: Colors.lightBlue,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.03),
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
                        top: MediaQuery.of(context).size.height * 0.015),
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
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 150.0,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1),
                    child: ListView.builder(
                        itemCount: foodNameList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.22,
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
                                child: Container(
                                  child: Text(
                                      "${foodNameList[index]}\nx${foodQtyList[index]}"),
                                ),
                              ),
                            ],
                          );
                        }),
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
                    //print(widget.selectedDate + "   " + widget.selectedTime);
                    //Navigator.push(
                    //context,
                    //MaterialPageRoute(
                    //builder: (context) => FoodIntakeAdd3(selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, foodMap: foodMap)),
                    //);
                    if (foodNameList.isEmpty || foodQtyList.isEmpty) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Opps!"),
                              content: Text("Empty list."),
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
                        MaterialPageRoute(
                            builder: (context) => BabyFoodIntakeSummary(
                                selectedBabyID: widget.selectedBabyID,
                                selectedDate: widget.selectedDate,
                                selectedTime: widget.selectedTime,
                                foodMap: foodMap)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
