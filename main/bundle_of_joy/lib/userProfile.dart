import 'dart:developer';

import 'package:bundle_of_joy/auth/auth.dart';
import 'package:bundle_of_joy/sign_up.dart';
import 'package:flutter/material.dart';

import 'baby/babyProfile.dart';
import 'motherProfile/motherProfile.dart';
import 'widgets/cardWidget.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final kShadowColor = Color(0xFFE6E6E6);

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

  //Card view Widget
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: MediaQuery.of(context).size.height * .40,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
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
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      //child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.095,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.65),
                    )
                  ),
                  
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CardWidget(
                          title: "Mother Profile",
                          svgSrc: "assets/icons/testAM.svg",
                          press: () {
                            showModalBottomSheet(
                              context: context, 
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                              ),
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                physics: ClampingScrollPhysics(),
                                child: MotherProfile(),
                              )
                            );
                          },
                        ),
                        CardWidget(
                          title: "Baby Profile",
                          svgSrc: "assets/icons/Hamburger.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BabyProfile()), 
                            );
                          },
                        ),
                        CardWidget(
                          title: "App Review & Bugs Report",
                          svgSrc: "assets/icons/testHT.svg",
                          press: () {
                             //Navigator.push(
                              //context,
                              //MaterialPageRoute(builder: (context) => HealthTrackingMother()),
                            //);
                            log("Test onPress function");
                          },
                        ),
                        CardWidget(
                          title: "Sign Out",
                          svgSrc: "assets/icons/testEC.svg",
                          press: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext alertContext) {
                                return _signOut();
                              },
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
      ),
    );
  }
}