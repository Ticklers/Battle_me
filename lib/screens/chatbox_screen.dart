import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/models/user.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';
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
      itemCount: 5,
      padding: EdgeInsets.symmetric(horizontal: 5),
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return chatTile(); // Add Card
      },
    );
  }

  Widget chatTile() {
    return Card(
      elevation: 5,
      // margin: EdgeInsets.all(0),
      color: Theme.of(context).cardColor,
      child: ListTile(
        leading: Icon(
          MyFlutterApp.emoticon,
          color: Theme.of(context).accentColor,
        ),
        onTap: null,
        onLongPress: null,
        title: Text(
          user.name,
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
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text('Chats'),
          ),
          body: body(model),
        );
      },
    );
  }
}
