import 'package:battle_me/widgets/utilities/bottom_navbar.dart';
import 'package:flutter/material.dart';

class BattleScreen extends StatefulWidget {
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  int bottom_navbar_index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(1),
      body: Center(child: Text('Battle Screen')),
    );
  }
}
