import 'package:battle_me/helpers/dimensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-0.8, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Stack(children: <Widget>[
            SlideTransition(
              position: _offsetAnimation,
              child: Container(
                alignment: Alignment.topCenter,
                child: Hero(
                  tag: "icon",
                  child: Container(
                    height: getDeviceHeight(context) * 0.60,
                    width: getDeviceWidth(context) * 0.60,
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: getViewportHeight(context) * 0.6),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Meme Battle',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Manrope",
                          fontSize: getDeviceHeight(context) * 0.06,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getDeviceHeight(context) * 0.05),
                    Text(
                      '"Why so serious ?"',
                      style: TextStyle(
                          fontFamily: "Ubuntu",
                          color: Colors.white,
                          fontSize: getDeviceHeight(context) * 0.03),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ]),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
