import "package:flutter/material.dart";
import "motherProfile.dart";
import "auth/auth.dart";
import "sign_up.dart";
import "home.dart";

class ProfileTab extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileTab> {
  singleCard(iconLoc, title, index) {
    double height = MediaQuery.of(context).size.height * 0.15;
    double fontSize = MediaQuery.of(context).size.width * 0.045;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      color: Color(0xFFFCFFD5),
      child: InkWell(
        onTap: () {
          switch (index) {
            case 0:{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MotherProfile()),
              );
              break;
            }
            case 1:{
              break;
            }
            case 2:{
              break;
            }
            case 3:{
              break;
            }
            case 4:{
              signOut();
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                    builder: (context){
                      return SignUpScreen();
                    }
                ),
              );
            }
          }
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 20.0),
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
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
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
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 20.0),
        children: <Widget>[
          singleCard("assets/icons/mother.png", "Mother's Profile", 0),
          singleCard("assets/icons/baby_color.png", "Baby's Profile", 1),
          singleCard("assets/icons/settings.png", "Setting", 2),
          singleCard("assets/icons/feedback.png", "Feedback", 3),
          singleCard("assets/icons/feedback.png", "Logout", 4),
        ],
      ),
    );
  }
}

/*
RaisedButton(
onPressed: () {
signOut();
Navigator.of(context).pushReplacement(
MaterialPageRoute(
builder: (context){
return SignUpScreen();
}
),
);
},
child: const Text("Sign Out", style: TextStyle(fontSize: 20)),
),*/
