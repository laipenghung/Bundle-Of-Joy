import "package:bundle_of_joy/baby/addBaby.dart";
import "package:bundle_of_joy/careForBaby/careForBabyTab.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "baby/baby.dart";

class MotherForBabyTab extends StatefulWidget {
  @override
  _MotherForBabyTabState createState() => _MotherForBabyTabState();
}

class _MotherForBabyTabState extends State<MotherForBabyTab> {
  Widget _listView(AsyncSnapshot<QuerySnapshot> collection) {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.04;
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
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
    if (collection.hasData) {
      collection.data.docs.forEach((doc) {
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

      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: width,
          decoration: myBoxDecoration(),
          margin: EdgeInsets.only(top: paddingTop),
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
                          style: TextStyle(
                            fontFamily: "Comfortaa",
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (index) {
                  setState(() {
                    selected_index = _listBaby.indexOf(index);
                    selected_babyID = _listBaby[selected_index].b_id.toString();
                  });
                },
              ),
            ),
          ),
        );
      });
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 0.5,
      ),
      borderRadius: BorderRadius.all(Radius.circular(50.0) //<--- border radius here
          ),
    );
  }

  singleCard(iconLoc, title, index) {
    double height = MediaQuery.of(context).size.height * 0.1;
    double fontSize = MediaQuery.of(context).size.width * 0.045;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Color(0xFFFCFFD5),
      child: InkWell(
        onTap: () {
          switch (index) {
            case 0:
              {}
              break;
            case 1:
              {}
              break;
            case 2:
              {}
              break;
            case 3:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CareForBabyTab()),
                );
              }
              break;
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Image.asset(
                iconLoc,
                height: height,
              ),
            ),
            FittedBox(
              fit: BoxFit.cover,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Comfortaa",
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hasData(AsyncSnapshot<QuerySnapshot> collection) {
    double paddingTop = MediaQuery.of(context).size.height * 0.05;
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    if (collection.data.docs.isNotEmpty) {
      return Column(
        children: [
          _listView(collection),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: paddingTop, left: 15, right: 15),
            children: <Widget>[
              singleCard("assets/icons/appointment.png", "Appointment\nManagement", 0),
              singleCard("assets/icons/vaccination.png", "Vaccination\nSchedule", 1),
              singleCard("assets/icons/bar-chart.png", "Vaccination &\nGrowth\nTracking", 2),
              singleCard("assets/icons/baby_color.png", "Care\nfor Baby", 3),
            ],
          ),
        ],
      );
    }
    else{
      return Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
              color: Color(0xFFFCFFD5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(width: 1.5, color: Colors.black)
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBaby()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 12, bottom: 12),
                child: Text(
                  "Add Baby",
                  style: TextStyle(
                    fontFamily: "Comfortaa",
                    fontWeight: FontWeight.bold,
                    fontSize: fontSizeTitle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    Query baby = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").orderBy("b_name");

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1, //APP BAR HEIGHT

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.height * 0.09,
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("assets/icons/small.png"),
                ),
              ),
            ),
            Text(
              "Mother-for-baby",
              style: TextStyle(
                fontFamily: "Comfortaa",
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                color: Colors.black,
              ),
            ),
          ],
        ),

        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: baby.snapshots(),
          builder: (context, collection) {
            return hasData(collection);
          }),
    );
  }
}
