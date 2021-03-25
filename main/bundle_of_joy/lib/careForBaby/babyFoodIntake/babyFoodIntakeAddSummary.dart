import 'package:bundle_of_joy/widgets/recordBabyAfterMealUpdateWidget.dart';
import 'package:bundle_of_joy/widgets/recordDateTimeWidget.dart';
import 'package:bundle_of_joy/widgets/recordListWidget.dart';
import 'package:bundle_of_joy/widgets/textWidgets.dart';
import 'package:flutter/material.dart';

class BabyFoodIntakeAddSummary extends StatefulWidget {
  final String selectedBabyID, selectedDate, selectedTime;
  final Map foodMap;
  BabyFoodIntakeAddSummary({Key key, this.selectedBabyID, this.selectedDate, this.selectedTime, this.foodMap}) : super(key: key);
  
  @override
  _BabyFoodIntakeAddSummaryState createState() => _BabyFoodIntakeAddSummaryState();
}

class _BabyFoodIntakeAddSummaryState extends State<BabyFoodIntakeAddSummary> {
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
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 18.0, left: 13.0,),
                    child: Text(
                      "Date and Time",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //Widget for display Date and Time
                  RecordDateTimeWidget(
                    svgSrcDate: "assets/icons/testAM.svg",
                    svgSrcTime: "assets/icons/clock.svg",
                    date: widget.selectedDate,
                    dateDesc: babyFoodDateDesc,
                    time: widget.selectedTime,
                    timeDesc: babyFoodTimeDesc
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                    child: Text(
                      "Conusmed Food",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //Widget for display Consumed Food
                  RecordListWidget(
                    svgSrc: "assets/icons/healthy-food.svg",
                    title: babyFoodRecordListTitle,
                    titleDesc: babyFoodRecordListTitleDesc,
                    foodName: widget.foodMap.keys.toList(),
                    foodQty: widget.foodMap.values.toList(),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 13.0, left: 13.0,),
                    child: Text(
                      "After Meal Behavior",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //update
                  RecordBabyAfterMealUpdateWidget(
                    svgSrc: "assets/icons/testAM.svg",
                    selectedBabyID: widget.selectedBabyID,
                    selectedDate: widget.selectedDate,
                    selectedTime: widget.selectedTime,
                    foodMap: widget.foodMap,
                    //symptomsAndAllergies: false,
                  ),
                  //
                  
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}