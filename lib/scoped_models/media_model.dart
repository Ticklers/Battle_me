import 'dart:io';
// import 'dart:convert';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';
// import 'package:http/http.dart' as http;
import './connected_scoped_model.dart';

class MediaModel extends ConnectedModel {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cracknet-app.appspot.com');
  StorageUploadTask _uploadTask;

  void setImage(File image) {
    print('Inside setImage' + image.toString());
    file = image;
    print(file);
    print('setImageExit');
  }

  File getImage() {
    print('Inside get Image: ' + file.toString());
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
    print('Download URL : ${url}');
    return url;
  }

  // Future<Null> imageUpload(String memeId, File image, String mode) async {
  //   isLoading = true;
  //   notifyListeners();
  //   print('Inside imageUpload : ');
  //   print(memeId);
  //   print(image.toString());
  //   // Find the mime type of the selected file by looking at the header bytes of the file
  //   final mimeTypeData =
  //       lookupMimeType(image.path, headerBytes: [0xFF, 0xD8]).split('/');
  //   var imageUploadRequest = null;
  //   var file = null;
  //   // Intilize the multipart request
  //   if (mode == 'meme') {
  //     print('Inside meme mode:');
  //     imageUploadRequest = http.MultipartRequest(
  //         'PATCH', Uri.parse('${uri}api/memes/media/${memeId}'));
  //     // Attach the file in the request
  //     file = await http.MultipartFile.fromPath('media', image.path,
  //         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  //   } else {
  //     imageUploadRequest = http.MultipartRequest(
  //         'PATCH', Uri.parse('${uri}api/users/avatar/${memeId}'));
  //     // Attach the file in the request
  //     file = await http.MultipartFile.fromPath('avatar', image.path,
  //         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
  //   }

  //   // Explicitly pass the extension of the image with request body
  //   // Since image_picker has some bugs due which it mixes up
  //   // image extension with file name like this filenamejpge
  //   // Which creates some problem at the server side to manage
  //   // or verify the file extension
  //   imageUploadRequest.fields['ext'] = mimeTypeData[1];
  //   imageUploadRequest.files.add(file);
  //   try {
  //     final streamedResponse = await imageUploadRequest.send();
  //     final response = await http.Response.fromStream(streamedResponse);
  //     print(response.statusCode);
  //     if (response.statusCode != 200 && response.statusCode != 201) {
  //       final Map<String, dynamic> responseData = json.decode(response.body);
  //       print(responseData);
  //     }
  //     isLoading = false;
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error in uploading image: ' + error.toString());
  //     isLoading = false;
  //     notifyListeners();
  //     return null;
  //   }
  // }

  // String parseImage(String imageAddress) {
  //   String avatar;
  //   if (imageAddress.contains('\\')) {
  //     List<String> a = imageAddress.split('\\');
  //     avatar = a[0] + '/' + a[1];
  //   } else {
  //     avatar = imageAddress;
  //   }
  //   return avatar;
  // }
}
