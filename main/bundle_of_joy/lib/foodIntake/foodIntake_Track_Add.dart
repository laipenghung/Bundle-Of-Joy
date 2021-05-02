import 'dart:developer';

import 'package:bundle_of_joy/foodIntake/foodIntake_Track_Add_Summary.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class FoodIntakeTrackAdd extends StatefulWidget {
  @override
  _FoodIntakeTrackAddState createState() => _FoodIntakeTrackAddState();
}

class _FoodIntakeTrackAddState extends State<FoodIntakeTrackAdd> {
  Map foodMap = Map();
  List foodNameList = [], foodQuantityList = [], foodQuantityMeasurementList = [];
  String foodName, foodQuantity, foodQuantityMeasurement, bSugarBefore, bSugarAfter, dialogBoxContent;
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodQuantityController = TextEditingController();
  TextEditingController quantityMearsurementController = TextEditingController();
  TextEditingController bSugarBeforeController = TextEditingController();
  TextEditingController bSugarAfterController = TextEditingController();

  //Used for date section only
  DateTime pickedDate;
  String day, month, year, dateToPass, formattedDate;
  //Used for time section only
  TimeOfDay time;
  String hour, min, timeToPass, formattedTime;
  //Used for food section only
  String foodMapKey, foodWidgetTitle = "Consumed Food";
  bool editFood = false;
  int listIndex;

  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    (pickedDate.day < 10) ? day = "0${pickedDate.day}" : day = "${pickedDate.day}";
    (pickedDate.month < 10) ? month = "0${pickedDate.month}" : month = "${pickedDate.month}";
    year = "${pickedDate.year}";
    dateToPass = year + "-" + month + "-" + day;
    formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);

    time = TimeOfDay.now();
    (time.hour < 10) ? hour = "0${time.hour}" : hour = "${time.hour}";
    (time.minute < 10) ? min = "0${time.minute}" : min = "${time.minute}";
    timeToPass = hour + ":" + min;
    DateTime parsedTime = DateTime.parse(dateToPass + " " + timeToPass);
    formattedTime = DateFormat('h:mm a').format(parsedTime);
  }

  _showDialogBox(BuildContext context, dialogBoxContent) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opps!"),
            content: Text(
              dialogBoxContent,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //Date Section Widget
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
              surface: appbar1,
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
        (pickedDate.day < 10) ? day = "0${pickedDate.day}" : day = "${pickedDate.day}";
        (pickedDate.month < 10) ? month = "0${pickedDate.month}" : month = "${pickedDate.month}";
        year = "${pickedDate.year}";
        dateToPass = year + "-" + month + "-" + day;
        DateTime parsedDate = DateTime.parse(dateToPass);
        formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
      });
    }
  }

  Widget dateWidgetContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Date Selection",
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/testAM.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    "Please select a date for this food record.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    formattedDate,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.056,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        _pickDate();
                      },
                      child: Text(
                        "Pick a date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Time Section Widget
  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              surface: appbar1,
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
        (time.hour < 10) ? hour = "0${time.hour}" : hour = "${time.hour}";
        (time.minute < 10) ? min = "0${time.minute}" : min = "${time.minute}";
        timeToPass = hour + ":" + min;
        DateTime parsedTime = DateTime.parse(dateToPass + " " + timeToPass);
        formattedTime = DateFormat('h:mm a').format(parsedTime);
      });
    }
  }

  Widget timeWidgetContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Time Selection",
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Time",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    "Please select a time for this food record.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15.0),
                  child: Text(
                    formattedTime,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.056,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        _pickTime();
                      },
                      child: Text(
                        "Pick a date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Food Section Widget
  Widget foodModalBottomSheetWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              color: appbar1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.65),
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      foodWidgetTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(13),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Food Name",
                      desc: "Enter the name of the food you want to add to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: foodNameController,
                        onChanged: (val) => setState(() => foodName = val),
                        decoration: InputDecoration(
                          hintText: "Enter your food name.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Food Quantity",
                      desc: "Enter the quantity of the food you want to add to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: foodQuantityController,
                        onChanged: (val) => setState(() => foodQuantity = val),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your food quantity.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Food Quantity Measurement",
                      desc: "Enter the quantity measurement of the food.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: quantityMearsurementController,
                        onChanged: (val) => setState(() => foodQuantityMeasurement = val),
                        decoration: InputDecoration(
                          hintText: "Enter your food quantity measurement. (Optional)",
                          contentPadding: EdgeInsets.all(2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Column(children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      textColor: Colors.black.withOpacity(0.65),
                      onPressed: () {
                        foodNameController.clear();
                        foodQuantityController.clear();
                        quantityMearsurementController.clear();
                      },
                      child: Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        if (editFood == false) {
                          if (foodNameController.text.isNotEmpty && foodQuantityController.text.isNotEmpty && quantityMearsurementController.text.isNotEmpty) {
                            setState(() {
                              foodMap[foodName] = foodQuantity + " " + foodQuantityMeasurement;
                              foodNameList.add(foodName);
                              foodQuantityList.add(foodQuantity);
                              foodQuantityMeasurementList.add(foodQuantityMeasurement);
                              log(foodMap.toString());
                            });
                            foodNameController.clear();
                            foodQuantityController.clear();
                            quantityMearsurementController.clear();
                            Navigator.of(context).pop();
                          } else if (foodNameController.text.isNotEmpty && foodQuantityController.text.isNotEmpty && quantityMearsurementController.text.isEmpty) {
                            setState(() {
                              foodQuantityMeasurement = "";
                              foodMap[foodName] = foodQuantity + " " + foodQuantityMeasurement;
                              foodNameList.add(foodName);
                              foodQuantityList.add(foodQuantity);
                              foodQuantityMeasurementList.add(foodQuantityMeasurement);
                              log(foodMap.toString());
                            });
                            foodNameController.clear();
                            foodQuantityController.clear();
                            quantityMearsurementController.clear();
                            Navigator.of(context).pop();
                          } else {
                            dialogBoxContent = "Please make sure you entered all of the field." + " All of the field cannot be left empty.";
                            _showDialogBox(context, dialogBoxContent);
                          }
                        } else {
                          if (foodNameController.text.isNotEmpty && foodQuantityController.text.isNotEmpty && quantityMearsurementController.text.isNotEmpty) {
                            setState(() {
                              foodMap.remove(foodMapKey);
                              foodMap[foodName] = foodQuantity + " " + foodQuantityMeasurement;
                              foodNameList[listIndex] = foodName;
                              foodQuantityList[listIndex] = foodQuantity;
                              foodQuantityMeasurementList[listIndex] = foodQuantityMeasurement;
                              foodNameController.clear();
                              foodQuantityController.clear();
                              quantityMearsurementController.clear();
                              foodWidgetTitle = "Consumed Food";
                              editFood = false;
                              listIndex = null;
                              foodMapKey = null;
                              log(foodMap.toString());
                              Navigator.of(context).pop();
                            });
                          }
                        }
                      },
                      child: Text(
                        (editFood == false) ? "Add" : "Update",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addEditFoodWidget() {
    return Container(
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: foodNameList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 7,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Text(
                              foodNameList[index],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "x " + foodQuantityList[index] + " " + foodQuantityMeasurementList[index],
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Center(
                            child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black.withOpacity(0.65),
                                ),
                                onPressed: () {
                                  foodWidgetTitle = "Edit Food";
                                  editFood = true;
                                  listIndex = index;
                                  foodMapKey = foodNameList[index].toString();
                                  foodNameController.text = foodNameList[index].toString();
                                  foodQuantityController.text = foodQuantityList[index].toString();
                                  quantityMearsurementController.text = foodQuantityMeasurementList[index].toString();
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                      ),
                                      isScrollControlled: true,
                                      builder: (context) => SingleChildScrollView(
                                            physics: ClampingScrollPhysics(),
                                            child: foodModalBottomSheetWidget(context),
                                          ));
                                })),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Center(
                            child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              foodMap.remove(foodNameList[index]);
                              foodNameList.removeAt(index);
                              foodQuantityList.removeAt(index);
                              foodQuantityMeasurementList.removeAt(index);
                              print(foodNameList);
                              print(foodQuantityList);
                              print(foodMap);
                            });
                          },
                        )),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Widget noFoodWidget() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Color(0xFFf5f5f5),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.red.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 8),
                child: SvgPicture.asset(
                  "assets/icons/warning.svg",
                  height: 25,
                  width: 25,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Looks like you haven't added any food. Tap on the buton below to add some food into the record.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget foodWidgetContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Consumed Food",
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/healthy-food.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Food",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    "Please enter the food that you consumed.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                (foodNameList.length != 0) ? addEditFoodWidget() : noFoodWidget(),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        foodWidgetTitle = "Consumed Food";
                        editFood = false;
                        foodNameController.clear();
                        foodQuantityController.clear();
                        quantityMearsurementController.clear();
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                            ),
                            isScrollControlled: true,
                            builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.65,
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: foodModalBottomSheetWidget(context),
                                  ),
                                ));
                      },
                      child: Text(
                        (foodNameList.length == 0) ? "Add Food" : "Add More Food",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Blood Glucose Section Widget
  Widget bloodGlucoseModalBottomSheetWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              color: appbar1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.65),
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Blood Glucose",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(13),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Blood Glucose Reading",
                      desc: "Blood glucose reading before meal.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: bSugarBeforeController,
                        onChanged: (val) => setState(() => bSugarBefore = val),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Blood glucose reading before meal.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Blood Glucose Reading",
                      desc: "Blood glucose reading 2 hour after meal.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: bSugarAfterController,
                        onChanged: (val) => setState(() => bSugarAfter = val),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Blood glucose reading 2 hour after meal.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0),
                Column(children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      textColor: Colors.black.withOpacity(0.65),
                      onPressed: () {
                        bSugarBeforeController.clear();
                        bSugarAfterController.clear();
                      },
                      child: Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        if (bSugarBeforeController.text.isNotEmpty) {
                          bSugarBeforeController.clear();
                          bSugarAfterController.clear();
                          Navigator.of(context).pop();
                        } else {
                          dialogBoxContent = "Please make sure you entered your blood glucose reading into the " + "before meal section. Only 2 hour after meal section can be left empty.";
                          _showDialogBox(context, dialogBoxContent);
                        }
                      },
                      child: Text(
                        "Add",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bloodGlucoseWidgetContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Blood Glucose",
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/blood-donation.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text(
                        "Blood Glucose Reading",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    "Your blood sugar reading before meal and 2 hours after meal. You " + "can leave the 2 hours after meal section empty if u wish to update it later.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Table(
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                width: 0.5,
                                color: Colors.black.withOpacity(0.65),
                              ),
                            )),
                            child: Column(children: [
                              Text(
                                (bSugarBefore == null || bSugarBefore == "") ? "-" : bSugarBefore + " mmol/L",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Before meal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.033,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Column(children: [
                              Text(
                                (bSugarAfter == null || bSugarAfter == "") ? "-" : bSugarAfter + " mmol/L",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "2 hours after meal",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.033,
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        if (bSugarBefore != null) {
                          bSugarBeforeController.text = bSugarBefore;
                        }
                        if (bSugarAfter != null) {
                          bSugarAfterController.text = bSugarAfter;
                        }
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                            ),
                            isScrollControlled: true,
                            builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.55,
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: bloodGlucoseModalBottomSheetWidget(context),
                                  ),
                                ));
                      },
                      child: Text(
                        (bSugarBefore == null && bSugarAfter == null) ? "Add Blood Sugar Reading" : "Edit Blood Sugar Reading",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Add Food Record",
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        backgroundColor: appbar1,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            //Date
            dateWidgetContent(context),
            //Time
            timeWidgetContent(context),
            //Food
            foodWidgetContent(context),
            //Blood Sugar
            bloodGlucoseWidgetContent(context),
            //Next Screen
            Container(
              margin: EdgeInsets.only(left: 13, right: 13, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  color: appbar1,
                  textColor: Colors.white,
                  onPressed: () {
                    //log(dateToPass); log(timeToPass); log(foodMap.toString()); log(bSugarBefore +" "+ bSugarAfter);
                    if (foodMap.isNotEmpty && bSugarBefore != null && bSugarBefore != "") {
                      if (bSugarAfter != null && bSugarAfter != "") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodIntakeTrackAddSummary(
                                    selectedDate: dateToPass,
                                    selectedTime: timeToPass,
                                    foodMap: foodMap,
                                    bSugarBefore: bSugarBefore,
                                    bSugarAfter: bSugarAfter,
                                    addFoodScreenContext: context,
                                  )),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodIntakeTrackAddSummary(
                                    selectedDate: dateToPass,
                                    selectedTime: timeToPass,
                                    foodMap: foodMap,
                                    bSugarBefore: bSugarBefore,
                                    bSugarAfter: null,
                                    addFoodScreenContext: context,
                                  )),
                        );
                      }
                    } else {
                      dialogBoxContent = "Looks like you left some section empty. " + "Please make sure u entered all the required field.";
                      _showDialogBox(context, dialogBoxContent);
                    }
                  },
                  child: Text(
                    "Review Food Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                      ],
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
