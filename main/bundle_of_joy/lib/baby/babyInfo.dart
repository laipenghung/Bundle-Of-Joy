import 'dart:io';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import "baby.dart";

class BabyInfo extends StatefulWidget {
  final Baby baby;
  BabyInfo({Key key, this.baby}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BabyInfo(baby);
}

class _BabyInfo extends State<BabyInfo> {
  final Baby baby;
  final String motherID = FirebaseAuth.instance.currentUser.uid;

  _BabyInfo(this.baby);

  String input;
  PickedFile _image;
  String _downloadURL;

  Future getImage(BuildContext context, List babyInfo) async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      uploadPic(context, babyInfo);
    });
  }

  Future uploadPic(BuildContext context, List babyInfo) async {
    Baby baby = new Baby.empty();
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(
        "BABY/" + motherID+ "/" + babyInfo[1]  + "/profile_picture/" + fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(
        File(_image.path));
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Profile Picture Uploaded')));
    });
    baby.updateProfilePicture(fileName, motherID, babyInfo.last);
  }

  Future loadImageFromStorage(String photoURL, List babyInfo) async {
    String downloadURL = await FirebaseStorage.instance.ref().child(
        "BABY/" + motherID + "/" + babyInfo[1] +"/profile_picture/" + photoURL).getDownloadURL();

    setState(() {
      _downloadURL = downloadURL;
    });
  }

  Widget _listView(AsyncSnapshot<DocumentSnapshot> document, BuildContext context) {
    double fontSizeTitle = MediaQuery.of(context).size.width * 0.05;
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;

    final _listItems = [
      "Baby IC",
      "Name",
      "Date of Birth",
      "Time of Birth",
      "Place of Birth",
      "Gender",
      "Age",
      "Blood Type",
      "Mode Of Delivery",
      "Weight At Birth",
      "Length At Birth",
      "Head Circumference",
      "Order"
    ];

    final _listInfo = [
      baby.b_ic.toString(),
      baby.b_name,
      baby.b_dob.toDate().toString().substring(0, 10),
      baby.b_dob.toDate().toString().substring(11, 16),
      baby.b_place_of_birth,
      baby.b_gender,
      baby.b_age,
      baby.b_bloodType,
      baby.b_mode_of_delivery,
      baby.b_weight_at_birth.toString(),
      baby.b_length_at_birth.toString(),
      baby.b_head_circumference.toString(),
      baby.b_order.toString(),
      baby.b_id
    ];
    var photoURL = document.data.data()["photoURL"].toString();
    if (photoURL != null) {
      loadImageFromStorage(photoURL, _listInfo);
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
                        backgroundImage: (_downloadURL != null) ? (
                            NetworkImage(_downloadURL)
                        ) : AssetImage("assets/icons/default_user.png"),
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
                          getImage(context, _listInfo);
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
                        fontSize: fontSizeText,
                      ),
                    ),
                    trailing: Text(
                      _listInfo[index],
                      style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontSize: fontSizeText,
                      ),
                    ),
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

  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser;
    DocumentReference babyDoc = FirebaseFirestore.instance.collection("mother").doc(user.uid).collection("baby").doc(baby.b_id);
    double fontSizeTitle = MediaQuery
        .of(context)
        .size
        .width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          baby.b_name,
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
          stream: babyDoc.snapshots(),
          builder: (context, document) {
            if(document.hasData)
              return _listView(document, context);
            else
              return loading(context);
          }),
    );
  }
}