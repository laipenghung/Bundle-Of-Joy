import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FoodIntakeTrackAdd extends StatefulWidget {
  @override
  _FoodIntakeTrackAddState createState() => _FoodIntakeTrackAddState();
}

class _FoodIntakeTrackAddState extends State<FoodIntakeTrackAdd> {
  //Color testColor = Color(0xFFff713a);
  BoxDecoration testDeco = BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(15, 15),
                                  blurRadius: 20,
                                  spreadRadius: 15,
                                  color: Color(0xFFE6E6E6),
                                )]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            //expandedHeight: MediaQuery.of(context).size.height * 0.15,
            floating: true,
            pinned: true,
            stretch: true,
            backgroundColor: appThemeColor,
            //stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Container(
                child: Text(
                  "Food Intake Record",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                //Date
                WidgetTitle(
                  title: "Date Selection",
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
                            SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                            Container(
                              padding: EdgeInsets.only(left: 8.0,),
                              child: Text(
                                "Date",
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
                            "Please select a date for this food record.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 15.0),
                          child: Text(
                            "22 Jan 2021",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.056,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              color: appThemeColor,
                              textColor: Colors.white,
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Pick A Date",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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

                //Time
                WidgetTitle(
                  title: "Time Selection",
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
                            SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                            Container(
                              padding: EdgeInsets.only(left: 8.0,),
                              child: Text(
                                "Time",
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
                            "Please select a time for this food record.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 15.0),
                          child: Text(
                            "4:43 P.M.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.056,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              color: appThemeColor,
                              textColor: Colors.white,
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Pick A Time",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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

                //Food
                WidgetTitle(
                  title: "Consumed Food",
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
                      ],),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                            Container(
                              padding: EdgeInsets.only(left: 8.0,),
                              child: Text(
                                "Food",
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
                            "Please enter the food that you consumed.",
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
                            children: [
                              //for(var x in foodName)
                              //for (var x in zip([foodName, foodQty]))
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            //x[0].toString(),
                                            "Food name 1",
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
                                          margin: EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            //"x " + x[1].toString() + " MEASUREMENT",
                                            "x 1 MEASUREMENT",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.04,
                                              color: Colors.black.withOpacity(0.65),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              ), 
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              color: appThemeColor,
                              textColor: Colors.white,
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Add Food",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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

                //Blood Sugar
                WidgetTitle(
                  title: "Blood Glucose",
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
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
                            SvgPicture.asset("assets/icons/testAM.svg", height: 23, width: 23,),
                            Container(
                              padding: EdgeInsets.only(left: 10.0,),
                              child: Text(
                                "Blood Sugar Reading",
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
                            "Your blood sugar reading before meal and 2 hours after meal. You " +
                            "can leave the 2 hours after meal section empty if u wish to update it later.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              color: Colors.black.withOpacity(0.65),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 15.0, bottom: 5.0,),
                          child: Table(
                            //border: TableBorder.all(color: Colors.black),
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8,),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            width: 0.5, 
                                            color: Colors.black.withOpacity(0.65),
                                          ),
                                        )
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            //bSugarBefore.toString() + " mmol/L",
                                            "5.4 mmol/L",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.05,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(
                                              "Before meal",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.033,
                                                color: Colors.black.withOpacity(0.65),
                                              ),
                                            ),
                                          ),
                                        ] 
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 8, bottom: 8,),
                                      child: Column(
                                        children: [
                                          Text(
                                            "6.7 mmol/L",
                                            //(bSugarAfter == null)? "-" : bSugarAfter.toString() + " mmol/L",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.05,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),  
                                          Container(
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(
                                              "2 hours after meal",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context).size.width * 0.033,
                                                color: Colors.black.withOpacity(0.65),
                                              ),
                                            ),
                                          ),
                                        ] 
                                      ),
                                    ),
                                  ),
                                ]
                              ), 
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(15, 10, 15, 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: FlatButton(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0,),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              color: appThemeColor,
                              textColor: Colors.white,
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Add Blood Sugar Reading",
                                textAlign: TextAlign.center,
                                style: TextStyle(
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

                //Next Screen
                Container(
                  margin: EdgeInsets.only(left: 13, right: 13, bottom: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0,),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      color: appThemeColor,
                      textColor: Colors.white,
                      onPressed: () {
                        
                      },
                      child: Text(
                        "Review Food Record",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ), 
                    ),
                  ),
                ),
              ],
            )
            
            
            
          ),
        ],
      ),
    );
  }
}

class WidgetTitle extends StatelessWidget {
  final String title;
  const WidgetTitle({
    Key key,this.title,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 18.0, left: 13.0,),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.05,
          color: Colors.black,
        ),
      ),
    );
  }
}