import 'package:battle_me/enums/MessageSeenEnum.dart';
// import 'package:battle_me/enums/MessageSenderEnum.dart';
import 'package:battle_me/models/message.dart';

class Chats {
  String roomId;
  bool online;
  String nameUser;
  String urlPhotoUser;
  String lastMessage;
  String time;
  bool unSeenMessages;
  String unSeenMessagesCount;
  MessageSeenEnum messageSeenEnum;
  List<Message> messages;

  Chats({
    this.roomId,
    this.online,
    this.nameUser,
    this.urlPhotoUser,
    this.lastMessage,
    this.time,
    this.unSeenMessages = false,
    this.unSeenMessagesCount,
    this.messageSeenEnum,
    this.messages,
  });
}

// Sample Chat List

List<Chats> chatList = [
  Chats(
      lastMessage: 'this is a last message',
      roomId: 'wiehdsjue',
      messageSeenEnum: MessageSeenEnum.SEEN,
      nameUser: 'Ishan',
      online: true,
      time: '21:11',
      unSeenMessages: true,
      unSeenMessagesCount: '1',
      urlPhotoUser:
          'https://firebasestorage.googleapis.com/v0/b/cracknet-app.appspot.com/o/images%2Fprofile_pic.jpg?alt=media&token=c03d6b53-9286-4958-9e42-3262d6ad45c3',
      messages: [
        Message(
          mediaLink: null,
          message: 'Hello buddy! You are doing really a nice job!',
          time: '12:12',
          userId: 'friend',
          username: 'Ishan',
        ),
        Message(
            mediaLink: null,
            message: 'Thanks for your kind words',
            time: '12:15',
            userId: 'rishabh',
            username: 'Rishabh')
      ]),
];
