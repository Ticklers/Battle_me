// import 'package:battle_me/helpers/media_uploader.dart';
// import 'package:battle_me/helpers/my_flutter_app_icons.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:battle_me/helpers/dimensions.dart';
// import 'dart:io';
// import 'package:flutter/widgets.dart';
// import 'package:image_cropper/image_cropper.dart';

// import 'package:battle_me/scoped_models/main_scoped_model.dart';

// class MediaScreen extends StatefulWidget {
//   final MainModel model;
//   MediaScreen(this.model);
//   @override
//   _MediaScreenState createState() => _MediaScreenState();
// }

// class _MediaScreenState extends State<MediaScreen> {
//   // String id;
//   File _imageFile;

//   Future<void> _pickImage(ImageSource source) async {
//     File selected = await ImagePicker.pickImage(source: source);

//     setState(() {
//       _imageFile = selected;
//       widget.model.setImage(selected);
//     });
//   }

//   Future<void> _cropImage() async {
//     File cropped = await ImageCropper.cropImage(
//       sourcePath: _imageFile.path,
//     );
//     setState(() {
//       _imageFile = cropped ?? _imageFile;
//       widget.model.setImage(cropped ?? _imageFile);
//     });
//   }

//   void _clear() {
//     setState(() {
//       _imageFile = null;
//       widget.model.setImage(null);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ;
//   }
// }
