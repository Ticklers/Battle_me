import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/models/user.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:battle_me/widgets/utilities/media.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CreateMeme extends StatefulWidget {
  final MainModel model;
  CreateMeme(this.model);
  @override
  _CreateMemeState createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> with WidgetsBindingObserver {
  // final Map<String, dynamic> _formData = {
  //   'caption': null,
  // };
  User currentUser;
  Map<String, dynamic> _formData = {
    "isBattle": false,
    "isRoast": false,
    "onProfile": false,
    "caption": null,
    "user": null,
    "name": null,
    "username": null,
    "avatar": null,
    "likes": [],
    "comments": []
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildMemeTextField() {
    return Container(
      // height: getDeviceHeight(context) * 0.5,
      width: getDeviceWidth(context) * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        cursorColor: Theme.of(context).cursorColor,
        // maxLength: 280,
        autofocus: true,
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

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formData['onProfile'] = true;
    _formData['user'] = currentUser.userId;
    _formData['name'] = currentUser.name;
    _formData['username'] = currentUser.username;
    _formData['avatar'] = currentUser.avatar;
    _formKey.currentState.save();
    widget.model.createMeme(formdata: _formData, token: currentUser.token).then(
      (String memeId) async {
        if (memeId != null) {
          // MediaScreen(widget.model).createState();
          await widget.model
              .imageUpload(memeId, widget.model.getImage(), 'meme');
          widget.model.setImage(null);
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: HomeScreen(widget.model),
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Something went wrong!'),
                content: Text('Please try again!'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  )
                ],
              );
            },
          );
        }
      },
    );
    print('Submited');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        widget.model.file = null;
        setState(() {
          print('new state rendered');
        });
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Discard Changes ?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Meme'),
          bottomOpacity: 0.4,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () =>
                    widget.model.file != null ? _submitForm() : null,
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
              widget.model.file != null
                  ? Container(
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
                    )
                  : Container(),
              SizedBox(height: getDeviceHeight(context) * 0.04),
              MediaScreen(widget.model),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
