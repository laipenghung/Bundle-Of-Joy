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
          // Tap Functtion
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppointmentMotherAdd2(name: name)),
            );
          },

          child: Container(
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
                        name,
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
                            "Lot 18807, Block 11 Land District, Jalan Stutong, Muara Tebas, 93350 Kuching, Sarawak",
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
                            "9am - 5pm",
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
          indent: MediaQuery.of(context).size.width * 0.0,
          endIndent: MediaQuery.of(context).size.width * 0.0,
          color: Colors.black,
          thickness: MediaQuery.of(context).size.height * 0.002,
        ),
      ],
    );
  }
}
