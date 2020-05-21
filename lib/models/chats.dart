import 'package:battle_me/enums/MessageSeenEnum.dart';
import 'package:battle_me/enums/MessageSenderEnum.dart';
import 'package:battle_me/models/message.dart';

class Chats {
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
    this.online = false,
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
      online: true,
      nameUser: "Urgot",
      urlPhotoUser:
          "https://www.esportspedia.com/lol/images/8/88/UrgotSquare.png",
      lastMessage: "Have you ever heard about Flutter?",
      time: "20:09",
      unSeenMessages: false,
      messageSeenEnum: MessageSeenEnum.NOT_SEEN,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: false,
      nameUser: "Illaoi",
      urlPhotoUser:
          "https://www.mobafire.com/images/social/build-card/illaoi.jpg",
      lastMessage: "Hi, how are you?",
      time: "15:23",
      unSeenMessages: false,
      messageSeenEnum: MessageSeenEnum.SEEN,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Akali",
      urlPhotoUser:
          "https://revolutionnow.com.br/wp-content/uploads/2018/07/jessica-oyhenart-akali-splash-closeup-1.jpg",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Pantheon",
      urlPhotoUser:
          "https://image.redbull.com/rbcom/052/2019-08-13/5a3f60a1-f6de-4fd6-bf6d-125fff1096d4/0012/0/0/792/1440/1944/1150/1/league-of-legends-pantheon.jpg",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Senna",
      urlPhotoUser:
          "https://observatoriodegames.bol.uol.com.br/wp-content/uploads/2019/10/LoL-Senna.png",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Jhin",
      urlPhotoUser:
          "https://www.mobafire.com/images/social/build-card/jhin.jpg",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Orianna",
      urlPhotoUser:
          "https://www.mobafire.com/images/social/build-card/orianna.jpg",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Zed",
      urlPhotoUser: "https://www.mobafire.com/images/avatars/zed-classic.png",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
  Chats(
      online: true,
      nameUser: "Ekko",
      urlPhotoUser:
          "https://www.maisesports.com.br/wp-content/uploads/2019/10/ekko-true-damage.jpg",
      lastMessage: "Flutter is amazing!! OMG",
      time: "12:40",
      unSeenMessages: true,
      unSeenMessagesCount: "10",
      messageSeenEnum: MessageSeenEnum.NONE,
      messages: [
        Message(
            message: "Hi, how are you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "Heey",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm fine, and you?",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.USER),
        Message(
            message: "I'm feeling great",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message: "I need tell you something great that happened to me",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
        Message(
            message:
                "Next month I'm going to São Paulo for a Flutter event. There will be a lot of interesting people there!!",
            time: "12:39",
            messageSenderEnum: MessageSenderEnum.FRIEND),
      ]),
];
