import 'package:bundle_of_joy/widgets/baby_Growth_Widget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/chartWidgets/growthChart_Widget.dart';
import 'package:bundle_of_joy/widgets/loadingWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class GrowthTrackHeightView extends StatefulWidget {
  final String selectedBabyID;
  final CollectionReference collectionReference;
  GrowthTrackHeightView({Key key, @required this.selectedBabyID, @required this.collectionReference}) : super(key: key);

  @override
  _GrowthTrackHeightViewState createState() => _GrowthTrackHeightViewState();
}

class _GrowthTrackHeightViewState extends State<GrowthTrackHeightView> {
  final User user = FirebaseAuth.instance.currentUser;
  String listFirstElement;
  List ageListString = [];
  List growthValueList = [];
  List<int> ageListInt = [];

  @override
  Widget build(BuildContext context) {
    //CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(user.uid)
    //.collection("baby").doc(widget.selectedBabyID).collection("baby_growth");
    double fontSizeText = MediaQuery.of(context).size.width * 0.04;
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Baby Height Tracking",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            shadows: <Shadow>[Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4))],
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: widget.collectionReference.orderBy("bg_month", descending: false).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isNotEmpty) {
              snapshot.data.docs.forEach((doc) {
                ageListInt.add(int.parse(doc.data()["bg_month"].toString()));
                ageListString.add(doc.data()["bg_month"].toString());
                growthValueList.add(double.parse(doc.data()["bg_height"].toString()));
              });
              listFirstElement = ageListString[0];
              List<GrowthChartData> chartData = [
                for (var x in zip([ageListString, growthValueList]))
                  GrowthChartData(
                    month: x[0],
                    growthValue: x[1],
                    barColor: charts.ColorUtil.fromDartColor(appbar2),
                  ),
              ];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          top: 18.0,
                          left: 13.0,
                        ),
                        child: Text(
                          "Baby Height",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      BabyGrowthWidget(
                        graphTitle: "Height Record Graph",
                        graphDesc: "This section display the height record of your baby. The record is presented to you in bar" + " chart to help you visualize baby's height record in a compact and precise format.",
                        tableTitle: "Height Record Table",
                        tableDesc: "This section display the height record of your baby and all of your baby's height records " + "are being presented to you in table form.",
                        svgSrcGraph: "assets/icons/graph.svg",
                        svgSrcTable: "assets/icons/table.svg",
                        chartData: chartData,
                        listFirstElement: listFirstElement,
                        ageListInt: ageListInt,
                        growthValueList: growthValueList,
                        xAxisLabel: "Months (M)",
                        yAxisLabel: "Height (cm)",
                        measurement: "cm",
                        tableMeasurement: "Height (cm)",
                        growthTrack: false,
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  "There is currently no records",
                ),
              );
            }
          } else if (snapshot.hasError) {
            print("error");
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
