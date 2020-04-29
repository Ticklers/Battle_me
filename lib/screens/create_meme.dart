import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/widgets/utilities/media.dart';
import 'package:flutter/material.dart';

class CreateMeme extends StatefulWidget {
  final MainModel model;
  CreateMeme(this.model);
  @override
  _CreateMemeState createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> with WidgetsBindingObserver {
  final Map<String, dynamic> _formData = {
    'caption': null,
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
          _formData['meme'] = value;
        },
        onSaved: (String value) {
          _formData['meme'] = value;
        },
      ),
    );
  }

  void _submitForm() {
    // if (!_formKey.currentState.validate()) {
    //   return;
    // }
    // _formKey.currentState.save();
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
              onPressed: () => widget.model.file != null ? _submitForm() : null,
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
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
