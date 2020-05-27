// import 'package:battle_me/enums/MessageSenderEnum.dart';

class Message {
  final String message;
  final String userId;
  final String username;
  final String mediaLink;
  // final MessageSenderEnum messageSenderEnum;
  final String time;

  Message({
    this.message,
    // this.messageSenderEnum,
    this.time,
    this.mediaLink,
    this.userId,
    this.username,
  });
}
