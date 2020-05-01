import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import '../models/meme.dart';
import './connected_scoped_model.dart';

class MemeModel extends ConnectedModel {
  List<Meme> get getFeedList {
    return List.from(meme_feed);
  }

  List<Meme> get getPopularMemeList {
    return List.from(popular_meme);
  }

  List<Meme> get getTrendingMemeList {
    return List.from(trending_meme);
  }

  List<Meme> get getuserMemeList {
    return List.from(user_meme);
  }

  Future<Null> fetchMeme(String listType) async {
    isLoading = true;
    notifyListeners();
    print('Inside fetch Meme');
    return await http
        .get(uri + 'api/memes/all')
        .then<Null>((http.Response response) {
      if (response.statusCode == 200) {
        print('fetch meme success');
        final List<Meme> fetchedMemeList = [];
        final Map<String, dynamic> memeListData =
            json.decode(response.body)['response'];
        if (memeListData['count'] == 0) {
          return;
        }
        memeListData['memes'].forEach((dynamic memeData) {
          final Meme entry = Meme(
            memeId: memeData['_id'],
            name: memeData['name'],
            username: memeData['username'],
            avatar: memeData['avatar'],
            caption: memeData['caption'],
            user: memeData['user'],
            date: memeData['date'],
            comments: memeData['comments'],
            likes: memeData['likes'],
            media: memeData['media'],
          );
          fetchedMemeList.add(entry);
        });
        meme_feed = fetchedMemeList;
        print(meme_feed.length);
        print('fetch meme ends');
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        print(
            "Fetch memes Error: ${json.decode(response.body)["error"].toString()}");
      }
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
      print("Fetch memes Error: ${error.toString()}");
      return;
    });
  }

  Future<String> createMeme(
      {Map<String, dynamic> formdata, String token}) async {
    isLoading = true;
    notifyListeners();
    print('Inside create meme : ' + isLoading.toString());
    Map<String, dynamic> req = formdata;
    // print(req);
    try {
      http.Response response = await http
          .post('${uri}api/memes/post', body: json.encode(req), headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });
      Map<String, dynamic> res = json.decode(response.body);
      ;
      // print(res);
      if (response.statusCode == 200) {
        res = json.decode(response.body);
        // print(res);

        isLoading = false;
        notifyListeners();
      }
      // print(res['_id']);
      return res['_id'];
    } catch (error) {
      print("Error in composing meme :  " + error.toString());
      isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<Null> likeMeme({String memeId, String token}) async {
    print('Inside Like meme');
    try {
      http.Response response =
          await http.post('${uri}api/addons/like/${memeId}', headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });
      Map<String, dynamic> res = json.decode(response.body);
      ;
      print(res);
      if (response.statusCode == 200) {
        res = json.decode(response.body);
        // print(res);
      }
      return;
    } catch (error) {
      print("Error in liking meme :  " + error.toString());
      return;
    }
  }

  Future<Null> unlikeMeme({String memeId, String token}) async {
    print('Inside unLike meme');
    try {
      http.Response response =
          await http.post('${uri}api/addons/unlike/${memeId}', headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });
      Map<String, dynamic> res = json.decode(response.body);
      if (response.statusCode == 200) {
        res = json.decode(response.body);
        print(res);
      }
      return;
    } catch (error) {
      print("Error in liking meme :  " + error.toString());
      return;
    }
  }
}
