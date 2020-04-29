import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/helpers/my_flutter_app_icons.dart';
import 'package:battle_me/models/meme.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
// import 'package:battle_me/models/meme.dart';
import 'package:flutter/material.dart';

class MemeCard extends StatefulWidget {
  final index;
  final MainModel model;
  MemeCard(this.index, this.model);
  // final Meme meme;
  static double viewportHeight;
  static double viewportWidth;

  @override
  _MemeCardState createState() => _MemeCardState();
}

class _MemeCardState extends State<MemeCard> {
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
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 3,
      margin: EdgeInsets.symmetric(
          horizontal: MemeCard.viewportWidth * 0.001,
          vertical: MemeCard.viewportHeight * 0.005),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.white54,
        onTap: () {},
        child: Column(
          children: <Widget>[
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/dp.png',
                  height: getDeviceHeight(context) * 0.05,
                ),
              ),
              title: Text(
                'Rishabh Sharma',
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
                  icon: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: null),
            ),
            Container(
              height: getDeviceWidth(context),
              width: getDeviceWidth(context),
              child: Image.asset(
                'assets/images/meme.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    'Rishabhltfb',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: getViewportHeight(context) * 0.021),
                  ),
                  SizedBox(
                    width: getViewportWidth(context) * 0.04,
                  ),
                  Text(
                    meme.caption,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).accentColor,
                        fontSize: getViewportHeight(context) * 0.021),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      setLike(isLiked);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    MyFlutterApp.commenting_o,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: null,
                ),
                IconButton(
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
                    '1272 likes',
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
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
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
                              widget.model.createMeme(
                                  caption: comment,
                                  mode: 'onProfile',
                                  token:
                                      widget.model.getAuthenticatedUser.token,
                                  userId:
                                      widget.model.getAuthenticatedUser.userId);
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
                                color: Theme.of(context).accentColor, width: 1),
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
      ),
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
