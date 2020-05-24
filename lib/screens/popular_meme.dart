import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/widgets/utilities/bottom_navbar.dart';
import 'package:battle_me/widgets/utilities/meme_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TrendingScreen extends StatefulWidget {
  // final MainModel model;
  // TrendingScreen(this.model);
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen>
    with TickerProviderStateMixin {
  Widget body() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        print(model.getFeedList);
        return Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: model.getFeedList.length,
              padding: EdgeInsets.symmetric(horizontal: 5),
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return MemeCard(
                    index: index,
                    model: model,
                    feedList: model.getFeedList,
                    onMemeIndexSelect: (int index) {
                      print(index);
                    }); // Add Card
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavbar(3),
      appBar: AppBar(
        title: Text('Popular'),
      ),
      body: body(),
    );
  }
}
