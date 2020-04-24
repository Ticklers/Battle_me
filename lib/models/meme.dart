import 'package:battle_me/models/user.dart';
import 'package:flutter/cupertino.dart';

class Meme {
  final User author;
  final String memeId;
  final String date;
  final String caption;
  final String media;
  final Map<dynamic, dynamic> like;
  final Map<dynamic, dynamic> comments;
  Meme({
    @required this.author,
    @required this.memeId,
    @required this.date,
    @required this.caption,
    @required this.media,
    @required this.like,
    @required this.comments,
  });
}
