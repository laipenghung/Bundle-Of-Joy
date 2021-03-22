import 'package:bundle_of_joy/foodIntake/foodIntakeTrackView.dart';
import 'package:flutter/material.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'foodIntake_add_1_dateTime.dart';
import 'foodIntake_recordList_done.dart';
import 'foodIntake_recordList_pending.dart';

class FoodIntakeTrackMain extends StatefulWidget {
  @override
  _FoodIntakeTrackMainState createState() => _FoodIntakeTrackMainState();
}

class _FoodIntakeTrackMainState extends State<FoodIntakeTrackMain> {
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
            stretchTriggerOffset: 70.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                "Food Intake Tracking",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),
              ),
              background: Image.network(
                "https://static.vecteezy.com/system/resources/previews/000/171/284/original/free-hand-drawn-vector-nightscape-illustration.jpg",
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
                  HorizontalCardWidget(
                    title: "Food Intake Record",
                    description: "View all of your food record.",
                    svgSrc: "assets/icons/verify.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeListDone()),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Create New Food Record",
                    description: "Create a new food record.",
                    svgSrc: "assets/icons/add.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeAdd1()),
                        //MaterialPageRoute(builder: (context) => FoodIntakeAddTest()),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Update Pending Food Record",
                    description: "Update your existing food record.",
                    svgSrc: "assets/icons/edit.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeListPending()),
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
