import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

import 'appointmentMother_add_3_date.dart';

class AppointmentMotherAddDoctor extends StatefulWidget {
  final String hospitalName, doctorName;
  AppointmentMotherAddDoctor({this.hospitalName, this.doctorName});

  @override
  _AppointmentMotherAddDoctorState createState() => _AppointmentMotherAddDoctorState(hospitalName, doctorName);
}

class _AppointmentMotherAddDoctorState extends State<AppointmentMotherAddDoctor> {
  final String hospitalName, doctorName;
  _AppointmentMotherAddDoctorState(this.hospitalName, this.doctorName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.02),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('doctor').where("role", isEqualTo: "doctor").snapshots(),
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
                      'There is currently no doctors available',
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppointmentMotherAddDate(
                                        hospitalName: hospitalName,
                                        doctorName: snapshot.data.documents[index]['d_name'],
                                      )),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // LEFT
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // DOCTOR PICTURE
                                        Container(
                                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                          child: Image.network(
                                            snapshot.data.documents[index]['d_pic_url'],
                                            width: MediaQuery.of(context).size.height * 0.12,
                                            height: MediaQuery.of(context).size.height * 0.12, // Icon Size
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                                    // RIGHT
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // NAME
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/identification.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_name'],
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

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Location in Hospital
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/address.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_h_location'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_tel'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Email
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/email.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_email'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                                        // Education
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                "assets/icons/student.png",
                                                height: MediaQuery.of(context).size.height * 0.03, // Icon Size
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.5,
                                              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                              child: Text(
                                                snapshot.data.documents[index]['d_education'],
                                                style: TextStyle(
                                                  fontFamily: 'Comfortaa',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: MediaQuery.of(context).size.height * 0.018,
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
          ),
        ),
      ],
    );
  }
}
