import 'dart:async';

import 'package:battle_me/enums/MessageSeenEnum.dart';
import 'package:battle_me/models/chats.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';
// import 'package:battle_me/enums/MessageSeenEnum.dart';
// import 'package:battle_me/models/chats.dart';
import 'package:battle_me/screens/chat_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class TilesChats extends StatefulWidget {
  final Chats chats;
  final bool lastChat;

  const TilesChats({Key key, this.chats, this.lastChat}) : super(key: key);

  @override
  _TilesChatsState createState() => _TilesChatsState();
}

class _TilesChatsState extends State<TilesChats> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return InkWell(
          onTap: () {
            model.joinChatRoom(widget.chats.roomId);
            Timer(Duration(milliseconds: 300), () {
              _goToChatPage(widget.chats, context, model);
            });
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white54, width: 3),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(0, 5),
                                      blurRadius: 25)
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        widget.chats.urlPhotoUser,
                                      ),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                  ),
                                  widget.chats.online
                                      ? Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 3,
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.chats.nameUser,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      widget.chats.messageSeenEnum ==
                                              MessageSeenEnum.NONE
                                          ? Container()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 3),
                                              child: _buildMessaSeenIcon(widget
                                                  .chats.messageSeenEnum)),
                                      Expanded(
                                        child: Text(
                                          widget.chats.lastMessage,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          widget.chats.time,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.3),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        widget.chats.unSeenMessages
                            ? Container(
                                alignment: Alignment.center,
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent[400],
                                    shape: BoxShape.circle),
                                child: Text(
                                  widget.chats.unSeenMessagesCount,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              )
                            : Container(
                                height: 20,
                                width: 20,
                              )
                      ],
                    )
                  ],
                ),
              ),
              widget.lastChat
                  ? SizedBox(
                      height: 20,
                    )
                  : Container(),
              Container(
                height: 0.19,
                color: Colors.grey[400],
              )
            ],
          ),
        );
      },
    );
  }

  _buildMessaSeenIcon(MessageSeenEnum messageSeenEnum) {
    Icon icon;

    if (messageSeenEnum == MessageSeenEnum.NOT_SEEN) {
      icon = Icon(
        Icons.check,
        size: 15,
        color: Colors.white70,
      );
    } else if (messageSeenEnum == MessageSeenEnum.RECEIVED) {
      icon = Icon(
        Icons.done_all,
        size: 15,
        color: Colors.white70,
      );
    } else {
      icon = Icon(
        Icons.done_all,
        size: 15,
        color: Colors.blue,
      );
    }

    return icon;
  }

  _goToChatPage(Chats chats, BuildContext context, MainModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(
                  chats: chats,
                  model: model,
                )));
  }
}
