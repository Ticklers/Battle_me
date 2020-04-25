import 'package:battle_me/widgets/utilities/bottom_navbar.dart';
import 'package:flutter/material.dart';

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(2),
      body: Center(child: Text('Trending Screen')),
    );
  }
}
