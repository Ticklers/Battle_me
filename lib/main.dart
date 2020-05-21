// import 'package:battle_me/helpers/system_chrome_settings.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/battle_screen.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:battle_me/screens/popular_meme.dart';
import 'package:battle_me/screens/profile_screen.dart';
import 'package:battle_me/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:battle_me/scoped_models/socket_model.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // Dart client
  print('Inside socketConnect');
  IO.Socket socket = IO.io('http://192.168.43.197:5000', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
    'query': {"username": "Rishabh"}, // optional
  });
  socket.connect();
  // SocketModel socketModel = SocketModel();
  // socketModel.socketClient(socket);

  runApp(MyApp(socket));
}

class MyApp extends StatefulWidget {
  final IO.Socket socket;
  MyApp(this.socket);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.setSocket(widget.socket);
    _model.socketClient(widget.socket);
    _model.autoAuthenticate();
    _model.fetchMeme('feed');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xff2b2d5d),
          // primaryColor: Color(0xff151716),
          cardColor: Color(0xff1e1f21),
          accentColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Color(0xff1e1f21),
          ),
          cursorColor: Colors.blue,
          canvasColor: Colors.transparent,
          bottomAppBarColor: Color(0xff1e1f21),
          buttonColor: Color(0xff2a2b2d),
          iconTheme: IconThemeData(color: Colors.white70),
          primaryIconTheme: IconThemeData(color: Colors.white70),
          accentIconTheme: IconThemeData(color: Colors.white70),
          scaffoldBackgroundColor: Colors.black,
          // scaffoldBackgroundColor: Color(0xff2b2d5d),
          dividerColor: Colors.white,
          textTheme: TextTheme(
            // subhead: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white),
            // body1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            // headline: TextStyle(color: Colors.white),
            headline5: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white70),
            // title: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.white),
            // subtitle: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.white),
          ),
          primaryTextTheme: TextTheme(
            button: TextStyle(color: Colors.white),
            // title: TextStyle(color: Colors.white),
            headline6: TextStyle(color: Colors.white),
            // subtitle: TextStyle(color: Colors.white),
            subtitle2: TextStyle(color: Colors.white),
          ),
          textSelectionColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => SplashScreen(_model),
          '/home': (BuildContext context) => HomeScreen(_model),
          '/trend': (BuildContext context) => TrendingScreen(_model),
          '/profile': (BuildContext context) => ProfileScreen(_model),
          '/battle': (BuildContext context) => BattleScreen(),
        },
      ),
    );
  }
}
