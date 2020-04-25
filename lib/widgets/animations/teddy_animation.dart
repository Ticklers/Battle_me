import 'package:battle_me/helpers/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class TeddyAnimation extends StatefulWidget {
  final String animation;
  TeddyAnimation(this.animation);
  @override
  _TeddyAnimationState createState() => _TeddyAnimationState();
}

class _TeddyAnimationState extends State<TeddyAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getViewportHeight(context) * 0.3,
      child: FlareActor(
        "assets/flare/Teddy.flr",
        animation: widget.animation,
        fit: BoxFit.contain,
      ),
    );
  }
}
