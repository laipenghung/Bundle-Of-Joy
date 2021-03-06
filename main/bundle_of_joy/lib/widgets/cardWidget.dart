import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const CardWidget({
    Key key,
    this.svgSrc,
    this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 50,
              spreadRadius: 23,
              color: Color(0xFF878787),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  SvgPicture.asset(svgSrc, height: 85, width: 85,),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}