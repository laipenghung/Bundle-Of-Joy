import 'package:age/age.dart';
import 'package:bundle_of_joy/appointmentBaby/appointmentBaby_verify.dart';
import 'package:bundle_of_joy/baby/addBaby.dart';
import 'package:bundle_of_joy/baby/baby.dart';
import 'package:bundle_of_joy/careForBaby/careForBaby_Main.dart';
import 'package:bundle_of_joy/vaccination/vaccination_Main.dart';
import 'package:bundle_of_joy/widgets/loadingWidget.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'growth/growth_Main.dart';
import 'widgets/cardWidget.dart';
import 'widgets/genericWidgets.dart';

class MotherForBabyHome extends StatefulWidget {
  @override
  _MotherForBabyHomeState createState() => _MotherForBabyHomeState();
}

class _MotherForBabyHomeState extends State<MotherForBabyHome> {
  final kShadowColor = Color(0xFFC7B8F5);
  String selectedBabyID = "";
  //var press;

  Widget _listView(AsyncSnapshot<QuerySnapshot> collection) {
    double width = MediaQuery.of(context).size.width * 0.7;
    double height = MediaQuery.of(context).size.height * 0.04;

    int selected_index = 0;
    String selected_babyID;
    final _listField = [
      "b_id",
      "m_id",
      "b_registered_id",
      "b_name",
      "b_dob",
      "b_place_of_birth",
      "b_gender",
      "b_age",
      "b_bloodType",
      "b_mode_of_delivery",
      "b_weight_at_birth",
      "b_length_at_birth",
      "b_head_circumference",
      "b_order"
    ];
    List<Baby> _listBaby = List<Baby>();
    Baby baby = new Baby.empty();

    if (collection.data.docs.isNotEmpty) {
      collection.data.docs.forEach((doc) {
        DateTime birthday = doc.data()["b_dob"].toDate();
        DateTime today = DateTime.now();
        AgeDuration age;
        String age_string = "";
        age = Age.dateDifference(fromDate: birthday, toDate: today, includeToDate: false);

        if (age.years != 0) {
          age_string += age.years.toString() + " years ";
        }

        if (age.months != 0) {
          age_string += age.months.toString() + " months ";
        }

        if (age.days != 0) {
          age_string += age.days.toString() + " days ";
        }

        if (age.years == 0 && age.months == 0 && age.days == 0) {
          age_string = "Today";
        }

        baby.updateAge(age_string.trim(), doc.data()["b_id"]);

        _listBaby.add(Baby(
            doc.data()[_listField[0]],
            doc.data()[_listField[1]],
            doc.data()[_listField[2]],
            doc.data()[_listField[3]],
            doc.data()[_listField[4]],
            doc.data()[_listField[5]],
            doc.data()[_listField[6]],
            doc.data()[_listField[7]],
            doc.data()[_listField[8]],
            doc.data()[_listField[9]],
            doc.data()[_listField[10]].toDouble(),
            doc.data()[_listField[11]].toDouble(),
            doc.data()[_listField[12]].toDouble(),
            doc.data()[_listField[13]].toInt()));
      });

      selected_babyID = _listBaby.first.b_id.toString();
      selectedBabyID = _listBaby.first.b_id.toString();

      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: width,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                value: selected_index == null ? "null" : _listBaby[selected_index],
                items: _listBaby.map((Baby baby) {
                  String name = baby.b_name.toString();
                  String gender = baby.b_gender.toString().toLowerCase();
                  String icon;
                  if (gender == "male") {
                    icon = "assets/icons/boy.png";
                  } else {
                    icon = "assets/icons/femenine.png";
                  }
                  return DropdownMenuItem<Baby>(
                    value: baby,
                    child: Row(
                      children: [
                        Image.asset(
                          icon,
                          height: height,
                        ),
                        Text(
                          "\t $name",
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (index) {
                  setState(() {
                    selected_index = _listBaby.indexOf(index);
                    selected_babyID = _listBaby[selected_index].b_id.toString();
                    selectedBabyID = _listBaby[selected_index].b_id.toString();
                  });
                },
              ),
            ),
          ),
        );
      });
    }
  }

  Widget hasData(AsyncSnapshot<QuerySnapshot> collection) {
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    if (collection.data.docs.isNotEmpty) {
      return Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: MediaQuery.of(context).size.height * .40,
            decoration: BoxDecoration(
              color: background2,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 52,
                      decoration: BoxDecoration(
                        color: background2,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    "Mother for Baby",
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                      ],
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.03),
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.005),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: _listView(collection),
                      ),
                      IconButton(
                        iconSize: MediaQuery.of(context).size.height * 0.05,
                        icon: Icon(Icons.add_circle),
                        tooltip: 'Add Baby',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddBaby()),
                          );
                        },
                      ),
                    ],
                  ),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CardWidget(
                          title: "Appointment Management",
                          svgSrc: "assets/icons/testAM.svg",
                          press: () {
                            showModalBottomSheet(
                                //New UI
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                ),
                                isScrollControlled: true,
                                builder: (context) => SingleChildScrollView(physics: ClampingScrollPhysics(), child: AppointmentBabyVerification(babyID: selectedBabyID)));
                          },
                        ),
                        CardWidget(
                          title: "Baby \nVaccination",
                          svgSrc: "assets/icons/vaccination.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VaccinationScheduleTrackingMain(selectedBabyID: selectedBabyID)),
                            );
                          },
                        ),
                        CardWidget(
                          title: "Baby Growth Tracking",
                          svgSrc: "assets/icons/medical-report.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VaccinationGrowthMain(selectedBabyID: selectedBabyID)),
                            );
                          },
                        ),
                        CardWidget(
                          title: "Care For \nBaby",
                          svgSrc: "assets/icons/breastfeeding.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CareForBabyMain(selectedBabyID: selectedBabyID)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    } else {
      return Center(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/baby_color.png"),
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(
                  "Seems like you don't have any baby save in your profile.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeText,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              RaisedButton(
                  child: Text(
                    'Add Baby',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizeText,
                    ),
                  ),
                  textColor: Colors.white,
                  color: appbar2,
                  elevation: 3,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddBaby()),
                    );
                  }
              ),
            ],
          ),
        ),
      );
    }
  }

  //Card view Widget
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query baby = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").orderBy("b_name");

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: StreamBuilder(
          stream: baby.snapshots(),
          builder: (context, collection) {
            if (collection.hasData) {
              return hasData(collection);
            } else {
              return LoadingWidget();
            }
          }),
    );
  }
}
