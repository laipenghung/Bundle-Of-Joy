import 'package:bundle_of_joy/vaccinationAndGrowth/growth/growthTrackHeightView.dart';
import 'package:bundle_of_joy/vaccinationAndGrowth/growth/growthTrackWeightView.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'growth/growthHeight.dart';
import 'growth/growthWeight.dart';
import 'vaccination/vaccination.dart';

class VaccinationGrowthMain extends StatefulWidget {
  final String selectedBabyID;
  VaccinationGrowthMain({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _VaccinationGrowthMainState createState() => _VaccinationGrowthMainState();
}

class _VaccinationGrowthMainState extends State<VaccinationGrowthMain> {
  final User user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(user.uid)
      .collection("baby").doc(widget.selectedBabyID).collection("baby_growth");
      
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
            backgroundColor: appbar2,
            stretchTriggerOffset: 100.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              title: Text(
                "Vaccination & Growth",
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
                  //Baby Vaccination Tracking
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    //padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                    child: Text(
                      "Baby Vaccination Tracking",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  HorizontalCardWidget(
                      title: "Baby Vaccination Records",
                      description: "View all vaccines that that took by your baby.",
                      svgSrc: "assets/icons/records.svg",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Vaccination(selectedBabyID: widget.selectedBabyID)),
                        );
                      }),
                  //Baby Growth Tracking
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    //padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(15, 20, 10, 5),
                    child: Text(
                      "Baby Growth Tracking",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  HorizontalCardWidget(
                      title: "Baby Height Tracking",
                      description: "View your baby height record.",
                      svgSrc: "assets/icons/height.svg",
                      press: () {
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => GrowthHeight(selectedBabyID: widget.selectedBabyID)),
                          MaterialPageRoute(builder: (context) => GrowthTrackHeightView(
                            selectedBabyID: widget.selectedBabyID,
                            collectionReference: collectionReference,
                          )),
                        );
                      }),
                  HorizontalCardWidget(
                      title: "Baby Weight Tracking",
                      description: "View your baby weight record.",
                      svgSrc: "assets/icons/weight.svg",
                      press: () {
                        Navigator.push(
                          context,
                          //MaterialPageRoute(builder: (context) => GrowthWeight(selectedBabyID: widget.selectedBabyID)),
                          MaterialPageRoute(builder: (context) => GrowthTrackWeightView(
                            selectedBabyID: widget.selectedBabyID,
                            collectionReference: collectionReference,
                          )),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
