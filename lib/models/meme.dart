import 'package:flutter/cupertino.dart';

class Meme {
  final String user;
  final String memeId;
  final String date;
  final String caption;
  // final String media;
  final List<dynamic> likes;
  final List<dynamic> comments;
  Meme({
    @required this.user,
    @required this.memeId,
    @required this.date,
    @required this.caption,
    // @required this.media,
    @required this.likes,
    @required this.comments,
  });
}
