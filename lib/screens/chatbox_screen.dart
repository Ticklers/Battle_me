import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:battle_me/models/chats.dart';
// import 'package:battle_me/widgets/chats/bottom_appbar_chats.dart';
// import 'package:battle_me/widgets/chats/floating_action_button_chats.dart';
import 'package:battle_me/widgets/chats/tile_chats.dart';
import 'package:battle_me/widgets/chats/top_appbar_chats.dart';
import 'package:scoped_model/scoped_model.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButtonChats(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          children: <Widget>[
            TopAppBarChats(),
            Expanded(
              child: ListView.builder(
                itemCount: model.chats.length,
                itemBuilder: (context, index) {
                  return TilesChats(
                    chats: model.chats[index],
                    lastChat: index == model.chats.length - 1,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
