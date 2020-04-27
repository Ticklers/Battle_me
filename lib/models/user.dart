import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String username;
  final String userId;
  final String email;
  final String avatar;
  // final int age;
  // final List<dynamic> memes_record;
  final String token;
  final String dateOfJoining;
  User({
    @required this.name,
    @required this.username,
    @required this.userId,
    @required this.email,
    @required this.avatar,
    // @required this.memes_record,
    // @required this.age,
    this.dateOfJoining,
    this.token,
  });
}
