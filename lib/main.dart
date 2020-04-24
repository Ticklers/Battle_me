import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/splash_screen.dart';
import 'package:flutter/material.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          // primaryColor: Color(0xff2b2d5d),
          primaryColor: Color(0xff151716),
          cardColor: Color(0xff1e1f21),
          accentColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Color(0xff1e1f21),
          ),
          bottomAppBarColor: Color(0xff1e1f21),
          buttonColor: Color(0xff2a2b2d),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => SplashScreen(_model),
        },
      ),
    );
  }
}
