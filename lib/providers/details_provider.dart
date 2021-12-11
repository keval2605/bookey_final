import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../database/favourite_db.dart';
import '../models/category.dart';
import '../util/api.dart';
import '../database/auth.dart';

class DetailsProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  CategoryFeed related = CategoryFeed();
  bool loading = true;
  Entry entry;
  var favDB = FavouriteDB();
  bool isFav = false;
  Api api = Api();

  getFeed(String url) async {
    setLoading(true);
    checkFav();
    try {
      CategoryFeed feed = await api.getCategory(url);
      setRelated(feed);
      setLoading(false);
    } catch (e) {
      throw (e);
    }
  }

  checkFav() async {
    String user_id = _auth.getUid();
    String book_id = entry.id.t.toString();
    bool c = await favDB.check(user_id + book_id);
    if (c) {
      setIsFav(true);
    } else {
      setIsFav(false);
    }
  }

  addFav() {
    String user_id = _auth.getUid();
    String book_id = entry.id.t.toString();
    favDB.add({
      'id': user_id + book_id,
      'item': entry.toJson()
    });
    checkFav();
  }

  removeFav() async {
    String user_id = _auth.getUid();
    String book_id = entry.id.t.toString();
    favDB.delete(user_id + book_id).then((v) {
      checkFav();
    });
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setRelated(value) {
    related = value;
    notifyListeners();
  }

  CategoryFeed getRelated() {
    return related;
  }

  void setEntry(value) {
    entry = value;
    notifyListeners();
  }

  void setIsFav(value) {
    isFav = value;
    notifyListeners();
  }
}
