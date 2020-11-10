import 'package:flutter/material.dart';
import 'appointmentMother_add_2.dart';

class HospitalRow extends StatelessWidget {
  final String name;
  // String imagePath;

  HospitalRow(this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentMotherAdd2(name: name)),
            );
          },
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015, left: MediaQuery.of(context).size.width * 0.07),
            //color: Colors.lightBlue,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.1),
                  child: Image.asset(
                    "assets/icons/hospital(1).png",
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //color: Colors.lightBlue,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.025),
                    Row(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/icons/hospitalNum.png",
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                          child: Text(
                            "082 - 507236",
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
        ),
        Divider(
          indent: MediaQuery.of(context).size.width * 0.03,
          endIndent: MediaQuery.of(context).size.width * 0.03,
          color: Colors.black,
          thickness: MediaQuery.of(context).size.height * 0.001,
        ),
      ],
    );
  }
}
