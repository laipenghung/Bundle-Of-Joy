import "package:flutter/material.dart";

class BabyFoodIntakeMain extends StatefulWidget {
  @override
  _BabyFoodIntakeMainState createState() => _BabyFoodIntakeMainState();
}

class _BabyFoodIntakeMainState extends State<BabyFoodIntakeMain> {
  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/menu.png",
                          height: 70,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Food Intake Record",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
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
                //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => FoodIntakeListDone()),
                //);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/add.png",
                          height: 65,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Add Record",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
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
                //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => FoodIntakeAdd1()),
                //);
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: myBoxDecoration(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/icons/pending.png",
                          height: 70,
                        ),
                      ),
                      Container(
                        child: Text(
                          "Pending Record",
                          style: TextStyle(
                            fontFamily: 'Comfortaa',
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
                //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context) => FoodIntakeListPending()),
                //);
              },
            ),
          ],
        ),
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
