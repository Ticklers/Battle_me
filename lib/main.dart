import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/battle_screen.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:battle_me/screens/popular_meme.dart';
import 'package:battle_me/screens/profile_screen.dart';
import 'package:battle_me/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
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
            subhead: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
            headline: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white70),
            title: TextStyle(color: Colors.white),
            subtitle: TextStyle(color: Colors.white),
          ),
          primaryTextTheme: TextTheme(
            button: TextStyle(color: Colors.white),
            title: TextStyle(color: Colors.white),
            subtitle: TextStyle(color: Colors.white),
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
