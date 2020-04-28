import 'package:battle_me/scoped_models/media_model.dart';
import 'package:battle_me/scoped_models/meme_model.dart';
import 'package:battle_me/scoped_models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import './connected_scoped_model.dart';

class MainModel extends Model
    with ConnectedModel, UserModel, MemeModel, MediaModel {}
