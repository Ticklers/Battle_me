import 'dart:async';

import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/models/user.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scoped_model/scoped_model.dart';

class ChatBoxScreen extends StatefulWidget {
  @override
  _ChatBoxScreenState createState() => _ChatBoxScreenState();
}

class _ChatBoxScreenState extends State<ChatBoxScreen> {
  User user;
  void setUser(MainModel model) {
    user = model.authenticatedUser;
  }

  Widget body(MainModel model) {
    setUser(model);
    return ListView.builder(
      itemCount: model.chats.length,
      padding: EdgeInsets.symmetric(horizontal: 5),
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return chatTile(index, model); // Add Card
      },
    );
  }

  Widget chatTile(int index, MainModel model) {
    var chat = model.chats[index];
    return Card(
      elevation: 5,
      // margin: EdgeInsets.all(0),
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: Icon(
          MyFlutterApp.emoticon,
          color: Theme.of(context).accentColor,
        ),
        onTap: () {
          model.joinChatRoom(chat['roomTitle']);
          Timer(Duration(seconds: 1), () {
            Navigator.push(
              context,
              PageTransition(
                child: Chat(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 300),
              ),
            );
          });
        },
        onLongPress: null,
        title: Text(
          chat['roomTitle'],
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        subtitle: Text(
          user.username,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chats'),
          ),
          body: body(model),
        );
      },
    );
  }
}
