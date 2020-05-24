import 'dart:async';

import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/models/meme.dart';
import 'package:battle_me/screens/auth_screen.dart';
import 'package:battle_me/screens/chatbox_screen.dart';
import 'package:battle_me/widgets/utilities/bottom_navbar.dart';
import 'package:battle_me/widgets/utilities/comment_tile.dart';
import 'package:battle_me/widgets/utilities/meme_card.dart';
// import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String newcomment = null;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int commentIndex;
  List<Meme> feedList;
  bool newposts = false;
  ScrollController _scrollController = new ScrollController();

  showBottomSheet(context, index) {
    List comments = widget.model.getFeedList[index].comments;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 5,
      builder: (BuildContext context) {
        return Container(
          height: getDeviceHeight(context) * 0.7,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset.fromDirection(0.7),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Comments'),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: getViewportHeight(context) * 0.045,
                      width: getViewportWidth(context) * 0.8,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          onChanged: (String value) {
                            newcomment = value;
                          },
                          onSaved: (String value) {
                            newcomment = value;
                          },
                          style: TextStyle(
                            fontSize: getViewportHeight(context) * 0.02,
                            color: Theme.of(context).accentColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            alignLabelWithHint: false,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).accentColor,
                                size: getViewportHeight(context) * 0.02,
                              ),
                              onPressed: () {
                                print('${newcomment}  is need to be send ');
                                widget.model.getFeedList[index].comments
                                    .insert(0, {
                                  "userId":
                                      widget.model.getAuthenticatedUser.userId,
                                  "avatar":
                                      widget.model.getAuthenticatedUser.avatar,
                                  "username": widget
                                      .model.getAuthenticatedUser.username,
                                  "comment": newcomment,
                                });
                                widget.model.commentMeme(
                                    comment: newcomment,
                                    memeId:
                                        widget.model.getFeedList[index].memeId,
                                    token: widget
                                        .model.getAuthenticatedUser.token);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _formKey.currentState.reset();
                                // setState(() {
                                //   comment = '';
                                // });
                              },
                            ),
                            labelText: 'Comment',
                            labelStyle: TextStyle(
                              fontFamily: "Manrope",
                              fontSize: getViewportHeight(context) * 0.02,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w200,
                            ),
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: getViewportHeight(context) * 0.45,
                // color: Colors.amber,
                child: SingleChildScrollView(
                  child: Container(
                    height: getViewportHeight(context) * 0.44,
                    child: ListView.builder(
                      itemCount: comments.length,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return CommentTile(
                            comments[index], widget.model); // Add Comment tile
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget body(MainModel model) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          backgroundColor: Colors.blue,
          key: refreshIndicatorKey,
          onRefresh: _reloadHomeScreen,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: feedList.length,
            padding: EdgeInsets.symmetric(horizontal: 5),
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return MemeCard(
                  index: index,
                  model: widget.model,
                  feedList: feedList,
                  onMemeIndexSelect: (int index) {
                    showBottomSheet(context, index);
                  }); // Add Card
            },
          ),
        ),
        newposts
            ? Positioned(
                left: getDeviceWidth(context) / 2 - 50,
                child: FlatButton(
                  color: Colors.blue,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  textColor: Colors.white,
                  child: Text('New Posts'),
                  onPressed: () {
                    setState(() {
                      newposts = false;
                      makeChange(model);
                      // widget.model.newFeed = false;
                    });
                  },
                ),
              )
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    feedList = widget.model.getFeedList;
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        // newposts = false;
        // model.mainSocket.off('newFeed');
        model.mainSocket.on('newFeed', (data) {
          newposts = true;
        });
        return Scaffold(
          key: _scaffoldKey,
          // drawer: SideDrawer(),
          appBar: _getAppBar(model),
          bottomNavigationBar: BottomNavbar(0),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: body(model),
          ),
        );
      },
    );
  }

  AppBar _getAppBar(MainModel model) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          widget.model.logout();
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: AuthScreen(widget.model),
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 300),
            ),
          );
        },
        child: Hero(
          tag: "icon",
          child: Container(
            child: Image.asset('assets/images/icon.png'),
          ),
        ),
      ),
      title: Text('Tickle'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.send,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            model.joinNs('/chat');
            Timer(Duration(milliseconds: 200), () {
              Navigator.push(
                context,
                PageTransition(
                  child: ChatsPage(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 300),
                ),
              );
            });
          },
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.color,
    );
  }

  Future<Null> _reloadHomeScreen() async {
    widget.model.liveFeedFetch(widget.model.mainSocket);
  }

  makeChange(MainModel model) {
    // print('scroll hoja');
    setState(() {
      feedList = model.getFeedList;
    });
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 600),
    );
  }
}
