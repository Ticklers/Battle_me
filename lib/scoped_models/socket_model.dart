// import 'dart:convert';
import 'dart:async';
// import 'package:intl/intl.dart';

import 'package:battle_me/models/meme.dart';

import './connected_scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketModel extends ConnectedModel {
  void setSocket(IO.Socket socket) {
    mainSocket = socket;
  }

  void setFeedList(List<Meme> data) {
    meme_feed = data;
  }

  void setChats(List chatList) {
    chats = chatList;
  }

  void setChatHistory(List data) {
    print('inside setChat history $data');
    chatHistory = data;
  }

  void socketClient(IO.Socket socket) {
    print('Inside socketClient');
    socket.on('connection', (_) {
      print('connect!!!!!!!!!!!!!!!');
      //  socket.emit('msg', 'test');
    });
    socket.emit('getFeed');
    socket.on('memes', (data) {
      List<Meme> allMemes = [];
      print('received Socket data: ${data["data"]["count"]}');
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
      print('NewFeed Triggered');
      print(data);
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
    print('Inside liveFeed fetch');

    socket.emit('getFeed');
    notifyListeners();
  }

  Future<Null> newPostAdd(IO.Socket socket, post) async {
    print('Inside newPost add');
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
    if (mainNsSocket != null) {
      mainNsSocket.close();
    }
    print('Inside joinNs : ${endpoint}');
    IO.Socket nsSocket =
        IO.io('http://192.168.43.197:5000${endpoint}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    nsSocket.connect();
    mainNsSocket = nsSocket;
    await nsSocket.on('chatRoomsList', (chats) {
      // print('chatRoomList Data length:  ${chats.length}');
      // print(chats);
      List chatList = [];
      chats.forEach((chat) {
        chatList.add(chat);
      });
      setChats(chatList);
    });
  }

  joinChatRoom(String roomToJoin) {
    // if (mainNsSocket != null) {
    //   mainNsSocket.close();
    // }
    print('Inside joinChatRoom : ${roomToJoin}');
    // IO.Socket nsSocket =
    //     IO.io('http://192.168.43.197:5000${endpoint}', <String, dynamic>{
    //   'transports': ['websocket'],
    //   'autoConnect': true,
    // });
    // nsSocket.connect();
    // mainNsSocket = nsSocket;
    mainNsSocket.emit('joinRoom', roomToJoin);
    mainNsSocket.on('chatData', (data) {
      print('Inside chatData:  $data');
      // chatHistory = data;
      setChatHistory(data['chatHistory']);
    });
  }
}
