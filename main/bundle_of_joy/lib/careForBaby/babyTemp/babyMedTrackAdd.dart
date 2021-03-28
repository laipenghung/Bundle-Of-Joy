import 'dart:developer';

import 'package:bundle_of_joy/careForBaby/babyTemp/babyMedTrackAddSummary.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BabyMedTrackAdd extends StatefulWidget {
  final String selectedBabyID;
  BabyMedTrackAdd({Key key, this.selectedBabyID,}) : super(key: key);

  @override
  _BabyMedTrackAddState createState() => _BabyMedTrackAddState();
}

class _BabyMedTrackAddState extends State<BabyMedTrackAdd> {
  Map medMap = Map();
  List medNameList = [], medQuantityList = [], medQuantityMeasurementList = [];
  String medName, medQuantity, medQuantityMeasurement, bTempBefore, bTempAfter, dialogBoxContent;
  TextEditingController medNameController = TextEditingController();
  TextEditingController medQuantityController = TextEditingController();
  TextEditingController quantityMearsurementController = TextEditingController();
  TextEditingController bTempBeforeController = TextEditingController();
  TextEditingController bTempAfterController = TextEditingController();

  //Used for date section only
  DateTime pickedDate;
  String day, month, year, dateToPass, formattedDate;
  //Used for time section only
  TimeOfDay time;
  String hour, min, timeToPass, formattedTime;
  //Used for food section only
  String foodMapKey, foodWidgetTitle = "Consumed Medicine";
  bool editMed = false;
  int listIndex;

  void initState(){
    super.initState();
    pickedDate = DateTime.now();
    (pickedDate.day < 10)? day = "0${pickedDate.day}" : day = "${pickedDate.day}";
    (pickedDate.month < 10)? month = "0${pickedDate.month}" : month = "${pickedDate.month}";
    year = "${pickedDate.year}";
    dateToPass = year + "-" + month + "-" + day;
    formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);

    time = TimeOfDay.now();
    (time.hour < 10)? hour = "0${time.hour}" : hour = "${time.hour}";
    (time.minute < 10)? min = "0${time.minute}" : min = "${time.minute}";
    timeToPass = hour + ":" + min;
    DateTime parsedTime = DateTime.parse(dateToPass + " " + timeToPass);
    formattedTime =  DateFormat('h:mm a').format(parsedTime);
  }

  _showDialogBox(BuildContext context, dialogBoxContent){
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
              onPressed: (){
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
              surface: appThemeColor,
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
        (pickedDate.day < 10)? day = "0${pickedDate.day}" : day = "${pickedDate.day}";
        (pickedDate.month < 10)? month = "0${pickedDate.month}" : month = "${pickedDate.month}";
        year = "${pickedDate.year}";
        dateToPass = year + "-" + month + "-" + day;
        DateTime parsedDate = DateTime.parse(dateToPass);
        formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
      });
    }
  }

  Widget dateWidgetContent(BuildContext context){
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
                    SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                    Container(
                      padding: EdgeInsets.only(left: 8.0,),
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
                  margin: EdgeInsets.only(top: 8.0,),
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
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appThemeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        _pickDate(); 
                      },
                      child: Text(
                        "Pick A Date",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
              surface: Color(int.parse("0xFFFCFFD5")),
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
        (time.hour < 10)? hour = "0${time.hour}" : hour = "${time.hour}";
        (time.minute < 10)? min = "0${time.minute}" : min = "${time.minute}";
        timeToPass = hour + ":" + min;
        DateTime parsedTime = DateTime.parse(dateToPass + " " + timeToPass);
        formattedTime =  DateFormat('h:mm a').format(parsedTime);
      });
    }
  }

  Widget timeWidgetContent(BuildContext context){
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
                    SvgPicture.asset("assets/icons/clock.svg", height: 23, width: 23,),
                    Container(
                      padding: EdgeInsets.only(left: 8.0,),
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
                  margin: EdgeInsets.only(top: 8.0,),
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
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appThemeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        _pickTime();
                      },
                      child: Text(
                        "Pick A Time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
  Widget medicineModalBottomSheetWidget(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0), topRight:Radius.circular(10.0)),
                  color: appThemeColor,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.65), blurRadius: 2.0, spreadRadius: 0.0, offset: Offset(2.0, 0),)],
              ),   
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Spacer(flex: 2,),
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
                          icon: Icon(Icons.close, color: Colors.white,), 
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ),
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
                          title: "Medicine Name",
                          desc: "Enter the name of the medicine.",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: TextFormField(
                            controller: medNameController,
                            onChanged: (val) => setState(() => medName = val),
                            decoration: InputDecoration(
                              hintText: "Enter your food name.",
                              contentPadding: EdgeInsets.all(5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.4), width: 0.8,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.red, width: 0.8,
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
                          title: "Medicine Quantity",
                          desc: "Enter the quantity of the medicine.",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: TextFormField(
                            controller: medQuantityController,
                            onChanged: (val) => setState(() => medQuantity = val),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Enter your medicine quantity.",
                              contentPadding: EdgeInsets.all(5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.4), width: 0.8,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.red, width: 0.8,
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
                          title: "Medicine Quantity Measurement",
                          desc: "Enter the quantity measurement of the medicine.",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: TextFormField(
                            controller: quantityMearsurementController,
                            onChanged: (val) => setState(() => medQuantityMeasurement = val),
                            decoration: InputDecoration(
                              hintText: "Enter your food quantity measurement. (Optional)",
                              contentPadding: EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.4), width: 0.8,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.red, width: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                            textColor: Colors.black.withOpacity(0.65),
                            onPressed: () {
                              medNameController.clear(); medQuantityController.clear(); quantityMearsurementController.clear();
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
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            color: appThemeColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if(editMed == false){
                                if(medNameController.text.isNotEmpty && medQuantityController.text.isNotEmpty 
                                  && quantityMearsurementController.text.isNotEmpty){
                                  setState(() {
                                    medMap[medName] = medQuantity + " " + medQuantityMeasurement; 
                                    medNameList.add(medName); 
                                    medQuantityList.add(medQuantity);
                                    medQuantityMeasurementList.add(medQuantityMeasurement);
                                    log(medMap.toString());
                                  });
                                  medNameController.clear(); medQuantityController.clear(); quantityMearsurementController.clear();
                                  Navigator.of(context).pop();
                                }else{
                                  dialogBoxContent = "Please make sure you entered all of the field." + 
                                    " All of the field cannot be left empty.";
                                  _showDialogBox(context, dialogBoxContent);
                                }
                              }else{
                                if(medNameController.text.isNotEmpty && medQuantityController.text.isNotEmpty 
                                  && quantityMearsurementController.text.isNotEmpty){
                                  setState(() {
                                    medMap.remove(foodMapKey);
                                    medMap[medName] = medQuantity + " " + medQuantityMeasurement; 
                                    medNameList[listIndex] = medName;
                                    medQuantityList[listIndex] = medQuantity;
                                    medQuantityMeasurementList[listIndex] = medQuantityMeasurement;
                                    medNameController.clear(); medQuantityController.clear(); quantityMearsurementController.clear();
                                    foodWidgetTitle = "Consumed Food"; editMed = false; listIndex = null; foodMapKey = null;
                                    log(medMap.toString());
                                    Navigator.of(context).pop();
                                  });
                                }
                              }
                            },
                            child: Text(
                              (editMed == false)? "Add" : "Update",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                              ),
                            ), 
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget addEditMedicineWidget(){
    return Container(
      margin: EdgeInsets.only(top: 10.0,),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: medNameList.length,
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
                                medNameList[index],
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
                                "x " + medQuantityList[index] + " " + medQuantityMeasurementList[index],
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
                                icon: Icon(Icons.edit, color: Colors.black.withOpacity(0.65),), 
                                onPressed: () {
                                  foodWidgetTitle = "Edit Medicine";
                                  editMed = true;
                                  listIndex = index;
                                  foodMapKey = medNameList[index].toString();
                                  medNameController.text = medNameList[index].toString();
                                  medQuantityController.text = medQuantityList[index].toString();
                                  quantityMearsurementController.text = medQuantityMeasurementList[index].toString();
                                  showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                  ),
                                  isScrollControlled: true,
                                  builder: (context) => SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                        child: medicineModalBottomSheetWidget(context),
                                  ));
                                }
                              )
                            ),
                          ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Center(
                            child: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red,), 
                                onPressed: (){
                                  setState(() {
                                    medMap.remove(medNameList[index]);
                                    medNameList.removeAt(index);
                                    medQuantityList.removeAt(index);
                                    medQuantityMeasurementList.removeAt(index);
                                    print(medNameList); print(medQuantityList); print(medMap);
                                  });
                                },
                              )
                            ),
                          ),
                      ),
                    ],
                  ),
          );
        }
      )
    );
  }

  Widget noMedicineWidget(){
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
                child: SvgPicture.asset("assets/icons/warning.svg", height: 25, width: 25,),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Looks like you haven't add any medicine. Tap on the buton below to add some medicine into the record.",
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

  Widget foodWidgetContent(BuildContext context){
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Consumed Medicine",
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
              ],),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset("assets/icons/drugs.svg", height: 23, width: 23,),
                    Container(
                      padding: EdgeInsets.only(left: 8.0,),
                      child: Text(
                        "Medicine",
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
                  margin: EdgeInsets.only(top: 8.0,),
                  child: Text(
                    "Please enter the medicine that your baby consumed.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                (medNameList.length != 0)? addEditMedicineWidget() : noMedicineWidget(),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appThemeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                        ),
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                              child: medicineModalBottomSheetWidget(context),
                        ));
                      },
                      child: Text(
                        (medNameList.length == 0)? "Add Medicine" : "Add More Medicine",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
  Widget bodyTempModalBottomSheetWidget(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 3, bottom: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0), topRight:Radius.circular(10.0)),
                color: appThemeColor,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.65), blurRadius: 2.0, spreadRadius: 0.0, offset: Offset(2.0, 0),)],
              ),   
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Spacer(flex: 2,),
                  Flexible(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        "Body Temperature",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                          icon: Icon(Icons.close, color: Colors.white,), 
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ),
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
                          title: "Body Temperature Reading",
                          desc: "Body Temperature reading before medication.",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 10),
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: TextFormField(
                            controller: bTempBeforeController,
                            onChanged: (val) => setState(() => bTempBefore = val),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Body Temperature reading before medication.",
                              contentPadding: EdgeInsets.all(5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.4), width: 0.8,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.red, width: 0.8,
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
                          title: "Body Temperature Reading",
                          desc: "Body Temperature reading reading 2 hour after medication.",
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          height: MediaQuery.of(context).size.width * 0.09,
                          child: TextFormField(
                            controller: bTempAfterController,
                            onChanged: (val) => setState(() => bTempAfter = val),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Body Temperature reading reading 2 hour after medication.",
                              contentPadding: EdgeInsets.all(5),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black.withOpacity(0.4), width: 0.8,),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.red, width: 0.8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                            textColor: Colors.black.withOpacity(0.65),
                            onPressed: () {
                              bTempBeforeController.clear(); bTempAfterController.clear();
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
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            color: appThemeColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if(bTempBeforeController.text.isNotEmpty){
                                bTempBeforeController.clear(); bTempAfterController.clear(); 
                                Navigator.of(context).pop();
                              }else{
                                dialogBoxContent = "Please make sure you entered your baby body temperature reading into the " + 
                                  "before medication section. Only 2 hour after medication section can be left empty.";
                                _showDialogBox(context, dialogBoxContent);
                              }
                            },
                            child: Text(
                              "Add",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                              ),
                            ), 
                          ),
                        ),
                      ]
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget bodyTempWidgetContent(BuildContext context){
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Body Temperature",
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
                    SvgPicture.asset("assets/icons/thermometer.svg", height: 23, width: 23,),
                    Container(
                      padding: EdgeInsets.only(left: 10.0,),
                      child: Text(
                        "Body Temperature Reading",
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
                  margin: EdgeInsets.only(top: 8.0,),
                  child: Text(
                    "Your baby body temperature reading before medication and 2 hours after medication. You " +
                    "can leave the 2 hours after medication section empty if u wish to update it later.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 15.0, bottom: 5.0,),
                  child: Table(
                    //border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.only(top: 8, bottom: 8,),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    width: 0.5, 
                                    color: Colors.black.withOpacity(0.65),
                                  ),
                                )
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    (bTempBefore == null || bTempBefore == "")? "-" : bTempBefore + "°C",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "Before medication",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.033,
                                        color: Colors.black.withOpacity(0.65),
                                      ),
                                    ),
                                  ),
                                ] 
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              padding: EdgeInsets.only(top: 8, bottom: 8,),
                              child: Column(
                                children: [
                                  Text(
                                    (bTempAfter == null || bTempAfter == "")? "-" : bTempAfter + "°C",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),  
                                  Container(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "After 2 hours",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.033,
                                        color: Colors.black.withOpacity(0.65),
                                      ),
                                    ),
                                  ),
                                ] 
                              ),
                            ),
                          ),
                        ]
                      ), 
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appThemeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if(bTempBefore != null){bTempBeforeController.text = bTempBefore;}
                        if(bTempAfter != null){bTempAfterController.text = bTempAfter;}
                        showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                        ),
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                              child: bodyTempModalBottomSheetWidget(context),
                        ));
                      },
                      child: Text(
                        (bTempBefore == null && bTempAfter == null)? "Add Body Temperature Reading" : "Edit Body Temperature Reading",
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
          "Add Baby Medicine Record",
          style: TextStyle(
            color: Colors.white,
             fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),        
        backgroundColor: appThemeColor,
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
            bodyTempWidgetContent(context),
            //Next Screen
            Container(
              margin: EdgeInsets.only(left: 13, right: 13, bottom: 20),
              child: SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  color: appThemeColor,
                  textColor: Colors.white,
                  onPressed: () {
                    //log(dateToPass); log(timeToPass); log(foodMap.toString()); log(bSugarBefore +" "+ bSugarAfter);
                    if(medMap.isNotEmpty && bTempBefore != null &&  bTempBefore != ""){
                      if(bTempAfter != null && bTempAfter != ""){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BabyMedTrackAddSummary(
                            selectedDate: dateToPass, selectedTime: timeToPass, 
                              selectedBabyID: widget.selectedBabyID, medsMap: medMap, bTempBefore: bTempBefore, bTempAfter: bTempAfter,
                          )),
                        );
                      }else{
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BabyMedTrackAddSummary(
                            selectedDate: dateToPass, selectedTime: timeToPass, 
                              selectedBabyID: widget.selectedBabyID, medsMap: medMap, bTempBefore: bTempBefore, bTempAfter: null,
                          )),
                        );
                      }
                    }else{
                      dialogBoxContent = "Looks like you left some section empty. " + 
                        "Please make sure u entered all the required field.";
                      _showDialogBox(context, dialogBoxContent);
                    }
                  },
                  child: Text(
                    "Review Medicine Record",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
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