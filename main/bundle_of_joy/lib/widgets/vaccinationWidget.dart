import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class VaccinationWidget extends StatefulWidget {
  final String tableTitle, tableDesc, svgSrcTable, tableMeasurement, age;
  final List ageListString, vaccineNameList, dateTakenList;
  final bool vaccineTrack;
  VaccinationWidget({Key key, @required this.tableTitle,
    @required this.tableDesc,@required this.svgSrcTable,
    @required this.ageListString, @required this.vaccineNameList,
    @required this.tableMeasurement, this.age, this.dateTakenList,
    @required this.vaccineTrack}) : super(key: key);

  @override
  _VaccinationWidgetState createState() => _VaccinationWidgetState();
}

class _VaccinationWidgetState extends State<VaccinationWidget> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('app_icon');
    var initializationSettings = new InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future _showNotification(String age) async {
    var androidDetails = new AndroidNotificationDetails("vaccine", "Vaccination Schedule", "Baby Vaccination Schedule", importance: Importance.max);
    var generalNotificationDetails = new NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(1, "Upcoming Vaccination", "You have upcoming baby vaccination at " + age, generalNotificationDetails);
  }

  List<TableRow> vaccineScheduleData(){
    List<TableRow> _row = [];
    Color rowColor = Colors.white;
    RegExp exp = new RegExp(r"\d+ \w+");

    _row.add(
      TableRow(
          children: [
            TableCell(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        right: BorderSide(
                          width: 0.25,
                          color: Colors.white,
                        ),
                      )
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Age",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        left: BorderSide(
                          width: 0.25,
                          color: Colors.white,
                        ),
                      )
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.tableMeasurement,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
    for (var x in zip([widget.ageListString, widget.vaccineNameList])){
      if (x[0] == exp.stringMatch(widget.age).toString()) {
        _showNotification(widget.age);
        rowColor = Colors.greenAccent;
      } else {
        rowColor = Colors.white;
      }
      _row.add(
        TableRow(
            decoration: BoxDecoration(
              color: rowColor,
            ),
            children: [
              TableCell(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                          right: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                        )
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        x[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                          left: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                        )
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        x[1].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
        ),
      );
    }
    return _row;
  }

  List<TableRow> vaccineHistoryData(){
    List<TableRow> _row = [];

    _row.add(
      TableRow(
          children: [
            TableCell(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        right: BorderSide(
                          width: 0.25,
                          color: Colors.white,
                        ),
                      )
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Age",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        left: BorderSide(
                          width: 0.25,
                          color: Colors.white,
                        ),
                      )
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.tableMeasurement,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TableCell(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: appbar2,
                      border: Border(
                        left: BorderSide(
                          width: 0.25,
                          color: Colors.white,
                        ),
                      )
                  ),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Date Taken",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]
      ),
    );
    for (var x in zip([widget.ageListString, widget.vaccineNameList, widget.dateTakenList])){
      _row.add(
        TableRow(
            children: [
              TableCell(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                          right: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                        )
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        x[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                          left: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                        )
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        x[1].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.45),),
                          left: BorderSide(width: 0.25, color: Colors.black.withOpacity(0.45),),
                        )
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        x[2].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.033,
                          color: Colors.black.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]
        ),
      );
    }
    return _row;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                SvgPicture.asset(widget.svgSrcTable, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 10.0,),
                  child: Text(
                    widget.tableTitle,
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
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                widget.tableDesc,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
              child: Table(
                columnWidths: (widget.vaccineTrack == true) ? {0: FlexColumnWidth(4), 1: FlexColumnWidth(4),} : {0: FlexColumnWidth(4), 1: FlexColumnWidth(4), 2: FlexColumnWidth(4),},
                children: (widget.vaccineTrack == true) ? vaccineScheduleData() : vaccineHistoryData(),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 5),
              child: (widget.vaccineTrack == true)? VaccineTrackText() : VaccineRecordText(),
            )
          ],
        ),
      ),
    );
  }
}