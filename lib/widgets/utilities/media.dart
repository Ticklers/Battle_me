import 'package:battle_me/helpers/media_uploader.dart';
import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:battle_me/helpers/dimensions.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:battle_me/scoped_models/main_scoped_model.dart';

class MediaScreen extends StatefulWidget {
  final MainModel model;
  MediaScreen(this.model);
  @override
  _MediaScreenState createState() => _MediaScreenState(model);
}

class _MediaScreenState extends State<MediaScreen> {
  final MainModel model;
  String id;
  _MediaScreenState(this.model);
  File _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Select an image from the camera or gallery
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                MyFlutterApp.camera,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(
                MyFlutterApp.picture,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: getDeviceWidth(context),
                width: getDeviceWidth(context),
                child: Image.file(_imageFile),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.crop,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(
                    Icons.refresh,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: _clear,
                ),
              ],
            ),
            Uploader(file: _imageFile),
          ],
          if (_imageFile == null) ...[
            ListTile(
              title: Text('Create Meme'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: getViewportHeight(context) * 0.4,
                width: getViewportWidth(context),
                child: Image.asset('assets/images/placeholder_meme.jpg'),
              ),
            )
          ]
        ],
      ),
    );
  }
}
