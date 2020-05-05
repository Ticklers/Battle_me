import 'dart:io';
import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/models/user.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class CreateMeme extends StatefulWidget {
  final MainModel model;
  CreateMeme(this.model);
  @override
  _CreateMemeState createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> with WidgetsBindingObserver {
  User currentUser;
  Map<String, dynamic> _formData = {
    "isBattle": false,
    "isRoast": false,
    "onProfile": false,
    "caption": null,
    "user": null,
    "mediaLink": null,
    "name": null,
    "username": null,
    "avatar": null,
    "likes": [],
    "comments": []
  };
  File _imageFile;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildMemeTextField() {
    return Container(
      // height: getDeviceHeight(context) * 0.5,
      width: getDeviceWidth(context) * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: Theme.of(context).cursorColor,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: getViewportHeight(context) * 0.025,
          fontFamily: "Ubuntu",
        ),
        decoration: InputDecoration.collapsed(
          hintText: 'What\'s happening?',
          hintStyle: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        validator: (String value) {
          if (value.isEmpty || value.length > 281) {
            return 'Meme is required and should be less than 280 character.';
          }
          return null;
        },
        onChanged: (String value) {
          _formData['caption'] = value;
        },
        onSaved: (String value) {
          _formData['caption'] = value;
        },
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
      widget.model.setImage(selected);
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
      widget.model.setImage(cropped ?? _imageFile);
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
      widget.model.setImage(null);
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formData['mediaLink'] = await widget.model.startUpload(_imageFile);
    _formData['onProfile'] = true;
    _formData['user'] = currentUser.userId;
    _formData['name'] = currentUser.name;
    _formData['username'] = currentUser.username;
    _formData['avatar'] = currentUser.avatar;
    _formKey.currentState.save();
    widget.model.createMeme(formdata: _formData, token: currentUser.token);
    Navigator.pushReplacement(
      context,
      PageTransition(
        child: HomeScreen(widget.model),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 300),
      ),
    );
    print('Submited');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Meme'),
        bottomOpacity: 0.4,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () => _imageFile != null
                  ? _submitForm()
                  : print('No media selected!'),
              disabledColor: Colors.red,
              color: Theme.of(context).buttonColor,
              textColor: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white24),
              ),
              splashColor: Colors.lightGreen,
              child: Text('Upload'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: getDeviceHeight(context) * 0.1,
              color: Theme.of(context).cardColor.withOpacity(0.3),
              child: Row(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildMemeTextField(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: getDeviceHeight(context) * 0.04),
            Container(
              height: getViewportHeight(context) * 0.7,
              child: ListView(
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
                  ],
                  if (_imageFile == null) ...[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: getViewportHeight(context) * 0.4,
                        width: getViewportWidth(context),
                        child:
                            Image.asset('assets/images/placeholder_meme.jpg'),
                      ),
                    )
                  ],
                  Container(
                    // height: getViewportHeight(context) * 0.7,
                    // alignment: Alignment.,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _imageFile = null;
    currentUser = widget.model.authenticatedUser;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
