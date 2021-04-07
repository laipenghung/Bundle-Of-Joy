import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:bundle_of_joy/motherProfile/mother.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';

class MotherInfo extends StatefulWidget {
  final String pid;
  MotherInfo({Key key, this.pid}) : super(key: key);
  @override
  _MotherInfo createState() => _MotherInfo(pid);
}

class _MotherInfo extends State<MotherInfo> {
  String input;
  final String pid;
  _MotherInfo(this.pid);
  PickedFile _image;
  String _downloadURL;

  Future<bool> editBox(int index, AsyncSnapshot<DocumentSnapshot> document, BuildContext context) {
    Mother mother = new Mother();
    final _listEditTitles = [
      "Edit Name",
      "Edit Age",
      "Edit Date Of Birth",
      "Edit Blood Type",
      "Edit No Of Child",
      "Edit Personal Phone",
      "Edit Emergency Contact"
    ];
    final _listField = ["m_name", "m_age", "m_dob", "m_bloodType", "m_no_of_child", "m_phone", "m_emergencyContact"];
    Future<bool> _selectDate() async {
      DateTime selectedDate = DateTime.now();
      String year, month, day, DOB;
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(selectedDate.year - 150),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.dark(
                  surface: Color(int.parse("0xFFFCFFD5")),
                  onSurface: Colors.black,
                ),
              ),
              child: child,
            );
          });
      if (picked != null) {
        setState(() {
          year = picked.year.toString();
          month = picked.month.toString();
          day = picked.day.toString();
          DOB = "$year-$month-$day";
          mother.editProfile(_listField[index], DOB, pid);
        });
        return true;
      } else {
        return false;
      }
    }

    if (index == 2) {
      return _selectDate();
    } else {
      input = document.data.data()[_listField[index]].toString();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ButtonBarTheme(
              data: ButtonBarThemeData(alignment: MainAxisAlignment.spaceAround),
              child: AlertDialog(
                backgroundColor: Color(0xFFFCFFD5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                title: Center(child: Text(_listEditTitles[index])),
                content: editField(index, document, _listField),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Done"),
                    onPressed: () {
                      mother.editProfile(_listField[index], input, pid);
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                  }),
                ],
              ),
            );
          });
    }
  }

  Widget editField(int index, AsyncSnapshot<DocumentSnapshot> document, List _listField) {
    double margin = 30;
    if (index == 3) {
      return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          margin: EdgeInsets.only(left: margin, right: margin),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Color(0xFFFCFFD5),
              value: input,
              items: <String>["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  input = value;
                });
              },
            ),
          ),
        );
      });
    } else if (index == 1 || index == 4 || index == 5 || index == 6) {
      return Container(
        margin: EdgeInsets.only(left: margin + 20, right: margin + 20),
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: document.data.data()[_listField[index]].toString()),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            input = value;
          },
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(left: margin, right: margin),
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: document.data.data()[_listField[index]].toString()),
          onChanged: (value) {
            input = value;
          },
        ),
      );
    }
  }

  Future getImage(BuildContext context) async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      uploadPic(context);
    });
  }

  Future uploadPic(BuildContext context) async{
    Mother mother = new Mother();
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("MOTHERS/"+pid+"/profile_picture/"+fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(File(_image.path));
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
    mother.updateProfilePicture(fileName, pid);
  }

  Future loadImageFromStorage(String photoURL) async {
    String downloadURL = await FirebaseStorage.instance.ref().child("MOTHERS/"+pid+"/profile_picture/"+photoURL).getDownloadURL();

    setState(() {
      _downloadURL = downloadURL;
    });
  }

  Widget profilePage(AsyncSnapshot document, BuildContext context){
    double fontSize = MediaQuery.of(context).size.width * 0.04;
    var patient = document.data;
    final _listItems = ["Name", "Age", "Date Of Birth", "Blood Type", "No Of Child", "Personal Phone", "Emergency Contact"];
    final _listInfo = [
      patient.data()["m_name"].toString(),
      patient.data()["m_age"].toString(),
      patient.data()["m_dob"].toString(),
      patient.data()["m_bloodType"].toString(),
      patient.data()["m_no_of_child"].toString(),
      patient.data()["m_phone"].toString(),
      patient.data()["m_emergencyContact"].toString()
    ];
    var photoURL = patient.data()["photoURL"].toString();
    if(photoURL!=null) {
      loadImageFromStorage(photoURL);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundImage: (_downloadURL!=null)?(
                        NetworkImage(_downloadURL)
                    ):AssetImage("assets/icons/default_user.png"),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 80,
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.camera,
                      size: 30.0,
                    ),
                    onPressed: () {
                      getImage(context);
                    },
                  ),
                ),
              ]
            ),
            ListView.separated(
              padding: EdgeInsets.only(top: 25),
              shrinkWrap: true,
              itemCount: _listItems.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _listItems[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                  trailing: Text(
                    _listInfo[index],
                    style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontSize: fontSize,
                    ),
                  ),
                  onTap: () {
                    editBox(index, document, context);
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          ],
        ),
      ),
    );
  }

  Widget loading(BuildContext context){
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
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
            "Loading...",
            style: TextStyle(
              fontFamily: "Comfortaa",
              fontSize: fontSizeText,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    DocumentReference patient = FirebaseFirestore.instance.collection("patient").doc(pid);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mother's Profile",
          style: TextStyle(
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        backgroundColor: appbar3,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: patient.snapshots(),
        builder: (context, document) {
          if(document.hasData){
            return profilePage(document, context);
          } else {
            return loading(context);
          }
        }
      ),
    );
  }
}
