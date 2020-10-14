import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "auth/auth.dart";
import "sign_up.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Setting();
}

class _Setting extends State<Setting>{
  AlertDialog _signOut(){
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Log Out"),
      onPressed:  () {
        signOut();
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
              builder: (context){
                return SignUpScreen();
              }
          ),
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Log Out",
        style: TextStyle(
          fontFamily: "Comfortaa",
        ),
      ),
      content: Text(
        "Would you like to log out?",
        style: TextStyle(
          fontFamily: "Comfortaa",
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

  Widget _listView(BuildContext context){
    final settingList = ["Logout"];

    return ListView.separated(
        itemCount: settingList.length,
        itemBuilder: (context, index){
          return ListTile(
              title: Text(
                settingList[index],
              ),
              trailing: Icon(FontAwesomeIcons.signOutAlt),
              onTap: (){
                if(index == 0){
                  showDialog(
                    context: context,
                    builder: (BuildContext alertContext) {
                      return _signOut();
                    },
                  );
                }
              }
          );
        },
        separatorBuilder: (context, index) => Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Setting",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: _listView(context),
      ),
    );
  }
}

