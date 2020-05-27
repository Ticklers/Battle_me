// import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/models/user.dart';
import 'package:battle_me/widgets/utilities/bottom_navbar.dart';
import 'package:battle_me/widgets/utilities/meme_card.dart';
import 'package:battle_me/widgets/utilities/preview_picture.dart';
import 'package:flutter/material.dart';
import 'package:battle_me/helpers/dimensions.dart';
import 'package:progressive_image/progressive_image.dart';

import '../scoped_models/main_scoped_model.dart';

class ProfileScreen extends StatefulWidget {
  final MainModel model;

  ProfileScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  User currentUser;
  TabController _tabController;
  List<Tab> tabList = List();
  bool preview = false;

  @override
  void initState() {
    currentUser = widget.model.authenticatedUser;
    tabList.add(new Tab(
      text: 'Feed',
    ));
    tabList.add(new Tab(
      text: 'Media',
    ));
    tabList.add(new Tab(
      text: 'Newest',
    ));
    _tabController =
        new TabController(vsync: this, length: tabList.length, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (preview) {
          setState(() {
            preview = false;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavbar(4),
        body: Stack(
          children: <Widget>[
            Container(
              height: getViewportHeight(context),
              width: getDeviceWidth(context),
              child: Column(
                children: <Widget>[
                  Container(
                    height: getViewportHeight(context) * 0.35,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/wallpaper.jpg',
                        height: getViewportHeight(context) * 0.3,
                        width: getDeviceWidth(context),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getViewportHeight(context) * 0.05,
                  ),
                  Container(
                    height: getViewportHeight(context) * 0.1,
                    // color: Colors.lightBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              currentUser.memes.length.toString(),
                              style: TextStyle(
                                  fontSize: getViewportHeight(context) * 0.035),
                            ),
                            subtitle: Text(
                              'Posts',
                              style: TextStyle(
                                  fontSize: getViewportHeight(context) * 0.018),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: RichText(
                              text: new TextSpan(
                                text: currentUser.followers.length < 1000
                                    ? currentUser.followers.length.toString()
                                    : (currentUser.followers.length < 1000000
                                        ? (currentUser.followers.length / 1000)
                                            .toStringAsFixed(1)
                                        : (currentUser.followers.length /
                                                1000000)
                                            .toStringAsFixed(1)),
                                style: TextStyle(
                                  fontSize: getViewportHeight(context) * 0.035,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                    text: currentUser.followers.length < 1000
                                        ? ''
                                        : (currentUser.followers.length <
                                                1000000
                                            ? 'K'
                                            : 'M'),
                                    style: new TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              'Followers',
                              style: TextStyle(
                                  fontSize: getViewportHeight(context) * 0.018),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: RichText(
                              text: new TextSpan(
                                text: currentUser.followings.length < 1000
                                    ? currentUser.followings.length.toString()
                                    : (currentUser.followings.length < 1000000
                                        ? (currentUser.followings.length / 1000)
                                            .toStringAsFixed(1)
                                        : (currentUser.followings.length /
                                                1000000)
                                            .toStringAsFixed(1)),
                                style: TextStyle(
                                  fontSize: getViewportHeight(context) * 0.035,
                                ),
                                children: <TextSpan>[
                                  new TextSpan(
                                    text: currentUser.followings.length < 1000
                                        ? ''
                                        : (currentUser.followings.length <
                                                1000000
                                            ? 'K'
                                            : 'M'),
                                    style: new TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            subtitle: Text(
                              'Following',
                              style: TextStyle(
                                  fontSize: getViewportHeight(context) * 0.018),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    child: new TabBar(
                      controller: _tabController,
                      labelColor: Colors.blue,
                      unselectedLabelColor: Theme.of(context).accentColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelPadding: EdgeInsets.symmetric(horizontal: 0.1),
                      tabs: <Widget>[
                        Tab(
                          text: 'Feed',
                        ),
                        Tab(
                          text: 'Media',
                        ),
                        Tab(
                          text: 'Activity',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: getViewportHeight(context) * 0.39,
                    child: new TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return MemeCard(
                              index: index,
                              model: widget.model,
                              feedList: widget.model.getFeedList,
                              onMemeIndexSelect: (int index) {
                                print(index);
                              },
                            );
                          },
                          itemCount: widget.model.getFeedList.length,
                        ),
                        Container(
                          color: Colors.blueGrey[100],
                          child: Center(
                            child: Text(
                              'You haven\'t posted any meme yet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getDeviceWidth(context) * 0.08,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return MemeCard(
                              index: index,
                              model: widget.model,
                              feedList: widget.model.getFeedList,
                              onMemeIndexSelect: (int index) {
                                print(index);
                              },
                            );
                          },
                          itemCount: widget.model.getFeedList.length,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.notifications_none,
                        ),
                        onPressed: () => null,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getViewportHeight(context) * 0.09,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: getViewportHeight(context) * 0.19,
                    // color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: getViewportHeight(context) * 0.22,
                            // color: Colors.yellow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    width: getViewportWidth(context) * 0.55,
                                    child: ListTile(
                                      title: Text(
                                        currentUser.name,
                                        style: TextStyle(
                                            fontSize:
                                                getViewportHeight(context) *
                                                    0.036),
                                      ),
                                      subtitle: Text(
                                        currentUser.username,
                                        style: TextStyle(
                                            fontSize:
                                                getViewportHeight(context) *
                                                    0.02),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Less Perfection, More Authencity.',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize:
                                          getViewportHeight(context) * 0.02,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    preview = true;
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      getViewportHeight(context) * 018),
                                  child: Hero(
                                    tag: 'preview',
                                    child: ProgressiveImage.assetNetwork(
                                      placeholder:
                                          'assets/images/wallpaper.jpg', // gifs can be used
                                      thumbnail: currentUser.avatar,
                                      image: currentUser.avatar,
                                      height: getViewportHeight(context) * 0.18,
                                      width: getViewportHeight(context) * 0.18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            preview
                ? Positioned(
                    top: getViewportHeight(context) * 0.2,
                    child: PreviewPicture(currentUser.avatar),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
