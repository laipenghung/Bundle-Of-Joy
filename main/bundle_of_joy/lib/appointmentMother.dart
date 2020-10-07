import "package:flutter/material.dart";

class AppointmentMother extends StatefulWidget {
  @override
  _AppointmentMotherState createState() => _AppointmentMotherState();
}

class _AppointmentMotherState extends State<AppointmentMother> {
  // BUILD THE WIDGET
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
      appBar: AppBar(
        title: Text(
          "Appointment Management",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.black,
          ),
        ),

        automaticallyImplyLeading: false, // CENTER THE TEXT
        backgroundColor: Color(0xFFFCFFD5),
        centerTitle: true,
      ),

      // BODY
      body: SingleChildScrollView( // ENABLE SCROLLING IF CONTENT TOO LONG
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),

            InkWell(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CONTAINER 1
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://kuchingborneo.info/wp-content/uploads/2017/03/KPJ-Kuching-Medical-Centre.jpg"),
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10, bottom: 30),   
                          child: Text(
                            "Hospital 1",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Image.asset(
                                "assets/icons/hospitalNum.png",
                                height: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                "082 - 507236",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              onTap: () {
                print("tapped on container 1");
              },
            ),

            SizedBox(height: 15),

            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.black,
              thickness: 1,
            ),

            SizedBox(height: 15),

            InkWell(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CONTAINER 2
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://kuchingborneo.info/wp-content/uploads/2017/03/KPJ-Kuching-Medical-Centre.jpg"),
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10, bottom: 30),
                          child: Text(
                            "Hospital 2",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Image.asset(
                                "assets/icons/hospitalNum.png",
                                height: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                "082 - 507236",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              onTap: () {
                print("tapped on container 1");
              },
            ),

            SizedBox(height: 15),

            Divider(
              indent: 20,
              endIndent: 20,
              color: Colors.black,
              thickness: 1,
            ),

            SizedBox(height: 15),

            InkWell(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // CONTAINER 3
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://kuchingborneo.info/wp-content/uploads/2017/03/KPJ-Kuching-Medical-Centre.jpg"),
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10, bottom: 30),
                          child: Text(
                            "Hospital 3",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Image.asset(
                                "assets/icons/hospitalNum.png",
                                height: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 15,
                              ),
                              child: Text(
                                "082 - 507236",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              onTap: () {
                print("tapped on container 1");
              },
            ),

          ],
        ),
      ),
    );
  }
}
