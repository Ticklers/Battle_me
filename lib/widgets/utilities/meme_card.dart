import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/models/meme.dart';
import 'package:battle_me/models/user.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:battle_me/screens/other_profile_screen.dart';
import 'package:battle_me/screens/profile_screen.dart';
// import 'package:battle_me/models/meme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class MemeCard extends StatefulWidget {
  final index;
  final MainModel model;
  final IntCallback onMemeIndexSelect;
  MemeCard({this.index, this.model, this.onMemeIndexSelect});
  // final Meme meme;
  static double viewportHeight;
  static double viewportWidth;

  @override
  _MemeCardState createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
  User user;
  bool isLiked;
  String comment = null;
  Meme meme;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    meme = widget.model.getFeedList[widget.index];
    isLiked = false;
    checkLiked();
    super.initState();
  }

  bool checkLiked() {
    // print('Check liked init');
    if (meme.likes.length != 0) {
      // print('Fired!!!!!!!!!!!!');
      // print(meme.likes);
      bool fetchLike = meme.likes.any((obj) {
        if (obj['userId'] == widget.model.getAuthenticatedUser.userId) {
          return true;
        } else {
          return false;
        }
      });
      // print(fetchLike);
      setState(() {
        isLiked = fetchLike;
      });
    }
    return isLiked;
  }

  @override
  Widget build(BuildContext context) {
    MemeCard.viewportHeight = getViewportHeight(context);
    MemeCard.viewportWidth = getViewportWidth(context);
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        model.addListener(() {
          setState(() {
            meme = widget.model.getFeedList[widget.index];
          });
        });
        return Card(
          color: Theme.of(context).cardColor,
          elevation: 3,
          margin: EdgeInsets.symmetric(
              horizontal: MemeCard.viewportWidth * 0.001,
              vertical: MemeCard.viewportHeight * 0.005),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: GestureDetector(
                  onTap: () async {
                    if (meme.user != widget.model.getAuthenticatedUser.userId) {
                      CircularProgressIndicator();
                      await widget.model.findUser(meme.user).then((user) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: OtherProfileScreen(widget.model, user),
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      });
                    } else {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: ProfileScreen(widget.model),
                          type: PageTransitionType.fade,
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: ProgressiveImage.assetNetwork(
                      placeholder:
                          'assets/images/wallpaper.jpg', // gifs can be used
                      thumbnail: meme.avatar,
                      image: meme.avatar,
                      height: getViewportHeight(context) * 0.05,
                      width: getViewportHeight(context) * 0.05,
                    ),
                  ),
                ),
                title: Text(
                  meme.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getViewportHeight(context) * 0.021),
                ),
                subtitle: Text(
                  'Aligarh, U.P',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: getViewportHeight(context) * 0.018),
                ),
                trailing: IconButton(
                  splashColor: Theme.of(context).accentColor,
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    setState(() {
                      meme = widget.model.getFeedList[widget.index];
                    });
                  },
                ),
              ),
              Container(
                height: getDeviceWidth(context),
                width: getDeviceWidth(context),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: BlurHash(
                    hash: meme.mediaHash == null
                        ? r'LPAw6gRP%Mnhfkaya}WC01tRIUW?'
                        : meme.mediaHash,
                    image: meme.mediaLink,
                    imageFit: BoxFit.fill,
                  ),
                  // child: ProgressiveImage.assetNetwork(
                  //   placeholder:
                  //       'assets/images/placeholder_meme.jpg', // gifs can be used
                  //   thumbnail: meme.mediaLink,
                  //   image: meme.mediaLink,
                  //   height: getDeviceWidth(context),
                  //   width: getDeviceWidth(context),
                  //   fit: BoxFit.fill,
                  // ),
                ),
                // child: Image.asset(
                //   meme.media != null ? meme.media : 'assets/images/meme.png',
                //   fit: BoxFit.fill,
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      meme.username,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: getViewportHeight(context) * 0.021),
                    ),
                    SizedBox(
                      width: getViewportWidth(context) * 0.04,
                    ),
                    Expanded(
                      child: Text(
                        meme.caption,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).accentColor,
                            fontSize: getViewportHeight(context) * 0.021),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color:
                          isLiked ? Colors.red : Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                        setLike(isLiked);
                      });
                    },
                  ),
                  IconButton(
                    splashColor: Theme.of(context).accentColor,
                    icon: Icon(
                      MyFlutterApp.commenting_o,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      widget.onMemeIndexSelect(widget.index);
                    },
                  ),
                  IconButton(
                    splashColor: Theme.of(context).accentColor,
                    icon: Icon(
                      Icons.share,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '${meme.likes.length.toString()} likes',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).accentColor,
                thickness: 0.2,
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
                            comment = value;
                          },
                          onSaved: (String value) {
                            comment = value;
                          },
                          style: TextStyle(
                            fontSize: getViewportHeight(context) * 0.02,
                            color: Theme.of(context).accentColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            alignLabelWithHint: false,
                            // prefixIcon: Icon(
                            //   Icons.mail,
                            //   color: Theme.of(context).accentColor,
                            //   size: getViewportHeight(context) * 0.02,
                            // ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                                color: Theme.of(context).accentColor,
                                size: getViewportHeight(context) * 0.02,
                              ),
                              onPressed: () {
                                print('${comment}  is need to be send ');
                                meme.comments.insert(0, {
                                  "userId":
                                      widget.model.getAuthenticatedUser.userId,
                                  "avatar":
                                      widget.model.getAuthenticatedUser.avatar,
                                  "username": widget
                                      .model.getAuthenticatedUser.username,
                                  "comment": comment,
                                });

                                widget.onMemeIndexSelect(widget.index);
                                widget.model.commentMeme(
                                    comment: comment,
                                    memeId: meme.memeId,
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
              )
            ],
          ),
        );
      },
    );
  }

  void setLike(bool isLiked) {
    if (isLiked) {
      widget.model.likeMeme(
          memeId: meme.memeId, token: widget.model.getAuthenticatedUser.token);

      widget.model.meme_feed[widget.index].likes.add({
        "userId": widget.model.getAuthenticatedUser.userId,
      });
    } else {
      widget.model.unlikeMeme(
          memeId: meme.memeId, token: widget.model.getAuthenticatedUser.token);
      widget.model.meme_feed[widget.index].likes.any((obj) {
        if (obj['userId'] == widget.model.getAuthenticatedUser.userId) {
          widget.model.meme_feed[widget.index].likes.remove(obj);
          return true;
        } else {
          return false;
        }
      });
    }
  }
}

typedef IntCallback = void Function(int index);
