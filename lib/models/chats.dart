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
  Chats(
      lastMessage: 'this is also last message',
      messageSeenEnum: MessageSeenEnum.RECEIVED,
      roomId: 'wiehdheue',
      nameUser: 'Rachit',
      online: false,
      time: '11:11',
      unSeenMessages: false,
      unSeenMessagesCount: '10',
      urlPhotoUser:
          'https://firebasestorage.googleapis.com/v0/b/cracknet-app.appspot.com/o/images%2Fprofile_pic.jpg?alt=media&token=c03d6b53-9286-4958-9e42-3262d6ad45c3',
      messages: [
        Message(
            mediaLink: null,
            message: 'Aur mere bhai kaisa h?',
            time: '12:11',
            userId: 'friend',
            username: 'Rachit')
      ])
];

// List<Chats> chatList = [
//   Chats(
//       online: true,
//       nameUser: "Urgot",
//       urlPhotoUser:
//           "https://www.esportspedia.com/lol/images/8/88/UrgotSquare.png",
//       lastMessage: "Have you ever heard about Flutter?",
//       time: "20:09",
//       unSeenMessages: false,
//       messageSeenEnum: MessageSeenEnum.NOT_SEEN,
//       messages: [
//         Message(
//             message: "Hi, how are you?",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//         Message(
//             message: "Heey",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.USER),
//         Message(
//             message: "I'm fine, and you?",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.USER),
//         Message(
//             message: "I'm feeling great",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//         Message(
//             message: "I need tell you something great that happened to me",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//         Message(
//             message:
//                 "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//       ]),
//   Chats(
//       online: false,
//       nameUser: "Illaoi",
//       urlPhotoUser:
//           "https://www.mobafire.com/images/social/build-card/illaoi.jpg",
//       lastMessage: "Hi, how are you?",
//       time: "15:23",
//       unSeenMessages: false,
//       messageSeenEnum: MessageSeenEnum.SEEN,
//       messages: [
//         Message(
//             message: "Hi, how are you?",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//         Message(
//             message: "Heey",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.USER),
//         Message(
//             message: "I'm fine, and you?",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.USER),
//         Message(
//             message: "I'm feeling great",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//         Message(
//             message: "I need tell you something great that happened to me",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//         Message(
//             message:
//                 "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
//             time: "12:39",
//             messageSenderEnum: MessageSenderEnum.FRIEND),
//       ]),
// ];
