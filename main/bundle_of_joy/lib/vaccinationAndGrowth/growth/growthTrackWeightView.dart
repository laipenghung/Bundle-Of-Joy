import 'package:bundle_of_joy/widgets/babyGrwothWidget.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/chartWidgets/growthChartWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GrowthTrackWeightView extends StatefulWidget {
  final String selectedBabyID;
  final CollectionReference collectionReference;
  GrowthTrackWeightView({Key key, @required this.selectedBabyID, @required this.collectionReference}) : super(key: key);

  @override
  _GrowthTrackWeightViewState createState() => _GrowthTrackWeightViewState();
}

class _GrowthTrackWeightViewState extends State<GrowthTrackWeightView> {
  final User user = FirebaseAuth.instance.currentUser;
  String listFirstElement;
  List ageListString = [];
  List growthValueList = [];
  List<int> ageListInt = [];

  @override
  Widget build(BuildContext context) {
    //CollectionReference collectionReference = FirebaseFirestore.instance.collection("mother").doc(user.uid)
    //.collection("baby").doc(widget.selectedBabyID).collection("baby_growth");

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "Baby Weight Tracking",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.045,
          ),
        ),
        backgroundColor: appbar2,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder<QuerySnapshot>(
          future: widget.collectionReference.orderBy("bg_month", descending: false).get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              snapshot.data.docs.forEach((doc) {
                ageListInt.add(int.parse(doc.data()["bg_month"].toString()));
                ageListString.add(doc.data()["bg_month"].toString());
                growthValueList.add(double.parse(doc.data()["bg_weight"].toString()));
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
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        top: 18.0,
                        left: 13.0,
                      ),
                      child: Text(
                        "Baby Weight",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    BabyGrowthWidget(
                      graphTitle: "Weight Record Graph",
                      graphDesc: "This section display the weight record of your baby. The record is presented to you in bar" + " chart to help you visualize baby's weight record in a compact and precise format.",
                      tableTitle: "Weight Record Table",
                      tableDesc: "This section display the weight record of your baby and all of your baby's weight records " + "are being presented to you in table form.",
                      svgSrcGraph: "assets/icons/graph.svg",
                      svgSrcTable: "assets/icons/table.svg",
                      chartData: chartData,
                      listFirstElement: listFirstElement,
                      ageListInt: ageListInt,
                      growthValueList: growthValueList,
                      xAxisLabel: "Months (M)",
                      yAxisLabel: "Weight (kg)",
                      measurement: "kg",
                      tableMeasurement: "Weight (kg)",
                      growthTrack: true,
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              print("error");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
