import 'package:flutter/material.dart';
import 'package:battle_me/models/chats.dart';
// import 'package:battle_me/widgets/chats/bottom_appbar_chats.dart';
import 'package:battle_me/widgets/chats/floating_action_button_chats.dart';
import 'package:battle_me/widgets/chats/tile_chats.dart';
import 'package:battle_me/widgets/chats/top_appbar_chats.dart';

class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButtonChats(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        TopAppBarChats(),
        Expanded(
          child: ListView.builder(
            itemCount: chatList.length,
            itemBuilder: (context, index) {
              return TilesChats(
                chats: chatList[index],
                lastChat: index == chatList.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
