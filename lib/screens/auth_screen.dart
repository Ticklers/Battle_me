import 'dart:async';

import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:battle_me/widgets/animations/navigation_animation.dart';
import 'package:battle_me/widgets/animations/teddy_animation.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AuthScreen extends StatefulWidget {
  final MainModel model;
  AuthScreen(this.model);
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String animation;
  double viewportHeight;
  double viewportWidth;

  final Map<String, String> _loginCredentials = <String, String>{
    "email": "",
    "password": ""
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isAuthenticated = true;
  bool _obscureText = true;

  bool isLoading = false;
  String errorMsg = "";
  String _errorEmail = "";
  String _errorPassword = "";

  @override
  void initState() {
    animation = 'idle';
    super.initState();
  }

  Widget _errorMsgContainer(double viewportHeight, double viewportWidth) {
    return Container(
      margin: EdgeInsets.only(top: viewportHeight * 0.01),
      height: viewportHeight * 0.05,
      width: viewportWidth,
      alignment: Alignment.center,
      child: Text(
        errorMsg,
        style: TextStyle(
          fontSize: viewportHeight * 0.025,
          fontFamily: 'BalooTamma2',
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emailInputFieldBuilder(double viewportWidth) {
    return TextFormField(
      onChanged: (String value) {
        setState(() {
          errorMsg = "";
          animation = 'test';
        });
        _loginCredentials["email"] = value;
      },
      onSaved: (String value) {
        _loginCredentials["email"] = value;
      },
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: viewportHeight * 0.025,
        color: Theme.of(context).accentColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        alignLabelWithHint: false,
        prefixIcon: Icon(
          Icons.mail,
          color: Theme.of(context).accentColor,
          size: viewportHeight * 0.03,
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          fontFamily: "Manrope",
          fontSize: viewportHeight * 0.025,
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _passwordInputFieldBuilder(double viewportWidth) {
    return TextFormField(
      onChanged: (String value) {
        setState(() {
          errorMsg = "";
          animation = 'test';
        });
        _loginCredentials["password"] = value;
      },
      onSaved: (String value) {
        _loginCredentials["password"] = value;
      },
      obscureText: _obscureText,
      style: TextStyle(
        fontSize: viewportHeight * 0.025,
        color: Theme.of(context).accentColor,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Theme.of(context).accentColor,
          size: viewportHeight * 0.03,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              animation = 'idle';
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).accentColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        alignLabelWithHint: false,
        labelText: "Password",
        labelStyle: TextStyle(
          fontFamily: "Manrope",
          fontSize: viewportHeight * 0.025,
          color: Theme.of(context).accentColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _submitForm() async {
    setState(() {
      isLoading = true;
    });
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    FocusScope.of(context).requestFocus(FocusNode());
    isAuthenticated = await widget.model
        .userLogin(_loginCredentials["email"], _loginCredentials["password"]);
    print("after response");
    print(isAuthenticated);
    setState(() {
      if (isAuthenticated) {
        animation = 'success';

        IO.Socket socket =
            IO.io('http://192.168.43.197:5000', <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
          'query': {"token": "Rishabh"}, // optional
        });

        widget.model.setSocket(socket);
        widget.model.socketClient(socket);
        Timer(Duration(milliseconds: 1500), () {
          isLoading = false;
          Navigator.pushReplacement(
            context,
            NavigationAnimationRoute(
              widget: HomeScreen(widget.model),
            ),
          );
        });
      } else {
        isLoading = false;
        animation = 'fail';
        errorMsg = "Wrong credentials !";
        print('Login Unsuccessful');
      }
    });
  }

  Widget _signInButtonBuilder(double viewportHeight, double viewportWidth) {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      color: Colors.blue,
      splashColor: Colors.green,
      onPressed: () {
        _submitForm();
      },
      child: Container(
        alignment: Alignment.centerRight,
        width: viewportWidth * 0.2,
        height: viewportHeight * 0.065,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: isLoading
              ? FlareActor(
                  "assets/flare/Loader.flr",
                  animation: 'start',
                  fit: BoxFit.contain,
                  color: Colors.white,
                )
              : Text(
                  "SignIn",
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.white,
                    fontSize: viewportHeight * 0.025,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _authCard() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: viewportHeight * 0.05),
            // height: viewportHeight * 0.15,
            child: Center(
                child: Text(
              'Welcome',
              style: TextStyle(
                fontFamily: "Manrope",
                fontSize: viewportHeight * 0.025,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w700,
              ),
            )),
          ),
          _errorMsgContainer(viewportHeight, viewportWidth),
          Container(
            padding: EdgeInsets.symmetric(horizontal: viewportWidth * 0.1),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _emailInputFieldBuilder(viewportHeight),
                  Container(
                    width: viewportWidth,
                    height: viewportHeight * 0.04,
                    padding: EdgeInsets.only(
                        top: viewportHeight * 0.015,
                        left: viewportWidth * 0.05),
                    child: Text(
                      _errorEmail,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: viewportWidth * 0.04,
                        color: Colors.red,
                        height: viewportWidth * 0.002,
                        fontFamily: 'BalooTamma2',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: viewportHeight * 0.02,
                  ),
                  _passwordInputFieldBuilder(viewportHeight),
                  Container(
                    width: viewportWidth,
                    height: viewportHeight * 0.04,
                    padding: EdgeInsets.only(
                        top: viewportHeight * 0.015,
                        left: viewportWidth * 0.05),
                    child: Text(
                      _errorPassword,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: viewportWidth * 0.04,
                        color: Colors.red,
                        fontFamily: 'BalooTamma2',
                        height: viewportWidth * 0.002,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: viewportHeight * 0.01,
          ),
          _signInButtonBuilder(viewportHeight, viewportWidth),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewportWidth = getViewportWidth(context);
    viewportHeight = getViewportHeight(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            errorMsg = "";
            animation = 'idle';
          });
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Hero(
                  tag: "icon",
                  child: Container(
                    height: getDeviceHeight(context) * 0.15,
                    width: getDeviceWidth(context) * 0.15,
                    child: Image.asset('assets/images/icon.png'),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: getViewportHeight(context) * 0.1),
                  TeddyAnimation(animation),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: getViewportHeight(context) * 0.55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset.fromDirection(1.7))
                        ],
                      ),
                      child: _authCard(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
