import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:age/age.dart";
import "package:intl/intl.dart";
import "baby.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

class AddBaby extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddBaby();
}

class _AddBaby extends State<AddBaby> {
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  String finalAge = "";

  @override
  Widget build(BuildContext context) {
    double longWidth = MediaQuery.of(context).size.width * 0.85;
    double shortWidth = MediaQuery.of(context).size.width * 0.4;
    double shortHeight = MediaQuery.of(context).size.height * 0.015;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Add baby",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: fontSizeTitle,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _key,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: longWidth,
                      child: FormBuilderTextField(
                        attribute: "name",
                        decoration: InputDecoration(
                            labelText: "Name*",
                            labelStyle: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: shortHeight),
                      width: longWidth,
                      child: FormBuilderTextField(
                        attribute: "registered_id",
                        decoration: InputDecoration(
                            labelText: "Baby registered ID*",
                            labelStyle: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: shortHeight),
                      width: shortWidth,
                      child: FormBuilderDropdown(
                        attribute: "gender",
                        dropdownColor: Color(0xFFFCFFD5),
                        decoration: InputDecoration(
                            labelText: "Gender*",
                            labelStyle: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                        validators: [FormBuilderValidators.required()],
                        items: ["Male", "Female"].map((gender) => DropdownMenuItem(value: gender, child: Text("$gender"))).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: shortHeight),
                      width: shortWidth,
                      child: FormBuilderDropdown(
                        attribute: "bloodType",
                        dropdownColor: Color(0xFFFCFFD5),
                        decoration: InputDecoration(
                            labelText: "Blood Type*",
                            labelStyle: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                        validators: [FormBuilderValidators.required()],
                        items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].map((bloodType) => DropdownMenuItem(value: bloodType, child: Text("$bloodType"))).toList(),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: shortHeight),
                      width: longWidth,
                      child: FormBuilderDateTimePicker(
                        lastDate: DateTime.now(),
                        onChanged: (selected){
                          if(selected != null){
                            DateTime today = DateTime.now();
                            AgeDuration age;
                            age = Age.dateDifference(fromDate: selected, toDate: today);
                            int years = age.years;
                            int months = age.months;
                            int days = age.days;
                            if(years>0){
                              finalAge = years.toString() + " years";
                            } else if(months>0){
                              finalAge = months.toString() + " months";
                            } else if (days>0){
                              finalAge = days.toString() + " days";
                            }
                          }
                        },
                        attribute: "dob",
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration: InputDecoration(
                            labelText: "Date of Birth*",
                            labelStyle: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: shortHeight),
                      width: longWidth,
                      child: FormBuilderDateTimePicker(
                        attribute: "tob",
                        inputType: InputType.time,
                        format: DateFormat("H:m"),
                        decoration: InputDecoration(
                            labelText: "Time of Birth",
                            labelStyle: TextStyle(
                              fontFamily: "Comfortaa",
                            )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, bottom: MediaQuery.of(context).size.height * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: myBoxDecoration(),
                          child: Center(
                            child: Text(
                              "Reset",
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
                          _key.currentState.reset();
                        },
                      ),
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: myBoxDecoration(),
                          child: Center(
                            child: Text(
                              "Confirm",
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
                          if (_key.currentState.saveAndValidate()) {
                            print(_key.currentState.value);
                            DateTime tob = _key.currentState.value["tob"] ?? DateTime.parse("2020-00-00 00:00:00.000");
                            Baby baby = new Baby.empty();
                            baby.addBaby(
                                _key.currentState.value["name"],
                                _key.currentState.value["registered_id"],
                                finalAge,
                                _key.currentState.value["gender"],
                                _key.currentState.value["dob"],
                                tob,
                                _key.currentState.value["bloodType"],
                                context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
      borderRadius: BorderRadius.all(Radius.circular(10.0) //<--- border radius here
          ),
    );
  }
}
