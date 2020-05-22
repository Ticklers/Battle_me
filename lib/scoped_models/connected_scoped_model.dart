import 'package:battle_me/models/chats.dart';
import 'package:battle_me/models/meme.dart';

import '../api/keys.dart';
import 'dart:io';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model {
  final uri = ApiKeys.uri;
  bool isLoading = false;
  File file = null;
  int bottom_navbar_index = 0;
  List<Meme> popular_meme = [];
  List<Meme> trending_meme = [];
  List<Meme> meme_feed = [];
  List<Meme> user_meme = [];
  bool isUserAuthenticated = false;
  IO.Socket mainSocket;
  // IO.Socket mainNsSocket;
  bool newFeed = false;
  List<Chats> chats = null;
  // List chatHistory = null;
}
