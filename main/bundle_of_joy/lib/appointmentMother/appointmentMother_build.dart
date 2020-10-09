import 'package:flutter/material.dart';
import 'appointmentMother_2.dart';

class HospitalRow extends StatelessWidget {
  final String name;
  // String imagePath;

  HospitalRow(this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        InkWell(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 30),
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://kuchingborneo.info/wp-content/uploads/2017/03/KPJ-Kuching-Medical-Centre.jpg"),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      //color: Colors.lightBlue,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.53,

                      child: Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.023,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Image.asset(
                            "assets/icons/hospitalNum.png",
                            height: 25,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            "082 - 507236",
                            style: TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppointmentMother2(
                        name: name,
                      )),
            );
          },
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Divider(
          indent: 20,
          endIndent: 20,
          color: Colors.black,
          thickness: 1,
        ),
      ],
    );
  }
}
