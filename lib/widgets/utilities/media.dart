import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:battle_me/helpers/dimensions.dart';
import 'dart:io';

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
  File _image;

  Future getImage(BuildContext context, ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source, maxWidth: 400);

    setState(() {
      _image = image;
      model.setImage(image);
      // model.imageUpload(id, _image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.yellow,
        // height: getDeviceHeight(context) * 0.4,
        width: getDeviceWidth(context),
        child: Column(
          children: <Widget>[
            _image == null
                ? Container(
                    height: getViewportHeight(context) * 0.5,
                    width: getViewportWidth(context),
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    child: Center(
                      child: Text(
                        'No media selected.',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  )
                : Container(
                    // color: Colors.yellow,
                    height: getViewportHeight(context) * 0.5,
                    width: getViewportWidth(context),
                    child: Image.file(_image),
                  ),
            SizedBox(height: getDeviceHeight(context) * 0.05),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      getImage(context, ImageSource.gallery);
                    },
                    tooltip: 'Pick Image from gallery',
                    icon: Icon(
                      MyFlutterApp.picture,
                      size: 50,
                    ),
                    color: Theme.of(context).accentColor,
                  ),
                  IconButton(
                    onPressed: () {
                      getImage(context, ImageSource.camera);
                    },
                    tooltip: 'Click a new image',
                    icon: Icon(
                      MyFlutterApp.camera,
                      size: 50,
                    ),
                    color: Theme.of(context).accentColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
