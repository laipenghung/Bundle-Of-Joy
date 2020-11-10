import "package:bundle_of_joy/vaccinationAndGrowth/growth/growthHeight.dart";
import "package:bundle_of_joy/vaccinationAndGrowth/growth/growthWeight.dart";
import "package:flutter/material.dart";

class GrowthMain extends StatefulWidget {
  final String selectedBabyID;
  GrowthMain({Key key, this.selectedBabyID}) : super(key: key);

  @override
  _GrowthMain createState() => _GrowthMain(selectedBabyID);
}

class _GrowthMain extends State<GrowthMain> {
  final String selectedBabyID;
  _GrowthMain(this.selectedBabyID);

  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: myBoxDecoration(),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        "assets/icons/length.png",
                        height: 90,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Height Graph",
                        style: TextStyle(
                          fontFamily: "Comfortaa",
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
                MaterialPageRoute(builder: (context) => GrowthHeight(selectedBabyID: selectedBabyID)),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: myBoxDecoration(),
            child: InkWell(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        "assets/icons/weight.png",
                        height: 80,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Weight Graph",
                        style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GrowthWeight(selectedBabyID: selectedBabyID)),
                );
              },
            ),
          ),
        ],
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
