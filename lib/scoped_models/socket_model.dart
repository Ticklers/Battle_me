// import 'dart:convert';
import 'dart:async';
// import 'package:intl/intl.dart';

import 'package:battle_me/enums/MessageSeenEnum.dart';
import 'package:battle_me/models/chats.dart';
import 'package:battle_me/models/meme.dart';
import 'package:battle_me/models/message.dart';

import './connected_scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketModel extends ConnectedModel {
  IO.Socket mainNsSocket;
  IO.Socket get getMainNsSocket {
    return mainNsSocket;
  }

  void setSocket(IO.Socket socket) {
    mainSocket = socket;
  }

  void setNsSocket(IO.Socket nsSocket) {
    mainNsSocket = nsSocket;
  }

  void setFeedList(List<Meme> data) {
    meme_feed = data;
  }

  void setChats(List<Chats> chatList) {
    chats = chatList;
  }

  void socketClient(IO.Socket socket) {
    // print('Inside socketClient');
    // socket.on('connection', (_) {
    //   print('connect!!!!!!!!!!!!!!!');
    //   //  socket.emit('msg', 'test');
    // });
    socket.emit('getFeed');
    socket.on('memes', (data) {
      List<Meme> allMemes = [];
      // print('received Socket data: ${data["data"]["count"]}');
      data["data"]["memes"].forEach((dynamic memeData) {
        final Meme entry = Meme(
          memeId: memeData['_id'],
          name: memeData['name'],
          username: memeData['username'],
          avatar: memeData['avatar'],
          caption: memeData['caption'],
          user: memeData['user'],
          date: memeData['date'],
          comments: memeData['comments'],
          likes: memeData['likes'],
          mediaLink: memeData['mediaLink'],
          mediaHash: memeData['mediaHash'],
        );
        allMemes.add(entry);
      });
      setFeedList(allMemes);
      notifyListeners();
    });

    socket.on('newFeed', (data) {
      // print('NewFeed Triggered');
      // print(data);
      final Meme entry = Meme(
        memeId: data['_id'],
        name: data['name'],
        username: data['username'],
        avatar: data['avatar'],
        caption: data['caption'],
        user: data['user'],
        date: data['date'],
        comments: data['comments'],
        likes: data['likes'],
        mediaLink: data['mediaLink'],
        mediaHash: data['mediaHash'],
      );
      newFeed = true;
      meme_feed.insert(0, entry);
      notifyListeners();
    });
  }

  Future<Null> liveFeedFetch(IO.Socket socket) async {
    // print('Inside liveFeed fetch');

    socket.emit('getFeed');
    notifyListeners();
  }

  Future<Null> newPostAdd(IO.Socket socket, post) async {
    // print('Inside newPost add');
    final entry = {
      "memeId": "",
      "name": post['name'],
      "username": post['username'],
      "avatar": post['avatar'],
      "caption": post['caption'],
      "user": post['user'],
      "date": DateTime.now().toIso8601String(),
      "comments": post['comments'],
      "likes": post['likes'],
      "mediaLink": post['mediaLink'],
    };
    socket.emit('newFeed', entry);
    notifyListeners();
  }

  Future<Null> joinNs(String endpoint) async {
    if (getMainNsSocket != null) {
      mainNsSocket.on('reconnect', (data) {
        // print('Reconnect ho gya!!!!!!!!!!!!!');
      });
      // print('NsSocket closed : $mainNsSocket');
      mainNsSocket.close();
      // mainNsSocket = null;
      setNsSocket(null);
      // print(mainNsSocket);
    }
    // print('Inside joinNs : ${endpoint}');
    IO.Socket nsSocket =
        IO.io('http://192.168.43.197:5000${endpoint}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    // nsSocket.connect();
    // mainNsSocket = nsSocket;
    setNsSocket(nsSocket);
    await nsSocket.on('chatRoomsList', (chatRooms) {
      // print('chatRoomList Data length:  ${chats.length}');
      // print(chatRooms);
      List<Chats> chatRoomList = [];

      chatRooms.forEach((room) {
        MessageSeenEnum seenenum;
        if (room['messageSeenEnum'] == 'seen') {
          seenenum = MessageSeenEnum.SEEN;
        } else if (room['messageSeenEnum'] == 'unseen') {
          seenenum = MessageSeenEnum.NOT_SEEN;
        } else if (room['messageSeenEnum'] == 'none') {
          seenenum = MessageSeenEnum.NONE;
        } else {
          seenenum = MessageSeenEnum.RECEIVED;
        }
        final chatRoom = Chats(
            lastMessage: room['lastMessage'],
            roomId: room['roomId'],
            messageSeenEnum: seenenum,
            messages: [],
            nameUser: room['username'],
            online: room['online'],
            time: room['time'],
            unSeenMessages: room['unseenMessages'],
            unSeenMessagesCount: room['unseenMessagesCount'].toString(),
            urlPhotoUser: room['avatar']);
        chatRoomList.add(chatRoom);
      });
      setChats(chatRoomList);
    });
  }

  void joinChatRoom(String joinRoomId) {
    // if (mainNsSocket != null) {
    //   mainNsSocket.close();
    // }
    // print('Inside joinChatRoom : ${joinRoomId}');
    // print(getMainNsSocket);
    // IO.Socket nsSocket =
    //     IO.io('http://192.168.43.197:5000${endpoint}', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': true,
    // });
    // nsSocket.connect();
    // mainNsSocket = nsSocket;
    mainNsSocket.emit('joinRoom', joinRoomId);
    mainNsSocket.on('chatData', (data) {
      // print('Inside chatData:  $data');
      // chatHistory = data;
      Chats chatroom = chats.firstWhere((room) {
        return room.roomId == data['roomId'];
      });
      final List<Message> chatList = [];
      data['messages'].forEach((message) {
        final chatHistory = new Message(
            mediaLink: message['mediaLink'],
            message: message['message'],
            time: message['time'],
            userId: message['userId'],
            username: message['username']);
        chatList.add(chatHistory);
      });
      chatroom.messages = chatList;
    });
    // return chatlist;
  }

  void messageToServer(String message) {
    // print('message to server : $message');
    mainNsSocket.emit('messageToServer', message);
  }

  // void disconectNamespace() {
  //   mainNsSocket.emit('disconnect');
  //   mainNsSocket = null;
  // }
}
