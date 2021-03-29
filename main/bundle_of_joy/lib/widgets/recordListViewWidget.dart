import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecordListViewWidget extends StatelessWidget {
  final String svgSrc;
  final String recordDate;
  final String recordTime;
  final Function press;
  final Function delete;
  const RecordListViewWidget({
    Key key,
    this.svgSrc,
    this.recordDate,
    this.recordTime,
    this.press,
    this.delete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(15, 15),
            blurRadius: 20,
            spreadRadius: 15,
            color: Color(0xFFE6E6E6),
          ),
        ],
      ),
      child: InkWell(
        onTap: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                child: Center(
                  child: SvgPicture.asset(svgSrc, height: 40, width: 40),
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Text(
                        recordDate,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        recordTime,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                          //color: Colors.black.withOpacity(0.65),
                        )
                      ),
                    ),
                  ],
                ),
              )
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Colors.black.withOpacity(0.65),), 
                    onPressed: () {
                      
                    }
                  )
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red,), 
                    onPressed: delete,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}