import 'package:battle_me/helpers/dimensions.dart';
// import 'package:battle_me/models/meme.dart';
import 'package:flutter/material.dart';

class MemeCard extends StatelessWidget {
  // final Meme meme;
  static double viewportHeight;
  static double viewportWidth;

  // MemeCard({@required this.meme});

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      margin: EdgeInsets.symmetric(
          horizontal: viewportWidth * 0.001, vertical: viewportHeight * 0.005),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.white54,
        onTap: () {},
        child: ListTile(
          title: Container(
              height: viewportHeight * 0.2,
              child: Image.asset('assets/images/icon.png')),
          subtitle: Text(
            'Rishabh Sharma',
            style: TextStyle(color: Colors.white),
          ),
          leading: Icon(
            Icons.accessibility_new,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
