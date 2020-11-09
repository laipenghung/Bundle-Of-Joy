import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'babyTemp_add_dateTime.dart';
import 'babyTemp_add_temp.dart';
import 'babyTemp_summary_done.dart';
import 'babyTemp_summary_pending.dart';

class BabyTempAddMeds extends StatefulWidget {
  final String selectedDate, selectedTime, selectedBabyID, meds;
  BabyTempAddMeds({Key key, this.selectedDate, this.selectedTime, this.selectedBabyID, this.meds}) : super(key: key);

  @override
  _BabyTempAddMedsState createState() => _BabyTempAddMedsState();
}

class _BabyTempAddMedsState extends State<BabyTempAddMeds> {
  String inputMeds = "";
  TextEditingController medsController = TextEditingController();
  List<dynamic> medsList = List<dynamic>();
  //var indexCount = 0;
  Map<dynamic, dynamic> medsMap = Map();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APP BAR
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Text(
            "Medicine Intake Tracking",
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
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: MediaQuery.of(context).size.width * 0.03),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Text(
                "Medicine Taken",
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
                      controller: medsController,
                      onChanged: (val) {
                        setState(() => inputMeds = val);
                      },
                      //textInputAction: TextInputAction.send,
                      decoration: new InputDecoration(
                        labelText: "Medicine name",
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
                      if (medsController.text.isEmpty) {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Opps!"),
                                content: Text("Medicine name not entered."),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            });
                      } else {
                        //createAlertDialog(context);
                        //_controllerFoodName.clear();
                        setState(() {
                          medsMap[inputMeds] = inputMeds;
                          medsList = medsMap.values.toList();
                          //indexCount++;
                          //print(medsMap);
                          //print(medsList);
                          medsController.clear();
                        });
                        //showMeds();
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              //color: Colors.blue,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.485,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                  child: ListView.builder(
                      itemCount: medsList.length,
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
                                  medsMap.remove(medsList[index]);
                                  medsList.removeAt(index);
                                  //foodQtyList.removeAt(index);
                                  //print(foodNameList);
                                  //print(foodQtyList);
                                  //print(foodMap);
                                });
                              },
                            )
                          ],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      //color: Colors.blue,
                                      child: new Text(
                                        "- ",
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.height * 0.023,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //color: Colors.lightBlue,
                                      width: MediaQuery.of(context).size.width * 0.6,
                                      child: Text(
                                        "${medsList[index]}",
                                        style: TextStyle(
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
                      if (medsMap.isEmpty) {
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Opps!"),
                                content: Text("Medicine Name not entered."),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                ],
                              );
                            });
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BabyTempAdd2(selectedDate: widget.selectedDate, selectedTime: widget.selectedTime, selectedBabyID: widget.selectedBabyID, medsMap: medsMap)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
