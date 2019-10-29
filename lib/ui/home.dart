import "package:flutter/material.dart";
import 'package:flutter_web_test/utils/functions.dart';

import 'animated_tab_bar/animated_tab_bar.dart';

class Home extends StatefulWidget {
  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Portfolio",
      iconData: Icons.camera_alt,
      color: Colors.pinkAccent,
    ),
    BarItem(
      text: "Projects",
      iconData: Icons.folder_open,
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: "About",
      iconData: Icons.person_outline,
      color: Colors.teal,
    ),
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double _screenSize = 0;
  int selectedBarIndex = 0;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() => _screenSize = screenWidth(context: context));

    return OrientationBuilder(
      builder: (context, orientation) =>
          (orientation == Orientation.portrait || _screenSize <= 600)
              ? _buildVerticalLayout()
              : _buildHorizontalLayout(),
    );
  }

  _buildVerticalLayout() {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
              child: Center(
                child: Text("Hello, web! $selectedBarIndex"),
              ),
            ),
            Material(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: AnimatedTabBar(
                    barItems: widget.barItems,
                    animationDuration: const Duration(milliseconds: 150),
                    barStyle: BarStyle(fontSize: 16.0, iconSize: 20.0),
                    onBarTap: (index) {
                      setState(() {
                        selectedBarIndex = index;
                      });
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildHorizontalLayout() {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey
              ),
              child: Center(
                child: Text("Hello, web! $selectedBarIndex"),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      right: 8.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: AnimatedTabBar(
                        barItems: widget.barItems,
                        animationDuration: const Duration(milliseconds: 150),
                        barStyle: BarStyle(fontSize: 16.0, iconSize: 24.0),
                        onBarTap: (index) {
                          setState(() {
                            selectedBarIndex = index;
                          });
                        }
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
