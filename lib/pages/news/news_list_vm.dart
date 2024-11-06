
import 'package:flutter/cupertino.dart';
import 'package:flutter_starfish/api/api_news.dart';
import 'package:flutter_starfish/api/models/app_news_data.dart';

class NewsListViewModel with ChangeNotifier {

  List<AppNewsItemData>? bannerNews;
  List<AppNewsItemData>? hotNews;

  ///热门资讯
  Future getBannerNews() async {
    var news = await getNewsData(1);
    bannerNews = news ?? [];
    notifyListeners();
  }
  ///热门资讯
  Future getHotNews() async {
    var news = await getNewsData(2);
    hotNews = news ?? [];
    notifyListeners();
  }

  ///获取APP资讯
  ///[type] 1=最新咨询、2=热门资讯、3=雷区、4=行情、5=科普
  Future<List<AppNewsItemData>?> getNewsData(int type) async {
    AppNewsData data = await ApiNews.api.getAppNews(type);

    return data.newList;
  }

}