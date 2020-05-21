// import 'package:flutter/cupertino.dart';

// class Meme {
//   final String userId;
//   final String date;
//   final String text;
//   final String username;
//   final String avatar;
//   final String mediaLink;
//   Meme({
//     @required this.username,
//     @required this.userId,
//     @required this.avatar,
//     @required this.date,
//     @required this.mediaLink,
//     @required this.text,
//   });
// }

import 'package:battle_me/enums/MessageSenderEnum.dart';

class Message {
  final String message;
  final String userId;
  final String username;
  final String avatar;
  final String mediaLink;
  final MessageSenderEnum messageSenderEnum;
  final String time;

  Message({
    this.message,
    this.messageSenderEnum,
    this.time,
    this.avatar,
    this.mediaLink,
    this.userId,
    this.username,
  });
}
