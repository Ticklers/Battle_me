import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/other_profile_screen.dart';
import 'package:battle_me/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progressive_image/progressive_image.dart';
// import 'package:progressive_image/progressive_image.dart';

class CommentTile extends StatefulWidget {
  final comment;
  final MainModel model;
  CommentTile(this.comment, this.model);
  @override
  _CommentTileState createState() => _CommentTileState(comment);
}

class _CommentTileState extends State<CommentTile> {
  final comment;
  _CommentTileState(this.comment);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.lightBlue,
      child: ListTile(
        leading: GestureDetector(
          onTap: () async {
            // print(comment["userId"]);
            // print(comment["userId"]);
            if (comment["userId"] != widget.model.getAuthenticatedUser.userId) {
              CircularProgressIndicator();
              await widget.model.findUser(comment["userId"]).then(
                (user) {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: OtherProfileScreen(widget.model, user),
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                },
              );
            } else {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: ProfileScreen(widget.model),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ProgressiveImage.assetNetwork(
                placeholder: 'assets/images/wallpaper.jpg', // gifs can be used
                thumbnail: comment['avatar'],
                image: comment['avatar'],
                height: getViewportHeight(context) * 0.05,
                width: getViewportHeight(context) * 0.05,
              ),
            ),
          ),
        ),
        title: Text(widget.comment["username"]),
        subtitle: Text(widget.comment["comment"]),
      ),
    );
  }
}
