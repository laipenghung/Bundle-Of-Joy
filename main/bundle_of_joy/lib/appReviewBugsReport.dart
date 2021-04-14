import 'dart:developer';

import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import 'package:bundle_of_joy/widgets/horizontalCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppReviewBugsReport extends StatefulWidget {
  @override
  _AppReviewBugsReportState createState() => _AppReviewBugsReportState();
}

class _AppReviewBugsReportState extends State<AppReviewBugsReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(
          "App Review & Bugs Report",
          style: TextStyle(
            shadows: <Shadow>[
              Shadow(offset: Offset(2.0, 2.0), blurRadius: 5.0, color: Colors.black.withOpacity(0.4)),
            ],
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.white,
          ),
        ),
        backgroundColor: appbar3,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              HorizontalCardWidgetStyle2(
                title: "Review Bundle of Joy App",
                description: "Provide developer your experience, feedbacks after using the app. Also feel free to " +
                  "provide us with suggestion on how we can improve the app.",
                svgSrc: "assets/icons/rating.svg",
                onTap: () => launch("https://docs.google.com/forms/d/e/1FAIpQLScOZvmrSwHfEYdxxfvnsSckXp6SAp3N0fclYRG_qr_EZz_B1g/viewform?usp=sf_link"),
              ),
              HorizontalCardWidgetStyle2(
                title: "Bugs And Errors Report",
                description: "Report all bugs and errors you found while using the Bundle of Joy mobile app.",
                svgSrc: "assets/icons/megaphone.svg",
                onTap: () => launch("https://docs.google.com/forms/d/e/1FAIpQLScOZvmrSwHfEYdxxfvnsSckXp6SAp3N0fclYRG_qr_EZz_B1g/viewform?usp=sf_link"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}