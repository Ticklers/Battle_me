import '../api/keys.dart';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model {
  final uri = ApiKeys.uri;
  bool isLoading = false;
  File file = null;
}
