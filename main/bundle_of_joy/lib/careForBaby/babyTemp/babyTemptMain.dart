import "package:flutter/material.dart";

import 'babyTemp_add_dateTime.dart';
import 'babyTemp_recordList_done.dart';
import 'babyTemp_recordList_pending.dart';

class BabyTempMain extends StatefulWidget {
  final String selectedBabyID;
  BabyTempMain({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _BabyTempMainState createState() => _BabyTempMainState();
}

class _BabyTempMainState extends State<BabyTempMain> {
  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/menu.png",
                          height: 70,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Temperature Record",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BabyTempListDone(selectedBabyID: widget.selectedBabyID,)),
                );
                print(widget.selectedBabyID);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/add.png",
                          height: 65,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Add Record",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BabyTempAdd1(selectedBabyID: widget.selectedBabyID)),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/pending.png",
                          height: 70,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Pending Record",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BabyTempListPending(selectedBabyID: widget.selectedBabyID,)),
              );
              },
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFFCFFD5),
      border: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    );
  }
}
