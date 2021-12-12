import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../util/api.dart';
import '../util/enum/api_request_status.dart';
import '../models/category.dart';

class GenreProvider extends ChangeNotifier {
  List items = [];
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();

  getFeed(String url) async {
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      CategoryFeed feed = await api.getCategory(url);
      items = feed.feed.entry;
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
      throw (e);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
