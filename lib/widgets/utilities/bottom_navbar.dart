import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/battle_screen.dart';
import 'package:battle_me/screens/create_meme.dart';
// import 'package:battle_me/screens/create_meme.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:battle_me/screens/popular_meme.dart';
import 'package:battle_me/screens/profile_screen.dart';
// import 'package:battle_me/widgets/utilities/media.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:page_transition/page_transition.dart';

class BottomNavbar extends StatelessWidget {
  final current_index;
  BottomNavbar(this.current_index);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).bottomAppBarColor,
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 5.0,
                )
              ],
            ),
            height: getDeviceHeight(context) * 0.075,
            width: MediaQuery.of(context).size.width,
            child: BottomNavigationBar(
              onTap: (index) {
                model.bottom_navbar_index = index;
                switch (index.toString()) {
                  case "1":
                    {
                      if (current_index != 1) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: BattleScreen(),
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;
                  case "2":
                    {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: CreateMeme(model),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    }
                    break;

                  case "3":
                    {
                      if (current_index != 3) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: TrendingScreen(model),
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;

                  case "4":
                    {
                      if (current_index != 4) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: ProfileScreen(model),
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;

                  default:
                    {
                      if (current_index != 0) {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: HomeScreen(model),
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;
                }
              },
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.blue,
              iconSize: getDeviceHeight(context) * 0.04,
              currentIndex:
                  current_index, // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    MyFlutterApp.battle,
                  ),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    MyFlutterApp.add,
                  ),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    MyFlutterApp.trending,
                  ),
                  title: new Text('', style: TextStyle(fontSize: 0)),
                ),
                BottomNavigationBarItem(
                  icon: new Icon(
                    MyFlutterApp.user,
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
        );
      },
    );
  }
}
