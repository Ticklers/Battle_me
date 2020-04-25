import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/widgets/animations/teddy_animation.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String animation;
  @override
  void initState() {
    animation = 'idle';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Hero(
                  tag: "icon",
                  child: Container(
                    height: getDeviceHeight(context) * 0.15,
                    width: getDeviceWidth(context) * 0.15,
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: getViewportHeight(context) * 0.1),
                  TeddyAnimation(animation),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: getViewportHeight(context) * 0.55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset.fromDirection(1.7))
                        ],
                      ),
                      child: Card(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
