import 'package:flutter/material.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';

import 'foodIntake_recordList_done.dart';

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
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Testing"),
              background: Image.network(
                "https://static.vecteezy.com/system/resources/previews/000/171/284/original/free-hand-drawn-vector-nightscape-illustration.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  HorizontalCardWidget(
                    title: "Testing",
                    description: "Testing for description Testing",
                    svgSrc: "assets/icons/Hamburger.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeListDone()),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Testing",
                    description: "Testing for description Testing",
                    svgSrc: "assets/icons/Hamburger.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeListDone()),
                      );
                    }
                  ),
                  HorizontalCardWidget(
                    title: "Testing",
                    description: "Testing for description Testing",
                    svgSrc: "assets/icons/Hamburger.svg",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FoodIntakeListDone()),
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