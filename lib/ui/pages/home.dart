import 'package:flutter/material.dart';
import 'package:flutter_parallax/flutter_parallax.dart';
import 'package:flutter_web_test/ui/components/icon_bar.dart';
import 'package:flutter_web_test/utils/custom_icons.dart';
import 'dart:html' as html;

import 'package:flutter_web_test/utils/functions.dart';
import 'package:flutter_web_test/utils/list_animation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ListAnimation _listAnimation;

  double _screenSize = 0, _offset = -10;

  @override
  void initState() {
    _controller = new AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _listAnimation = new ListAnimation(
      controller: _controller,
      items: 3,
    );
    _controller.forward();
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
    return AnimatedBuilder(
      builder: (context, child) => _buildPage(context, child),
      animation: _controller,
    );
  }

  Widget _buildPage(BuildContext context, Widget child) {
    bool isPortrait = (/*orientation == Orientation.portrait || */screenWidth(context: context) <= 600);
    return OrientationBuilder(
      builder: (context, orientation) => Container(
        height: screenHeight(context: context)*3/4,
        width: screenWidth(context: context),
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: _listAnimation.animations.map((a) => a.value * 1 / _listAnimation.animations.length).fold(0, (p, c) => p + c),
              child: Parallax.inside(
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/portfolio-49b69.appspot.com/o/Nature%2FLandscapes%2F(Canon%20EOS%2077D)%202019_10_15%2007_18_05-Edited%20(Web)_.jpg?alt=media&token=73c5f2d7-8409-4563-a46e-be2e22d28f67",
                  fit: BoxFit.cover,
                  width: screenWidth(context: context),
                  height: screenHeight(context: context)*3/4,
                ),
                mainAxisExtent: screenHeight(context: context)*3/4,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, _offset + (-_listAnimation.animations[0].value * _offset)),
                    child: Opacity(
                      opacity: _listAnimation.animations[0].value,
                      child: _buildTitle(isPortrait),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, _offset + (-_listAnimation.animations[1].value * _offset)),
                    child: Opacity(
                      opacity: _listAnimation.animations[1].value,
                      child: _buildSubtitle(isPortrait),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, _offset + (-_listAnimation.animations[2].value * _offset)),
                    child: Opacity(
                      opacity: _listAnimation.animations[2].value,
                      child: buildIconBar(),
                    ),
                  ),
                ],
              ),
            ),
            /*Align(
              alignment: Alignment.topLeft,
              child: Text("${screenWidth(context: context)} x ${screenHeight(context: context)} ${isPortrait ? "Vertical" : "Horizontal"}"),
            ),*/
          ],
        ),
      ),
    );
  }

  _buildTitle(bool isPortrait) => RichText(
    text: TextSpan(
      text: "Hi, I'm Howard!",
      style: Theme.of(context).textTheme.title.copyWith(
          fontSize: isPortrait ? 46 : 56
      ),
    ),
  )/*Container(
    height: 200,
    width: 200,
    child: Stack(
      children: <Widget>[
        Image.asset(
          'images/logo.png',
          color: Colors.black,
        ),
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    ),
  )*/;
  _buildSubtitle(bool isPortrait) => RichText(
    text: TextSpan(
      text: "A Flutter Developer and Photographer",
      style: Theme.of(context).textTheme.title.copyWith(
          fontSize: isPortrait ? 14 : 18
      ),
    ),
  );
}

buildIconBar({bool hover = true}) => Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Padding(
      padding: EdgeInsets.all(12.0),
      child: IconBarButton(
        hover: hover,
        iconData: CustomIcons.facebook_squared,
        url: "https://www.facebook.com/howardt12345page",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(12.0),
      child: IconBarButton(
        hover: hover,
        iconData: CustomIcons.instagram,
        url: "https://www.instagram.com/howardt12345",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(12.0),
      child: IconBarButton(
        hover: hover,
        iconData: CustomIcons.github_circled,
        url: "https://www.github.com/howardt12345",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(12.0),
      child: IconBarButton(
        hover: hover,
        iconData: CustomIcons.linkedin_squared,
        url: "https://www.linkedin.com/in/howardt12345",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(12.0),
      child: IconBarButton(
        hover: hover,
        iconData: CustomIcons.redbubble,
        url: "http://howardt12345.redbubble.com/",
      ),
    ),
  ],
);

buildIconInfoBar() => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Padding(
      padding: EdgeInsets.all(4.0),
      child: IconButtonInfo(
        iconData: CustomIcons.facebook_squared,
        url: "https://www.facebook.com/howardt12345page",
        title: "Facebook",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(4.0),
      child: IconButtonInfo(
        iconData: CustomIcons.instagram,
        url: "https://www.instagram.com/howardt12345",
        title: "Instagram",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(4.0),
      child: IconButtonInfo(
        iconData: CustomIcons.github_circled,
        url: "https://www.github.com/howardt12345",
        title: "Github",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(4.0),
      child: IconButtonInfo(
        iconData: CustomIcons.linkedin_squared,
        url: "https://www.linkedin.com/in/howardt12345",
        title: "LinkedIn",
      ),
    ),
    Padding(
      padding: EdgeInsets.all(4.0),
      child: IconButtonInfo(
        iconData: CustomIcons.redbubble,
        url: "http://howardt12345.redbubble.com/",
        title: "RedBubble",
      ),
    ),
  ],
);

buildCopyrightText() => Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    Container(height: 8.0,),
    SizedBox(
      height: 8.0,
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 0.5, end: 0.5),
          height: 1.0,
          color: Colors.grey,
        ),
      ),
    ),
    Text(
      "© 2019 Howard Tseng, All rights reserved.\nWebsite written in Flutter for Web.",
      textAlign: TextAlign.center,
    ),
    Container(height: 8.0,)
  ],
);