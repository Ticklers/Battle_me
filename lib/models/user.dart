import 'package:flutter/cupertino.dart';

class User {
  final String name;
  final String userId;
  final String email;
  final String avatar;
  final int age;
  final List<dynamic> memes_record;
  final String gender;
  final String token;
  User({
    @required this.name,
    @required this.userId,
    @required this.email,
    @required this.avatar,
    @required this.memes_record,
    @required this.age,
    @required this.gender,
    this.token,
  });
}
