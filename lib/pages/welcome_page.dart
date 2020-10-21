import 'dart:async';

import 'package:flutter/material.dart';
import 'package:takuonline/components/constants.dart';
import 'menu_page.dart';

class WelcomePage extends StatefulWidget {
  static const id = 'WelcomePage';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController _controller;
//  Animation imageAnimation;

  Animation<Offset> slideAnimation;
  Animation<Offset> slideAnimation2;
  Animation<Offset> btnSlideAnimation3;

  Animation<Color> colorAnimation;

  Animation fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward();

    slideAnimation = Tween<Offset>(
      begin: Offset(.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, .5, curve: Curves.easeOut),
    ));

    slideAnimation2 = Tween<Offset>(
      begin: Offset(-.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, .5, curve: Curves.easeOut),
    ));

    btnSlideAnimation3 = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(.5, .7, curve: Curves.ease),
    ));

//    colorAnimation = Tween<Color>(
//      begin: Colors.white,
//      end: kPrimaryColor,
//    ).animate(CurvedAnimation(
//      parent: _controller,
//      curve: Interval(0, .2, curve: Curves.easeOut),
//    ));


    fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Interval(0, .3, curve: Curves.easeIn),
    );

    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:   EdgeInsets.only(
                      left: screenHeight*.05, top: screenHeight*.1, right: screenHeight*.05, bottom: screenHeight*.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Taku-online",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                          height:
                          screenHeight*.07
                      ),
                      SlideTransition(
                        position: slideAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: Text("Live  ",
                              style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize:  screenHeight*.1
                              ),

                          ),
                        ),
                      ),
                      SlideTransition(
                        position: slideAnimation2,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: Text("smart  ",
                              style: Theme.of(context).textTheme.headline2.copyWith(
                                  fontSize:  screenHeight*.125
                              ),),
                        ),
                      ),
                      SlideTransition(
                        position: slideAnimation,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: Text("be  ",
                              style: Theme.of(context).textTheme.headline1.copyWith(
                                  fontSize:  screenHeight*.1
                              ),),
                        ),
                      ),
                      SlideTransition(
                        position: slideAnimation2
                        ,
                        child: FadeTransition(
                          opacity: fadeAnimation,
                          child: Text("stylish  ",
                              style: Theme.of(context).textTheme.headline2.copyWith(
                                  fontSize:  screenHeight*.125
                              ),),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height:
                      screenHeight*.07
                ),

                SlideTransition(
                  position: btnSlideAnimation3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, MenuPage.id);
                      },
                      child: Container(
                        width: screenWidth*.6,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(200),
                                bottomLeft: Radius.circular(200))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Start",
                                  style: Theme.of(context).textTheme.headline5),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
