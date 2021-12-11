import 'package:flutter/foundation.dart';
import '../database/favourite_db.dart';

class FavouritesProvider extends ChangeNotifier {
  List posts = [];
  bool loading = true;

  getFavorites() async {
    FavouriteDB favouriteDB = FavouriteDB();
    setLoading(true);
    posts = await favouriteDB.listAll();
    setLoading(false);
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }
}
