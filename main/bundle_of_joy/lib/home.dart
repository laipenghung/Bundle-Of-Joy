import 'package:bundle_of_joy/userProfile.dart';
import 'package:bundle_of_joy/widgets/genericWidgets.dart';
import "package:flutter/material.dart";
import 'mother_for_baby.dart';
import 'mother_to_be.dart';
import "package:persistent_bottom_nav_bar/persistent-tab-view.dart";
import "package:flutter/services.dart";

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageState(),
    );
  }
}

class HomePageState extends StatefulWidget {
  final String title;
  HomePageState({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageState> {
  String _title;
  PersistentTabController _persistentTabController;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); // SHOW STATUS BAR
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]); // HIDE STATUS BAR

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // STATUS BAR COLOR
        statusBarColor: Colors.transparent));

    _title = "Mother-to-be";
    _persistentTabController = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _widgetOptions() {
    return <Widget>[
      MotherToBeHome(), //[1] //MotherToBeTab() <- Old mother to be screen
      //MotherForBabyTab(), //[2] <- Old mother to be screen
      MotherForBabyHome(), //[3] <- New  mother to be screen
      //ProfileTab(), //[4] <- Old Profile screen
      UserProfile(), //[4] <- New Profile screen
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        contentPadding: 0,
        icon: Image.asset("assets/icons/pregnant.png"),
        title: ("Mother-to-be"),
        //activeColor: Colors.black,
        //activeColor: Color(0xFFff713a),
        activeColor: titleColor,
        inactiveColor: Colors.black.withOpacity(0.3),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/baby.png"),
        title: ("Mother-for-baby"),
        //activeColor: Colors.black,
        //activeColor: Color(0xFFff713a),
        activeColor: titleColor,
        inactiveColor: Colors.black.withOpacity(0.3),
      ),
      //PersistentBottomNavBarItem(icon: Image.asset("assets/icons/bell.png"), title: ("Test"), activeColor: Colors.black, inactiveColor: Colors.black.withOpacity(0.3)),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/icons/user.png"),
        title: ("Profile"),
        //activeColor: Colors.black,
        //activeColor: Color(0xFFff713a),
        activeColor: titleColor,
        inactiveColor: Colors.black.withOpacity(0.3),
      )
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            _title = "Mother-to-be";
          }
          break;
        case 1:
          {
            _title = "Mother-for-baby";
          }
          break;
        // case 2:
        //   {
        //     _title = "Notification";
        //   }
        //   break;
        case 2: //Was 3
          {
            _title = "Profile";
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      navBarHeight: MediaQuery.of(context).size.height * 0.1,
      padding: NavBarPadding.all(4),
      decoration: NavBarDecoration(
        //borderRadius: BorderRadius.circular(10.0),
        //colorBehindNavBar: Colors.white,
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.black.withOpacity(0.3)),
          //bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
        ),
      ),
      controller: _persistentTabController,
      screens: _widgetOptions(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      //backgroundColor: Color(0xFFdcdcdc),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      stateManagement: true,
      resizeToAvoidBottomInset: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle: NavBarStyle.style3,
      onItemSelected: (index) => _onItemTapped(index),
    );
  }
}
