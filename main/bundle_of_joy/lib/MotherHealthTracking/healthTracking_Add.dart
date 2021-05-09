import 'dart:developer';
import 'package:bundle_of_joy/MotherHealthTracking/healthTracking_Add_Summary.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HealthTrackingAdd extends StatefulWidget {
  @override
  _HealthTrackingAddState createState() => _HealthTrackingAddState();
}

class _HealthTrackingAddState extends State<HealthTrackingAdd> {
  int bPressure_dia, bPressure_sys, dayOfPregnancy = 0;
  double bSugar, height, weight;
  String dialogBoxContent;
  TextEditingController bPressureDiaController = TextEditingController(),
      bPressureSysController = TextEditingController(),
      dayOfPregnancyController = TextEditingController(),
      bSugarController = TextEditingController(),
      heightController = TextEditingController(),
      weightController = TextEditingController();

  //Used for date section only
  DateTime pickedDate;
  String day, month, year, dateToPass, formattedDate;
  //Used for time section only
  TimeOfDay time;
  String hour, min, timeToPass, formattedTime;

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
                    "Please select a date for this health record.",
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
                    "Please select a time for this health record.",
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

  //Day of Pregnancy Section Widget
  Widget dayOfPregnancyModalBottomSheetWidget(BuildContext context) {
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
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Pregnancy Info",
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
                      title: "Day of Pregnancy *",
                      desc: "Enter your day of pregnancy to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: dayOfPregnancyController,
                        onChanged: (val) => setState(() => dayOfPregnancy = int.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your day of pregnancy.",
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
                        dayOfPregnancyController.clear();
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
                        if (dayOfPregnancyController.text.isNotEmpty && dayOfPregnancyController.text != "0") {
                          dayOfPregnancyController.clear();
                          Navigator.of(context).pop();
                        } else {
                          dialogBoxContent = "Please make sure you entered day of pregnancy.";
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

  Widget dayOfPregnancyContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Pregnancy Info",
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
                      "assets/icons/calendarPreg.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Day Of Pregnancy",
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
                    "Please entered your day of pregnancy.",
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
                  child: Text(
                    dayOfPregnancy > 0 ? dayOfPregnancy.toString() : dayOfPregnancy.toString() + " (Please change the day)",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.056,
                      fontWeight: FontWeight.bold,
                    ),
                  )
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
                        if (dayOfPregnancy > 0) {
                          dayOfPregnancyController.text = dayOfPregnancy.toString();
                        } else {
                          dayOfPregnancyController.text = "0";
                        }
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                            ),
                            isScrollControlled: true,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: dayOfPregnancyModalBottomSheetWidget(context),
                              ),
                            )
                        );
                      },
                      child: Text(
                        (dayOfPregnancy == 0) ? "Add Day of Pregnancy" : "Edit Day of Pregnancy",
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

  //Blood Pressure Section Widget
  Widget bloodPressureModalBottomSheetWidget(BuildContext context) {
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
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Blood Pressure",
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
                      title: "Systolic Blood Pressure (mm/Hg)*",
                      desc: "Enter the systolic blood pressure (usually the first number) to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: bPressureSysController,
                        onChanged: (val) => setState(() => bPressure_sys = int.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your systolic blood pressure.",
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
                      title: "Diastolic Blood Pressure (mm/Hg)*",
                      desc: "Enter the diastolic blood pressure (usually the second number) to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: bPressureDiaController,
                        onChanged: (val) => setState(() => bPressure_dia = int.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your diastolic blood pressure.",
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
                        bPressureSysController.clear();
                        bPressureDiaController.clear();
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
                        if (bPressureSysController.text.isNotEmpty && bPressureDiaController.text.isNotEmpty) {
                          bPressureSysController.clear();
                          bPressureDiaController.clear();
                          Navigator.of(context).pop();
                        } else {
                          dialogBoxContent = "Please make sure you entered your blood pressure reading.";
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

  Widget bloodPressureContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Blood Pressure",
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
                      "assets/icons/blood-pressure.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Blood Pressure Reading",
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
                    "Please entered your blood pressure reading.",
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
                                (bPressure_sys == null || bPressure_sys.isNaN) ? "-" : bPressure_sys.toString() + " mm/Hg",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Systolic Category",
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
                                (bPressure_dia == null || bPressure_dia.isNaN) ? "-" : bPressure_dia.toString() + " mm/Hg",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Diastolic Category",
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
                        if (bPressure_sys != null) {
                          bPressureSysController.text = bPressure_sys.toString();
                        }
                        if (bPressure_dia != null) {
                          bPressureDiaController.text = bPressure_dia.toString();
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
                                child: bloodPressureModalBottomSheetWidget(context),
                              ),
                            )
                        );
                      },
                      child: Text(
                        (bPressure_sys == null && bPressure_dia == null) ? "Add Blood Pressure Reading" : "Edit Blood Pressure Reading",
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

  //Blood Sugar Section Widget
  Widget bloodSugarModalBottomSheetWidget(BuildContext context) {
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
                  flex: 6,
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
                      title: "Blood Glucose Reading (mmol/L)*",
                      desc: "Enter your blood glucose reading.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: bSugarController,
                        onChanged: (val) => setState(() => bSugar = double.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your blood glucose reading.",
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
                        bSugarController.clear();
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
                        if (bSugarController.text.isNotEmpty) {
                          bSugarController.clear();
                          Navigator.of(context).pop();
                        } else {
                          dialogBoxContent = "Please make sure you entered blood glucose reading.";
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

  Widget bloodSugarContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Blood Glucose",
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
                      "assets/icons/blood-donation.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
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
                    "Please entered your blood glucose reading.",
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
                    child: Text(
                      (bSugar == null || bSugar.isNaN) ? "-" : bSugar.toString() + " mmol/L",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.056,
                        fontWeight: FontWeight.bold,
                      ),
                    )
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
                        if (bSugar != null) {
                          bSugarController.text = bSugar.toString();
                        }
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                            ),
                            isScrollControlled: true,
                            builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: bloodSugarModalBottomSheetWidget(context),
                              ),
                            )
                        );
                      },
                      child: Text(
                        (bSugar == 0) ? "Add Blood Glucose Reading" : "Edit Blood Glucose Reading",
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

  //Body Physique Section Widget
  Widget bodyPhysiqueModalBottomSheetWidget(BuildContext context) {
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
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Blood Physique",
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
                      title: "Weight (kg) *",
                      desc: "Enter your weight (kg) to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: TextFormField(
                        controller: weightController,
                        onChanged: (val) => setState(() => weight = double.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your weight (kg).",
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
                      title: "Height (cm) (optional)",
                      desc: "Enter your height (cm) to the record.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: heightController,
                        onChanged: (val) => setState(() => height = double.parse(val)),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your height (cm).",
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
                        weightController.clear();
                        heightController.clear();
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
                        if (weightController.text.isNotEmpty) {
                          weightController.clear();
                          heightController.clear();
                          Navigator.of(context).pop();
                        } else {
                          dialogBoxContent = "Please make sure you entered your weight.";
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

  Widget bodyPhysiqueContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Body Physique",
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
                      "assets/icons/body-mass-index.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Weight & Height Reading",
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
                    "Please entered your weight & height reading.",
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
                                (weight == null || weight.isNaN) ? "-" : weight.toString() + " kg",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Weight (kg)",
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
                                (height == null || height.isNaN) ? "-" : height.toString() + " cm",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  "Height (cm)",
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
                        if (weight != null) {
                          weightController.text = weight.toString();
                        }
                        if (height != null) {
                          heightController.text = height.toString();
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
                                child: bodyPhysiqueModalBottomSheetWidget(context),
                              ),
                            )
                        );
                      },
                      child: Text(
                        (weight == null) ? "Add Weight & Height Reading" : "Edit Weight & Height Reading",
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
          "Add Health Record",
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
            //Day of Pregnancy
            dayOfPregnancyContent(context),
            //Blood Pressure
            bloodPressureContent(context),
            //Blood Sugar
            bloodSugarContent(context),
            //Body Physique
            bodyPhysiqueContent(context),
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
                    if(height == null){
                      height = 0;
                    }
                    if (bPressure_sys != null && bPressure_dia != "" && weight != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HealthTrackingAddSummary(
                              selectedDate: dateToPass,
                              selectedTime: timeToPass,
                              bPressure_sys: bPressure_sys,
                              bPressure_dia: bPressure_dia,
                              weight: weight,
                              height: height,
                              dayOfPregnancy: dayOfPregnancy,
                              bSugar: bSugar,
                              addHealthScreenContext: context,
                            )
                        ),
                      );
                    } else {
                      dialogBoxContent = "Looks like you left some section empty. " + "Please make sure u entered all the required field.";
                      _showDialogBox(context, dialogBoxContent);
                    }
                  },
                  child: Text(
                    "Review Health Record",
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
