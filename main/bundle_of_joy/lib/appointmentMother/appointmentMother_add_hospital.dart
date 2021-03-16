import 'package:bundle_of_joy/foodIntake/foodIntake_record_done.dart';
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
// import "package:firebase_auth/firebase_auth.dart";

class AppointmentMotherAddHospital extends StatefulWidget {
  /*
  final String name;
  AppointmentMotherAddHospital({this.name});

  @override
  _AppointmentMotherAddHospitalState createState() => _AppointmentMotherAddHospitalState(name);
  */

  _AppointmentMotherAddHospitalState createState() => _AppointmentMotherAddHospitalState();
}

class _AppointmentMotherAddHospitalState extends State<AppointmentMotherAddHospital> {
  /*
  final String name;
  final User user = FirebaseAuth.instance.currentUser;
  _AppointmentMotherAddHospitalState(this.name);
  */

  _AppointmentMotherAddHospitalState();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('hospital').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Colors.black,
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                ),
              ),
            );
          } else if (snapshot.data.documents.isEmpty) {
            return Center(
              child: Text(
                'There is currently no records',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
              child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeRecordDone(foodIntakeRecordID: snapshot.data.documents[index]["recordID"])),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.015,
                            bottom: MediaQuery.of(context).size.height * 0.015,
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Hospital Name
                                  Container(
                                    //color: Colors.lightBlue,
                                    width: MediaQuery.of(context).size.width * 0.75,
                                    child: Text(
                                      snapshot.data.documents[index]['h_name'],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                                  // Address
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/address.png",
                                          height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                        ),
                                      ),
                                      Container(
                                        //color: Colors.lightBlue,
                                        width: MediaQuery.of(context).size.width * 0.67,
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                        child: Text(
                                          snapshot.data.documents[index]['h_address'],
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                                  // Operating Hours
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/clock.png",
                                          height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                        child: Text(
                                          snapshot.data.documents[index]['h_operatingHour'],
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                                  // Phone Number
                                  Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          "assets/icons/hospitalNum.png",
                                          height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                        child: Text(
                                          snapshot.data.documents[index]['h_tel'],
                                          style: TextStyle(
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context).size.height * 0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.0,
                          endIndent: MediaQuery.of(context).size.width * 0.0,
                          color: Colors.black,
                          thickness: MediaQuery.of(context).size.height * 0.002,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        } else if (snapshot.hasError) {
          print("error");
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.15,
                width: MediaQuery.of(context).size.width * 0.15,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Colors.black,
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                'Loading...',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}