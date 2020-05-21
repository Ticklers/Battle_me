import 'package:battle_me/enums/MessageSeenEnum.dart';
import 'package:battle_me/models/chats.dart';
import 'package:flutter/material.dart';
// import 'package:battle_me/enums/MessageSeenEnum.dart';
// import 'package:battle_me/models/chats.dart';
import 'package:battle_me/screens/chat_screen.dart';

class TilesChats extends StatelessWidget {
  final Chats chats;
  final bool lastChat;

  const TilesChats({Key key, this.chats, this.lastChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _goToChatPage(chats, context);
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
                            border: Border.all(color: Colors.white54, width: 3),
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
                                    chats.urlPhotoUser,
                                  ),
                                  backgroundColor: Colors.grey[200],
                                ),
                              ),
                              chats.online
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
                                chats.nameUser,
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
                                  chats.messageSeenEnum == MessageSeenEnum.NONE
                                      ? Container()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 3),
                                          child: _buildMessaSeenIcon(
                                              chats.messageSeenEnum)),
                                  Expanded(
                                    child: Text(
                                      chats.lastMessage,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.4),
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
                      chats.time,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.3),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    chats.unSeenMessages
                        ? Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: Colors.blueAccent[400],
                                shape: BoxShape.circle),
                            child: Text(
                              chats.unSeenMessagesCount,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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
          lastChat
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

  _goToChatPage(Chats chats, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChatPage(chats: chats)));
  }
}
