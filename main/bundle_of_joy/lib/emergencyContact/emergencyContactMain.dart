import 'dart:developer';

import 'package:bundle_of_joy/emergencyContact/emerContact.dart';
import 'package:bundle_of_joy/motherToBe.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';

class EmergencyContactMain extends StatefulWidget {
  @override
  _EmergencyContactMainState createState() => _EmergencyContactMainState();
}

class _EmergencyContactMainState extends State<EmergencyContactMain> {
  CollectionReference collectionReference = FirebaseFirestore.instance.collection("patient");
  List emergencyContactNameList = []; List emergencyContactNumberList = []; 
  EmerContact emerContact = EmerContact();

  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String contactName, contactNumber, dialogBoxContent, foodMapKey, foodWidgetTitle = "Add Emergency Contact";
  bool editContact = false;
  int listIndex, callListIndex = 0;

  String testID;
  

  Future getEmergencyContact() async {
    var x = await collectionReference.where("m_id", isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
    if((x.docs[0].data()["m_emergencyContactNoPrimary"] != "" && x.docs[0].data()["m_emergencyContactNoPrimary"] != null) &&
      (x.docs[0].data()["m_emergencyContactNamePrimary"] != "" && x.docs[0].data()["m_emergencyContactNamePrimary"] != null)){
        setState(() {
          emergencyContactNameList.add(x.docs[0].data()["m_emergencyContactNamePrimary"]);
          emergencyContactNumberList.add(x.docs[0].data()["m_emergencyContactNoPrimary"]);
        });
    }

    var y = await collectionReference.where("m_id", isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
    if((y.docs[0].data()["m_emergencyContactNoSecondary"] != "" && y.docs[0].data()["m_emergencyContactNoSecondary"] != null) &&
      (y.docs[0].data()["m_emergencyContactNameSecondary"] != "" && y.docs[0].data()["m_emergencyContactNameSecondary"] != null)){
        setState(() {
          emergencyContactNameList.add(x.docs[0].data()["m_emergencyContactNameSecondary"]);
          emergencyContactNumberList.add(x.docs[0].data()["m_emergencyContactNoSecondary"]);
        });
    }

    var z = await collectionReference.where("m_id", isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
    testID = z.docs[0].data()["patient_id"];
  }

  void initState(){
    super.initState();
    getEmergencyContact();
  }

  _showDialogBox(BuildContext context, dialogBoxContent) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Opps!"),
            content: Text(
              dialogBoxContent,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget emergencyContactModalBottomSheetWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 3, bottom: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              color: appbar1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.65),
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(2.0, 0),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      foodWidgetTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        )),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(13),
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Contact Name",
                      desc: "Enter the name for the contact.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: contactNameController,
                        onChanged: (val) => setState(() => contactName = val),
                        decoration: InputDecoration(
                          hintText: "Enter your contact name.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ModalSheetText(
                      title: "Contact Number",
                      desc: "Enter the number for the contact.",
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 15),
                      height: MediaQuery.of(context).size.width * 0.09,
                      child: TextFormField(
                        controller: contactNumberController,
                        onChanged: (val) => setState(() => contactNumber = val),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter your contact number.",
                          contentPadding: EdgeInsets.all(5),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Column(children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      textColor: Colors.black.withOpacity(0.65),
                      onPressed: () {
                        contactNameController.clear();
                        contactNumberController.clear();
                      },
                      child: Text(
                        "Reset",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        if (editContact == false) {
                          if (contactNameController.text.isNotEmpty && contactNumberController.text.isNotEmpty) {
                            if(emergencyContactNameList.length == 0){
                              emerContact.addEmerContactPrimary(contactNumber, contactName, testID).then((value) {
                                log(contactNumber+contactNumber+testID); 
                                contactNameController.clear();
                                contactNumberController.clear();
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MotherToBeHome()));
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContactMain()),);
                              });
                            }else if(emergencyContactNameList.length == 1){
                              emerContact.addEmerContactSecondary(contactNumber, contactName, testID).then((value){
                                contactNameController.clear();
                                contactNumberController.clear();
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MotherToBeHome()));
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContactMain()),);
                              });
                            }else{
                              dialogBoxContent = "You already added 2 emergency contact, If you wish to make changes to the contact please tap on the edit icon located at the right side.";
                              _showDialogBox(context, dialogBoxContent);
                            }
                          } else {
                            dialogBoxContent = "Please make sure you entered all of the field." + " All of the field cannot be left empty.";
                            _showDialogBox(context, dialogBoxContent);
                          }
                        }else{
                          if (contactNameController.text.isNotEmpty && contactNumberController.text.isNotEmpty) {        
                            if(listIndex == 0){
                              emerContact.addEmerContactPrimary(contactNumber, contactName, testID).then((value) {
                                setState(() {
                                  foodWidgetTitle = "Add Emergency Contact";
                                  editContact = false;
                                  listIndex = null;
                                });
                                contactNameController.clear();
                                contactNumberController.clear();
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MotherToBeHome()));
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContactMain()),);
                              });
                            }else if(listIndex == 1){
                              emerContact.addEmerContactSecondary(contactNumber, contactName, testID).then((value){
                                setState(() {
                                  foodWidgetTitle = "Add Emergency Contact";
                                  editContact = false;
                                  listIndex = null;
                                });
                                contactNameController.clear();
                                contactNumberController.clear();
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MotherToBeHome()));
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContactMain()),);
                              });
                            }
                          }
                        }
                      },
                      child: Text(
                        (editContact == false) ? "Add" : "Update",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emergencyContactListWidget() {
    return Container(
        margin: EdgeInsets.only(
          top: 10.0,
        ),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: emergencyContactNameList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      flex: 7,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    (index == 0)? "Primary Emergency Contact" : "Secondary Emergency Contact",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.035,
                                      color: Colors.black.withOpacity(0.65),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    emergencyContactNameList[index],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    emergencyContactNumberList[index],
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Center(
                            child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black.withOpacity(0.65),
                                ),
                                onPressed: () {
                                  foodWidgetTitle = "Edit Contact";
                                  editContact = true;
                                  listIndex = index;
                                  setState(() {
                                    contactName = emergencyContactNameList[index].toString();
                                    contactNumber = emergencyContactNumberList[index].toString();
                                  });
                                  contactNameController.text = emergencyContactNameList[index].toString();
                                  contactNumberController.text = emergencyContactNumberList[index].toString();
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                                      ),
                                      isScrollControlled: true,
                                      builder: (context) => Container(
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        child: SingleChildScrollView(
                                              physics: ClampingScrollPhysics(),
                                              child: emergencyContactModalBottomSheetWidget(context),
                                            ),
                                      ));
                                })),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Center(
                            child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            if(index == 0){
                              /*collectionReference.doc(testID).update({
                                "m_emergencyContactNamePrimary": FieldValue.delete(),
                                "m_emergencyContactNoPrimary": FieldValue.delete(),
                              }).then((value) {
                                log("Date Deleted");
                                Navigator.of(context).pop();
                              }).then((value) {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MotherToBeHome()));
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContactMain()));
                              });*/
                              dialogBoxContent = "You cannot delete your primary emergency contact. You can only modify it by tapping the edit button located at the right";
                              _showDialogBox(context, dialogBoxContent);
                            }else{
                              collectionReference.doc(testID).update({
                                "m_emergencyContactNameSecondary": FieldValue.delete(),
                                "m_emergencyContactNoSecondary": FieldValue.delete(),
                              }).then((value) {
                                log("Date Deleted");
                                Navigator.of(context).pop();
                              }).then((value) {
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MotherToBeHome()));
                                Navigator.push(context,MaterialPageRoute(builder: (context) => EmergencyContactMain()));
                              });
                            }
                          },
                        )),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }

  Widget noContactsWidget() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Center(
        child: Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Color(0xFFf5f5f5),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.red.withOpacity(0.4)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 8),
                child: SvgPicture.asset(
                  "assets/icons/warning.svg",
                  height: 25,
                  width: 25,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Looks like you haven't add any food. Tap on the buton below to add some food into the record.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget emergencyContactWidgetContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Emergency Contacts",
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/contact-form.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Emergency Contacts Info",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: Text(
                    "Section below display the emergency contacts you saved in your account.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
                (emergencyContactNameList.length != 0) ? emergencyContactListWidget() : noContactsWidget(),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appbar1,
                      textColor: Colors.white,
                      onPressed: () {
                        if(emergencyContactNameList.length == 2){
                          dialogBoxContent = "You already added 2 emergency contact, If you wish to make changes to the contact please tap on the edit icon located at the right side.";
                          _showDialogBox(context, dialogBoxContent);
                        }else{
                          foodWidgetTitle = "Add Emergency Contact";
                          editContact = false;
                          contactNameController.clear();
                          contactNumberController.clear();
                          showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                              ),
                              isScrollControlled: true,
                              builder: (context) => Container(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: SingleChildScrollView(
                                      physics: ClampingScrollPhysics(),
                                      child: emergencyContactModalBottomSheetWidget(context),
                                    ),
                              ));
                        }
                      },
                      child: Text(
                        (emergencyContactNameList.length == 0)? "Add Primary contact" 
                          :(emergencyContactNameList.length == 2)? "Emergency Contact List Full": "Add Secondary contact",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
                          ],
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget contactSelectionWidget(BuildContext context) {
    TextStyle normalTextStyle = TextStyle(color: Colors.black.withOpacity(0.65),fontSize: MediaQuery.of(context).size.width * 0.033,);
    TextStyle highlightedTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.045,);

    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            "If you have multiple emergency contacts saved in your account, you will have the choice to choose who to contact. " +
                "You can tap the radio button to select which contact you want to call.",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.035,
              color: Colors.black.withOpacity(0.65),
            ),
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: emergencyContactNameList.length,
              itemBuilder: (BuildContext context, int index){
                return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      //height: 20,
                      width: double.infinity,
                      child: RadioListTile(
                        dense: true,
                        title: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(style: normalTextStyle, children: <TextSpan>[
                            TextSpan(
                              text: (index == 0)? "Primary Emergency Contact" : "Secondary Emergency Contact",
                            ),
                            TextSpan(
                              text: "\n${emergencyContactNameList[index]}\n${emergencyContactNumberList[index]}",
                              style: highlightedTextStyle,
                            ),
                          ])),  
                        activeColor: appbar2,
                        value: index,
                        groupValue: callListIndex,
                        onChanged: (index) {
                          setState(() {
                            callListIndex = index;
                            log(callListIndex.toString());
                          });
                        },
                      ),
                    ),
                  ],
                ));
              }
            )
          ),
        
        //(completeFoodRecord == false)? BabyFoodRecrodAddText() : BabyFoodRecrodDoneText(),
      ],
    );
  }

  Widget callEmergencyContactWidgetContent(BuildContext context) {
    return Column(
      children: <Widget>[
        WidgetTitle(
          title: "Call Emergency Contact",
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(15, 15),
                  blurRadius: 20,
                  spreadRadius: 15,
                  color: Color(0xFFE6E6E6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/phone-call.svg",
                      height: 23,
                      width: 23,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.0,
                      ),
                      child: Text(
                        "Contact Selection",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                //widget
                contactSelectionWidget(context)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget contactNotEmpty(BuildContext context){
    return Column(
      children: [
        emergencyContactWidgetContent(context),
        callEmergencyContactWidgetContent(context),
        //Call
        Container(
          margin: EdgeInsets.only(left: 13, right: 13, bottom: 20),
          child: SizedBox(
            width: double.infinity,
            child: FlatButton(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              color: appbar2,
              textColor: Colors.white,
              onPressed: () {
                FlutterPhoneDirectCaller.callNumber(emergencyContactNumberList[callListIndex]);
              },
              child: Text(
                "Call Emergency Contact",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Emergency Contact",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            foodWidgetTitle = "Add Emergency Contact";
            editContact = false;
            contactNameController.clear();
            contactNumberController.clear();
          },
          child: Column(
            children: <Widget>[
              (emergencyContactNameList.length == 0)? emergencyContactWidgetContent(context) : contactNotEmpty(context),
            ],
          ),
        ),
      ),
    );
  }
}