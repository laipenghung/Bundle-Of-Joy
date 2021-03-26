import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:flutter/material.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';

import 'babyFoodIntake/babyFoodIntake_add_dateTime.dart';
import 'babyFoodIntake/babyFoodIntake_recordList_done.dart';
import 'babyFoodIntake/babyFoodIntake_recordList_pending.dart';
import 'babyTemp/babyTemp_add_dateTime.dart';
import 'babyTemp/babyTemp_recordList_done.dart';
import 'babyTemp/babyTemp_recordList_pending.dart';

class CareForBabyMain extends StatefulWidget {
  final String selectedBabyID;
  CareForBabyMain({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _CareForBabyMainState createState() => _CareForBabyMainState();
}

class _CareForBabyMainState extends State<CareForBabyMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: true,
            pinned: true,
            stretch: true,
            backgroundColor: appThemeColor,
            stretchTriggerOffset: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                  "Care For Baby",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
              background: Image.network(
                "https://image.freepik.com/free-vector/psychedelic-groovy-background-with-eaves_23-2148837578.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  //Baby Food Tracking
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    //padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                    child: Text(
                      "Baby Food Tracking",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width *0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  HorizontalCardWidget(
                    title: "Baby Food Intake Record",
                    description: "View all of your baby's food record.",
                    svgSrc: "assets/icons/verify.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BabyFoodIntakeListDone(selectedBabyID: widget.selectedBabyID)),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Create New Baby Food Record",
                    description: "Create a new food record for your baby.",
                    svgSrc: "assets/icons/add.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BabyFoodIntakeAdd1(selectedBabyID: widget.selectedBabyID)),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Update Pending Baby Food Record",
                    description: "Update your baby's existing food record.",
                    svgSrc: "assets/icons/edit.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BabyFoodIntakeListPending(selectedBabyID: widget.selectedBabyID)),
                      );
                    }
                  ),
                  //Baby Medicine Tracking
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    //padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                    child: Text(
                      "Baby Medicine Tracking",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width *0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  HorizontalCardWidget(
                    title: "Medicine Intake Record",
                    description: "View all of your baby's medicine record.",
                    svgSrc: "assets/icons/verify.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>BabyTempListDone(selectedBabyID: widget.selectedBabyID)),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Create New Medicine Record",
                    description: "Create a new medicine record for your baby.",
                    svgSrc: "assets/icons/add.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BabyTempAdd1(selectedBabyID: widget.selectedBabyID)),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Update Pending Medicine Record",
                    description: "Update your baby's existing medicine record.",
                    svgSrc: "assets/icons/edit.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BabyTempListPending(selectedBabyID: widget.selectedBabyID)),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}