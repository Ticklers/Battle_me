import 'package:flutter/material.dart';
import 'package:battle_me/models/message.dart';

class MessageReceivedChat extends StatelessWidget {
  final String urlPhoto;
  final bool firstMessage;
  final bool lastMessage;
  final Message message;

  const MessageReceivedChat(
      {Key key,
      this.urlPhoto,
      this.firstMessage,
      this.lastMessage,
      this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          5, firstMessage ? 20 : 5, 5, lastMessage ? 20 : 5),
      child: Row(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white54, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      offset: Offset(0, 5),
                      blurRadius: 25,
                    )
                  ],
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    urlPhoto,
                  ),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.6),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  message.message,
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          Text(
            message.time,
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
