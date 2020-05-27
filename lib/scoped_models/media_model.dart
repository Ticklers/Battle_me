import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import './connected_scoped_model.dart';

class MediaModel extends ConnectedModel {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cracknet-app.appspot.com');
  StorageUploadTask _uploadTask;

  void setImage(File image) {
    // print('Inside setImage' + image.toString());
    file = image;
    // print(file);
    // print('setImageExit');
  }

  File getImage() {
    // print('Inside get Image: ' + file.toString());
    return file;
  }

  StorageUploadTask getUploadTask() {
    return _uploadTask;
  }

  /// Starts an upload task
  Future<String> startUpload(File file) async {
    /// Unique file name for the file
    String dateTime = DateTime.now().toString();
    String filePath = 'images/${dateTime}.png';
    _uploadTask = _storage.ref().child(filePath).putFile(file);
    var downloadUrl = await (await _uploadTask.onComplete).ref.getDownloadURL();
    var url = downloadUrl.toString();
    // print('Download URL : ${url}');
    return url;
  }
}
