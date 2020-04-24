import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/screens/battle_screen.dart';
import 'package:battle_me/screens/popular_meme.dart';
import 'package:battle_me/screens/profile_screen.dart';
import 'package:battle_me/widgets/animations/navigation_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter/scheduler.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  bool _showAppbar = true; //this is to show app bar
  ScrollController _scrollBottomBarController =
      new ScrollController(); // set controller on scrolling
  bool isScrollingDown = false;
  int bottom_navbar_index = 0;

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
      children: <Widget>[],
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
                  title: Text('Home Screen'),
                  backgroundColor: Theme.of(context).appBarTheme.color,
                )
              : PreferredSize(
                  child: Container(),
                  preferredSize: Size(0.0, 0.0),
                ),
          bottomNavigationBar: Container(
            height: getDeviceHeight(context) * 0.09,
            width: MediaQuery.of(context).size.width,
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              onTap: (index) {
                setState(
                  () {
                    bottom_navbar_index = index;
                    switch (index.toString()) {
                      case "1":
                        {
                          Navigator.push(
                              context,
                              NavigationAnimationRoute(
                                  widget: PopularScreen()));
                        }
                        break;

                      case "2":
                        {
                          Navigator.push(context,
                              NavigationAnimationRoute(widget: BattleScreen()));
                        }
                        break;

                      case "3":
                        {
                          Navigator.push(
                              context,
                              NavigationAnimationRoute(
                                  widget: ProfileScreen()));
                        }
                        break;
                      default:
                        {
                          print('Home Screen selected');
                        }
                        break;
                    }
                  },
                );
              },
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.red,
              iconSize: getDeviceHeight(context) * 0.04,
              currentIndex:
                  bottom_navbar_index, // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.search,
                  ),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.notifications_none,
                  ),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    Icons.mail,
                    size: getViewportHeight(context) * 0.035,
                  ),
                  title: new Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
              ],
            ),
          ),
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
