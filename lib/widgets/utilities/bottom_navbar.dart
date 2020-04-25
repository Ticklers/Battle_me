import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/battle_screen.dart';
import 'package:battle_me/screens/home_screen.dart';
import 'package:battle_me/screens/popular_meme.dart';
import 'package:battle_me/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:page_transition/page_transition.dart';

// class BottomNavbar extends StatelessWidget {
//   final current_index;
//   BottomNavbar(this.current_index);
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<MainModel>(
//       builder: (BuildContext context, Widget child, MainModel model) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             canvasColor: Theme.of(context).bottomAppBarColor,
//             primaryColor: Colors.yellow,
//           ),
//           child: Container(
//             height: getDeviceHeight(context) * 0.09,
//             width: MediaQuery.of(context).size.width,
//             child: BottomNavigationBar(
//               backgroundColor: Theme.of(context).bottomAppBarColor,
//               onTap: (index) {
//                 model.bottom_navbar_index = index;
//                 switch (index.toString()) {
//                   case "1":
//                     {
//                       if (current_index != 1) {
//                         Navigator.pushNamed(context, '/trend');
//                       }
//                     }
//                     break;

//                   case "2":
//                     {
//                       if (current_index != 2) {
//                         Navigator.pushNamed(context, '/battle');
//                       }
//                     }
//                     break;

//                   case "3":
//                     {
//                       if (current_index != 3) {
//                         Navigator.pushNamed(context, '/profile');
//                       }
//                     }
//                     break;
//                   default:
//                     {
//                       if (current_index != 0) {
//                         Navigator.pushNamed(context, '/home', arguments: model);
//                       }
//                     }
//                     break;
//                 }
//               },
//               unselectedItemColor: Colors.white,
//               selectedItemColor: Colors.red,
//               iconSize: getDeviceHeight(context) * 0.04,
//               currentIndex: model
//                   .bottom_navbar_index, // this will be set when a new tab is tapped
//               items: [
//                 BottomNavigationBarItem(
//                   icon: new Icon(Icons.home),
//                   title: new Text('', style: TextStyle(fontSize: 0)),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: new Icon(
//                     Icons.search,
//                   ),
//                   title: new Text('', style: TextStyle(fontSize: 0)),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: new Icon(
//                     Icons.notifications_none,
//                   ),
//                   title: new Text('', style: TextStyle(fontSize: 0)),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: new Icon(
//                     Icons.mail,
//                     size: getViewportHeight(context) * 0.035,
//                   ),
//                   title: new Text(
//                     '',
//                     style: TextStyle(fontSize: 0),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

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
            primaryColor: Colors.yellow,
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 5.0,
                )
              ],
            ),
            height: getDeviceHeight(context) * 0.09,
            width: MediaQuery.of(context).size.width,
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              onTap: (index) {
                model.bottom_navbar_index = index;
                switch (index.toString()) {
                  case "1":
                    {
                      if (current_index != 1) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: TrendingScreen(),
                            type: PageTransitionType.rotate,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;

                  case "2":
                    {
                      if (current_index != 2) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: BattleScreen(),
                            type: PageTransitionType.rotate,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;

                  case "3":
                    {
                      if (current_index != 3) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: ProfileScreen(),
                            type: PageTransitionType.rotate,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;
                  default:
                    {
                      if (current_index != 0) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: HomeScreen(model),
                            type: PageTransitionType.rotate,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
                    }
                    break;
                }
              },
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.red,
              iconSize: getDeviceHeight(context) * 0.04,
              currentIndex: model
                  .bottom_navbar_index, // this will be set when a new tab is tapped
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
        );
      },
    );
  }
}
