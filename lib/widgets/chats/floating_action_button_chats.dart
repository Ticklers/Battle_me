import 'package:flutter/material.dart';

class FloatingActionButtonChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5,
      backgroundColor: Colors.white.withOpacity(0.8),
      child: Icon(Icons.camera_alt),
      onPressed: () {
        print("Test camera");
      },
    );
  }
}
