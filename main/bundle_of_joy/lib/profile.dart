import "package:flutter/material.dart";
import 'motherProfile/motherProfile.dart';
import "auth/auth.dart";
import "sign_up.dart";
import "baby/babyProfile.dart";

class ProfileTab extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileTab> {
  AlertDialog _signOut() {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        signOut();
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) {
            return SignUpScreen();
          }),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Log Out",
        style: TextStyle(
          fontFamily: "Comfortaa",
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.03,
        ),
      ),
      content: Text(
        "Would you like to log out?",
        style: TextStyle(
          fontFamily: "Comfortaa",
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.022,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
      backgroundColor: Color(0xFFFCFFD5),
    );

    return alert;
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
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MotherProfile()),
                );
                break;
              }
            case 1:
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BabyProfile()),
                );
                break;
              }
            case 2:
              {
                showDialog(
                  context: context,
                  builder: (BuildContext alertContext) {
                    return _signOut();
                  },
                );
                break;
              }
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
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

  @override
  Widget build(BuildContext context) {
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
              "Profile",
              style: TextStyle(
                fontFamily: 'Comfortaa',
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
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 20.0, left: 20, right: 20),
        children: <Widget>[
          singleCard("assets/icons/mother.png", "Mother's\nProfile", 0),
          singleCard("assets/icons/baby_color.png", "Baby's\nProfile", 1),
          singleCard("assets/icons/logout.png", "Log Out", 2),
        ],
      ),
    );
  }
}
