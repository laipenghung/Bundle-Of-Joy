import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_slidable/flutter_slidable.dart';

class AppointmentMotherRecordList extends StatefulWidget {
  @override
  _AppointmentMotherRecordListState createState() => _AppointmentMotherRecordListState();
}

class _AppointmentMotherRecordListState extends State<AppointmentMotherRecordList> {
  final User user = FirebaseAuth.instance.currentUser;

  Future<void> deleteSelected(appointmentID) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    return _db.collection("mother_appointment").doc(appointmentID).delete();
  }

  Future<void> updateSlotCount(slotID, sessionForThisRecord, dateForThisRecord) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    CollectionReference slotRecord = _db.collection("appointment_slot");

    return slotRecord.doc(slotID).update({
      if (sessionForThisRecord == "AM") "s_available_AM": FieldValue.increment(1),
      if (sessionForThisRecord == "PM") "s_available_PM": FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,

        title: Text(
          "Appointment Management",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),

        //automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('mother_appointment').where("m_id", isEqualTo: user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: Colors.black,
                    valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFCFFD5)),
                  ),
                ),
              );
            } else if (snapshot.data.documents.isEmpty) {
              return Center(
                child: Text(
                  'There is currently no records',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.22,
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: "Delete",
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                deleteSelected(snapshot.data.documents[index]["a_id"]);
                                updateSlotCount(snapshot.data.documents[index]["s_id"], snapshot.data.documents[index]["a_session"],
                                    snapshot.data.documents[index]["a_date"]);
                              },
                            )
                          ],
                          child: Container(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.015,
                                bottom: MediaQuery.of(context).size.height * 0.015,
                                left: MediaQuery.of(context).size.width * 0.07),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                                  child: Image.asset(
                                    "assets/icons/appointment.png",
                                    height: MediaQuery.of(context).size.height * 0.06,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date:",
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      "Session:",
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data.documents[index]["a_date"],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                    Text(
                                      snapshot.data.documents[index]["a_session"],
                                      style: TextStyle(
                                        fontFamily: 'Comfortaa',
                                        fontWeight: FontWeight.bold,
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          indent: MediaQuery.of(context).size.width * 0.03,
                          endIndent: MediaQuery.of(context).size.width * 0.03,
                          color: Colors.black,
                          thickness: MediaQuery.of(context).size.height * 0.001,
                        ),
                      ],
                    );
                  },
                ),
              );
            }
          } else if (snapshot.hasError) {
            print("error");
          }
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
                  'Loading...',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
