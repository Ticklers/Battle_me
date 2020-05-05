import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String username;
  final String userId;
  final String email;
  final String avatar;
  final List<dynamic> memes;
  final List<dynamic> followers;
  final List<dynamic> followings;
  final String token;
  final String dateOfJoining;
  User({
    @required this.name,
    @required this.username,
    @required this.userId,
    @required this.email,
    @required this.avatar,
    @required this.memes,
    @required this.followers,
    @required this.followings,
    @required this.dateOfJoining,
    this.token,
  });
}
