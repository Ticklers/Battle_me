import 'package:flutter/material.dart';

class TopAppBarChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 5, 8, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context)),
            Text(
              "Messages",
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 17,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print("Test icon button");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_box),
                  onPressed: () {
                    print("Test icon button");
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
