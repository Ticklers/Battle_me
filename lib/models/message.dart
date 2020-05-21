import 'package:flutter/cupertino.dart';

class Meme {
  final String userId;
  final String date;
  final String text;
  final String username;
  final String avatar;
  final String mediaLink;
  Meme({
    @required this.username,
    @required this.userId,
    @required this.avatar,
    @required this.date,
    @required this.mediaLink,
    @required this.text,
  });
}
