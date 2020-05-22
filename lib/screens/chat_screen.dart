import 'dart:async';

import 'package:battle_me/models/user.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';
// import 'package:battle_me/enums/MessageSenderEnum.dart';
import 'package:battle_me/models/chats.dart';
import 'package:battle_me/models/message.dart';
import 'package:battle_me/widgets/chat/bottom_textfield_chat.dart';
import 'package:battle_me/widgets/chat/message_received_chat.dart';
import 'package:battle_me/widgets/chat/message_sent_chat.dart';
import 'package:battle_me/widgets/chat/top_appbar_chat.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class ChatPage extends StatefulWidget {
  final Chats chats;
  final MainModel model;

  const ChatPage({
    Key key,
    this.chats,
    this.model,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Widget> _columnMessages = [Container()];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildMessages(widget.model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScopedModelDescendant<MainModel>(
          builder: (context, child, model) {
            model.mainNsSocket.off('messageToClient');
            model.mainNsSocket.on('messageToClient', (data) {
              Message message = new Message(
                mediaLink: data['mediaLink'],
                message: data['message'],
                time: data['time'],
                userId: data['userId'],
                username: data['username'],
              );
              _receivedMessage(message, model);
            });
            return _buildBody(model);
          },
        ),
      ),
    );
  }

  Widget _buildBody(MainModel model) {
    return Column(
      children: <Widget>[
        TopAppBarChat(
          chats: widget.chats,
        ),
        Expanded(
          child: ListView(
            controller: _scrollController,
            reverse: true,
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: _columnMessages,
              ),
            ],
          ),
        ),
        BottomTextFieldChat(
          onPressed: _sendMessage,
          model: model,
        )
      ],
    );
  }

  _buildMessages(MainModel model) {
    List<Widget> listWidgets = [
      Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 10),
        child: Center(
          child: Text(
            widget.chats.messages.length > 0
                ? "Last messages"
                : "No message yet",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      )
    ];
    User user = model.getAuthenticatedUser;
    if (widget.chats.messages.isNotEmpty) {
      int index = 0;
      widget.chats.messages.forEach((message) {
        if (message.userId != user.userId) {
          listWidgets.add(MessageReceivedChat(
            urlPhoto: widget.chats.urlPhotoUser,
            message: message,
            firstMessage: index == 0,
            lastMessage: index == widget.chats.messages.length - 1,
          ));
        } else {
          listWidgets.add(MessageSentChat(
            message: message,
            firstMessage: index == 0,
            lastMessage: index == widget.chats.messages.length - 1,
          ));
        }

        index++;
      });
    }

    setState(() {
      _columnMessages = listWidgets;
    });
  }

  _sendMessage(String message, MainModel model) {
    // print('Inside send message');
    User user = model.getAuthenticatedUser;
    Map<String, dynamic> messageToServer = {
      'username': user.username,
      'message': message,
      'mediaLink': null,
      'userId': user.userId,
      'time': DateFormat.Hm().format(DateTime.now()),
    };
    model.mainNsSocket.emit('messageToServer', messageToServer);
  }

  _receivedMessage(Message message, MainModel model) {
    print('Inside Received message! : ${message.username}');

    setState(() {
      if (message.userId == model.getAuthenticatedUser.userId) {
        _columnMessages.add(MessageSentChat(
          message: Message(
            message: message.message,
            time: message.time,
            mediaLink: message.mediaLink,
            userId: message.userId,
            username: message.username,
          ),
          firstMessage: false,
          lastMessage: false,
        ));
      } else {
        _columnMessages.add(MessageReceivedChat(
          urlPhoto: widget.chats.urlPhotoUser,
          message: message,
          firstMessage: false,
          lastMessage: false,
        ));
      }
    });

    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
