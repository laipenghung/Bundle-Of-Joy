import 'package:bundle_of_joy/careForBaby/careForBabyFunction.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import '../main.dart';

class RecordBabyAfterMealUpdateWidget extends StatefulWidget {
  final String svgSrc, selectedBabyID, selectedDate, selectedTime;
  final Map foodMap;
  RecordBabyAfterMealUpdateWidget({Key key, this.svgSrc, this.selectedBabyID, this.selectedDate, this.selectedTime, this.foodMap}) : super(key: key);

  @override
  _RecordBabyAfterMealUpdateWidgetState createState() => _RecordBabyAfterMealUpdateWidgetState();
}

class _RecordBabyAfterMealUpdateWidgetState extends State<RecordBabyAfterMealUpdateWidget> {
  bool symptomsAndAllergies = false;
  CareForBabyFunction careForBabyFunction = CareForBabyFunction();
  RecordBabyAfterMealNotification recordBabyAfterMealNotification = RecordBabyAfterMealNotification();
  TextEditingController textFieldController = TextEditingController();
  String symptomsAndAllergiesDesc, notificationMessage;
  List<String> uploadMethodList = ["Upload it as pending record", "Upload it as complete record"];
  String warningComplete = "Your current selection is to upload the food record as complete record.";
  String warningPending = "Your current selection is to upload the food record as pending record. You are required to update the food record after 2 hours.";
  String dropdownValue = "Upload it as pending record";
  bool completeFoodRecord = false;
  int index = 0;

  _showDialogBox(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Opps!"),
          content: Text(
            "Looks like u didn't enter anyting into the symptomps or allergies section" +
            "To update your baby current food record, please make sure you enter the symptomps or " + 
            "allergies shown by your baby.",
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
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
                    SvgPicture.asset(widget.svgSrc, height: 23, width: 23,),
                    Container(
                      padding: EdgeInsets.only(left: 8.0,),
                      child: Text(
                        "Symptoms and Allergies",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(flex: 3,),
                    Container(
                      height: 20,
                      width: 60,
                      child: Switch(
                        value: symptomsAndAllergies,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            symptomsAndAllergies = value;
                            
                            //log(symptomsAndAllergiesDesc);
                            //test = symptomsAndAllergies;
                          });
                        },
                      ),
                    )
                  ],
                ),
                (symptomsAndAllergies == false)
                  ? Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            "If you want to update the after meal behavior, you can toogle switch one the top right corner. " + 
                            "You can upload the current food record as the complete record or upload it as pending record.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 5, bottom: 15, ),
                          child: Center(
                            child: Container(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                items: uploadMethodList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value;
                                    index = uploadMethodList.indexOf(value);
                                    (index == 0)? completeFoodRecord = false : completeFoodRecord = true; 
                                  });
                                },
                              ),
                            ),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5, bottom: 15),
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
                                  (completeFoodRecord == false)? warningPending : warningComplete,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.035,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        (completeFoodRecord == false)? BabyFoodRecrodAddText() : BabyFoodRecrodDoneText(),
                      ],
                    )              
                  : Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "You can enter all the symptoms or allergies that shown on your baby in the textarea provided below.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            maxLines: 7,
                            controller: textFieldController,
                            onChanged: (val) {
                              setState(() => symptomsAndAllergiesDesc = val);
                            },
                            //textInputAction: TextInputAction.send,
                            decoration: new InputDecoration(
                              hintText: "Enter the description of the symptoms or allergies that found on your baby.",
                              hintStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.65),
                                  //width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  //width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        BabyFoodRecrodDoneText(),
                      ],
                    ),
                
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 13, right: 13, bottom: 25),
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
                if(completeFoodRecord == true && symptomsAndAllergies == false){
                  notificationMessage = "Baby food record upload successfully.";
                  careForBabyFunction.uploadBabyFoodRecordDone(
                    widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, symptomsAndAllergies, null, context,
                  ).then((value) => recordBabyAfterMealNotification.showNotification(notificationMessage));
                }else if(textFieldController.text.isNotEmpty && completeFoodRecord == false && symptomsAndAllergies == true){
                  notificationMessage = "Baby food record upload successfully.";
                  careForBabyFunction.uploadBabyFoodRecordDone(
                    widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, symptomsAndAllergies, symptomsAndAllergiesDesc, context,
                  ).then((value) => recordBabyAfterMealNotification.showNotification(notificationMessage));
                }else if(textFieldController.text.isEmpty && symptomsAndAllergies == true){
                  _showDialogBox(context);
                }else if(completeFoodRecord == false && symptomsAndAllergies == false){
                  notificationMessage = "Remember to update your baby's food record after 2 hours.";
                  careForBabyFunction.uploadBabyFoodRecordPending(
                    widget.selectedBabyID, widget.selectedDate, widget.selectedTime, widget.foodMap, context
                  ).then((value) => recordBabyAfterMealNotification.showNotification(notificationMessage));
                }
              },
              child: Text(
                "Upload Record",
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
    );
  }
}

class RecordBabyAfterMealNotification{
  MyApp main = MyApp();
  
  void showNotification(String notificationMessage) async {
    await notification(notificationMessage);
  }

  Future<void> notification(notificationMessage) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'Channel Id', 'Channel title', 'channel body', priority: Priority.high, importance: Importance.max, ticker: 'test', styleInformation: BigTextStyleInformation(''),
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await main.createState().flutterLocalNotificationsPlugin.show(0, 'Baby Medicine Intake Tracking', notificationMessage, notificationDetails);
  }
}


