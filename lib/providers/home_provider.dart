import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../util/api.dart';
import '../util/enum/api_request_status.dart';

class HomeProvider with ChangeNotifier {
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();

  getFeeds() async {
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      CategoryFeed popular = await api.getCategory(Api.popular);
      setTop(popular);
      CategoryFeed newReleases = await api.getCategory(Api.recent);
      setRecent(newReleases);
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  void setTop(value) {
    top = value;
    notifyListeners();
  }

  CategoryFeed getTop() {
    return top;
  }

  void setRecent(value) {
    recent = value;
    notifyListeners();
  }

  CategoryFeed getRecent() {
    return recent;
  }
}
