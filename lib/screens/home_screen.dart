import 'package:battle_me/widgets/utilities/bottom_navbar.dart';
import 'package:battle_me/widgets/utilities/meme_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_scoped_model.dart';

class HomeScreen extends StatefulWidget {
  final MainModel model;

  HomeScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    myScroll();
  }

  void showBottomBar() {
    setState(() {
      _showAppbar = true;
    });
  }

  void hideBottomBar() {
    setState(() {
      _showAppbar = false;
    });
  }

  void myScroll() async {
    _scrollBottomBarController.addListener(() {
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          hideBottomBar();
        }
      }
      if (_scrollBottomBarController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          showBottomBar();
        }
      }
    });
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: 5,
          padding: EdgeInsets.symmetric(horizontal: 5),
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return MemeCard(); // Add Card
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).primaryColor,
          // drawer: SideDrawer(),
          appBar: _showAppbar
              ? AppBar(
                  leading: Hero(
                    tag: "icon",
                    child: Container(
                      child: Image.asset('assets/images/icon.png'),
                    ),
                  ),
                  title: Text('Home Screen'),
                  backgroundColor: Theme.of(context).appBarTheme.color,
                )
              : PreferredSize(
                  child: Container(),
                  preferredSize: Size(0.0, 0.0),
                ),
          bottomNavigationBar: BottomNavbar(0),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : body(),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollBottomBarController.removeListener(() {});
    super.dispose();
  }
}
