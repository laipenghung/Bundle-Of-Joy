import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quiver/iterables.dart';

class RecordListWidget extends StatelessWidget {
  final String svgSrc;
  final List foodName;
  final List foodQty;

  
  const RecordListWidget({
    Key key,
    this.svgSrc,
    this.foodName,
    this.foodQty,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(15, 15),
              blurRadius: 20,
              spreadRadius: 15,
              color: Color(0xFFE6E6E6),
            ),
          ],),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(svgSrc, height: 23, width: 23,),
                Container(
                  padding: EdgeInsets.only(left: 8.0,),
                  child: Text(
                    "Food",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0,),
              child: Text(
                "Food that you consumed.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: Colors.black.withOpacity(0.65),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10.0),
              child: Table(
                children: [
                  //for(var x in foodName)
                  for (var x in zip([foodName, foodQty]))
                  TableRow(
                    children: [
                      TableCell(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              child: Text(
                                x[0].toString(),
                                //"Food name 1",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "x " + x[1].toString() + " MEASUREMENT",
                                //"Food name 1",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.black.withOpacity(0.65),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}