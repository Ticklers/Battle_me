import 'package:battle_me/scoped_models/main_scoped_model.dart';
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
          primaryColor: Color(0xff0079f5),
          accentColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          // '/': (BuildContext context) => SplashPage(_model),
        },
      ),
    );
  }
}
