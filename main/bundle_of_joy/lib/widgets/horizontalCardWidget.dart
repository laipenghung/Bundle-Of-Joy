import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HorizontalCardWidget extends StatelessWidget {
  final String svgSrc;
  final String title;
  final String description;
  final Function press;
  const HorizontalCardWidget({
    Key key,
    this.svgSrc,
    this.title,
    this.description,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23,
            spreadRadius: -13,
            color: Color(0xFFE6E6E6),
          ),
        ],
      ),
      child: InkWell(
        onTap: press,
        child: Row(
          children: <Widget>[
            SizedBox(width: 20),
            SvgPicture.asset(svgSrc, height: 50, width: 50),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.033,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.65),
                    )
                  )
                ],
              ),
            ),
            //Padding(
              //padding: EdgeInsets.all(10),
              //child: SvgPicture.asset("assets/icons/Lock.svg"),
            //),
          ],
        ),
      ),
    );
  }
}